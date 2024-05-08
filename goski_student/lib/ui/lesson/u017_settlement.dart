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

class SettlementScreen extends StatelessWidget {
  final settlementViewModel = Get.find<SettlementViewModel>();

  SettlementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
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
                    return GoskiCard(
                      child: ListTileTheme(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12.0,
                        ),
                        horizontalTitleGap: 0,
                        minLeadingWidth: 0,
                        dense: true,
                        child: ExpansionTile(
                          childrenPadding: EdgeInsets.only(
                              bottom:
                                  screenSizeController.getWidthByRatio(0.03)),
                          visualDensity: VisualDensity.compact,
                          iconColor: goskiBlack,
                          collapsedIconColor: goskiBlack,
                          shape: const Border(),
                          collapsedShape: const Border(),
                          expandedAlignment: Alignment.centerLeft,
                          title: Row(
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
                          subtitle: Column(
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
                                        : '+${formatFromInt(list[index].totalAmount)}',
                                    size: goskiFontMedium,
                                    color: list[index].paymentStatus == 0
                                        ? goskiBlack
                                        : goskiRed,
                                  )
                                ],
                              ),
                            ],
                          ),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
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
                                          text: formatFromInt(list[index].basicFee),
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
                                          text: '+${formatFromInt(list[index].designatedFee)}',
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
                                              '+${formatFromInt(list[index].peopleOptionFee)}',
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
                                              '+${formatFromInt(list[index].levelOptionFee)}',
                                          size: goskiFontSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // TODO: 쿠폰 등 할인 관련 처리 필요
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
