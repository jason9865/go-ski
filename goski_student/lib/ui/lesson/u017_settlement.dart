import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/datetime_util.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/const/util/text_formatter.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/view_model/settlement_view_model.dart';

class SettlementScreen extends StatefulWidget {
  const SettlementScreen({super.key});

  @override
  State<SettlementScreen> createState() => _SettlementScreenState();
}

class _SettlementScreenState extends State<SettlementScreen> {
  final settlementViewModel = Get.find<SettlementViewModel>();

  @override
  Widget build(BuildContext context) {
    final list = settlementViewModel.settlementList;

    return Obx(
      () => Scaffold(
        appBar: GoskiSubHeader(title: tr('paymentHistory')),
        body: GoskiContainer(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  // shrinkWrap: true,
                  itemCount: settlementViewModel.settlementList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SettlementExpansionCard(
                      dateTime: Row(
                        children: [
                          GoskiText(
                            text: DateTimeUtil.getDateTime(
                                list[index].paymentDate),
                            size: goskiFontSmall,
                          ),
                          const GoskiText(
                            text: " / ",
                            size: goskiFontSmall,
                          ),
                          GoskiText(
                            text: list[index].chargeName,
                            size: goskiFontSmall,
                            color: list[index].paymentStatus == 0
                                ? goskiBlack
                                : goskiRed,
                          )
                        ],
                      ),
                      title: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  GoskiText(
                                    text: list[index].teamName,
                                    size: goskiFontMedium,
                                  ),
                                  Visibility(
                                    visible:
                                    list[index].instructorName != null,
                                    child: GoskiText(
                                      text:
                                      list[index].instructorName != null
                                          ? list[index].instructorName!
                                          : '',
                                      size: goskiFontSmall,
                                      color: goskiDarkGray,
                                    ),
                                  ),
                                ],
                              ),
                              GoskiText(
                                text: list[index].paymentStatus == 0
                                    ? formatFromInt(list[index].totalAmount)
                                    : '+ ${formatFromInt(list[index].totalAmount)}',
                                size: goskiFontMedium,
                                color: list[index].paymentStatus == 0
                                    ? goskiBlack
                                    : goskiRed,
                              )
                            ],
                          ),
                        ],
                      ),
                      subTitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            color: goskiDashGray,
                          ),
                          Visibility(
                            visible: list[index].basicFee > 0,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                GoskiText(
                                  text: tr('basicFee'),
                                  size: goskiFontSmall,
                                ),
                                GoskiText(
                                  text: formatFromInt(
                                      list[index].basicFee),
                                  size: goskiFontSmall,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: list[index].designatedFee > 0,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                GoskiText(
                                  text: tr('designatedFee'),
                                  size: goskiFontSmall,
                                ),
                                GoskiText(
                                  text:
                                  '+ ${formatFromInt(list[index].designatedFee)}',
                                  size: goskiFontSmall,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: list[index].peopleOptionFee > 0,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                GoskiText(
                                  text: tr('peopleOptionFee'),
                                  size: goskiFontSmall,
                                ),
                                GoskiText(
                                  text:
                                  '+ ${formatFromInt(list[index].peopleOptionFee)}',
                                  size: goskiFontSmall,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: list[index].levelOptionFee > 0,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                GoskiText(
                                  text: tr('peopleOptionFee'),
                                  size: goskiFontSmall,
                                ),
                                GoskiText(
                                  text:
                                  '+ ${formatFromInt(list[index].levelOptionFee)}',
                                  size: goskiFontSmall,
                                ),
                              ],
                            ),
                          ),
                          // TODO: 쿠폰 등 할인 관련 처리 필요
                        ],
                      ),
                      onExpandBtnClicked: () {
                        setState(() {
                          list[index].isExpanded = !list[index].isExpanded;
                        });
                      },
                      isExpanded: list[index].isExpanded,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 확장 카드 위젯
class SettlementExpansionCard extends StatelessWidget {
  final Widget dateTime;
  final VoidCallback onExpandBtnClicked;
  final Widget title;
  final Widget subTitle;
  final bool isExpanded;

  const SettlementExpansionCard({
    super.key,
    required this.dateTime,
    required this.onExpandBtnClicked,
    required this.title,
    required this.subTitle,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final horizontalPadding = screenSizeController.getWidthByRatio(0.03);
    const animationDuration = 200;

    return InkWell(
      onTap: onExpandBtnClicked,
      child: GoskiCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: horizontalPadding,
                left: horizontalPadding,
                right: horizontalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dateTime,
                  AnimatedRotation(
                    duration: const Duration(milliseconds: animationDuration),
                    turns: isExpanded ? 0.5 : 0,
                    child: Icon(
                        size: screenSizeController.getWidthByRatio(0.06),
                        Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: horizontalPadding,
                left: horizontalPadding,
                right: horizontalPadding,
              ),
              child: SettlementItem(
                title: title,
                subTitle: subTitle,
                isExpanded: isExpanded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettlementItem extends StatelessWidget {
  final Widget title;
  final Widget subTitle;
  final bool isExpanded;

  const SettlementItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final titlePadding = screenSizeController.getHeightByRatio(0.010);
    const animationDuration = 200;

    return Column(
      children: [
        SizedBox(height: titlePadding),
        title,
        SizedBox(height: titlePadding),
        AnimatedSize(
          duration: const Duration(milliseconds: animationDuration),
          child: Visibility(
            visible: isExpanded,
            replacement: SizedBox(
              width: screenSizeController.getWidthByRatio(1),
            ),
            child: subTitle,
          ),
        ),
      ],
    );
  }
}
