import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class SettlementScreen extends StatelessWidget {
  const SettlementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();

    // TODO. 정상결제가 아닌 건에 대한 처리 필요 (빨간색 글씨, 환불 완료, 부분 환불 등)
    return GoskiContainer(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                // shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return GoskiCard(
                    child: ListTileTheme(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
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
                                text: "2024.04.11 09:25",
                                size: goskiFontSmall,
                              ),
                              GoskiText(text: " / ", size: goskiFontSmall),
                              GoskiText(
                                text: "정상결제",
                                size: goskiFontSmall,
                              )
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GoskiText(
                                      text: "고승민의 스키교실", size: goskiFontMedium),
                                  GoskiText(
                                      text: "170,000원", size: goskiFontMedium)
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // 만약 지정강사예약이라면
                                  GoskiText(
                                    text: '강사명',
                                    size: goskiFontSmall,
                                    color: goskiDarkGray,
                                  ),
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
                                  Divider(
                                    color: goskiDashGray,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GoskiText(
                                          text: '기본요금', size: goskiFontSmall),
                                      GoskiText(
                                          text: '+100,000원',
                                          size: goskiFontSmall),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GoskiText(
                                          text: '지정강사비', size: goskiFontSmall),
                                      GoskiText(
                                          text: '+30,000원',
                                          size: goskiFontSmall),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GoskiText(
                                          text: '인원옵션금액', size: goskiFontSmall),
                                      GoskiText(
                                          text: '+40,000원',
                                          size: goskiFontSmall),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GoskiText(
                                          text: '레벨옵션금액', size: goskiFontSmall),
                                      GoskiText(
                                          text: '+20,000원',
                                          size: goskiFontSmall),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GoskiText(
                                          text: '부분환불', size: goskiFontSmall),
                                      GoskiText(
                                          text: '-85,000원',
                                          size: goskiFontSmall),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
