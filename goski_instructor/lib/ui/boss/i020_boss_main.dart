import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_middlesize_button.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

class BossMainScreen extends StatelessWidget {
  const BossMainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final imageSize = screenSizeController.getWidthByRatio(0.2);
    onTap() {
      print("버튼 클릭");
    }

    final List<_SkiTeam> skiTeamList = [
      _SkiTeam(
          teamName: "고승민",
          resortName: "지산리조트",
          teamProfileImage: "assets/images/person3.png"),
      _SkiTeam(teamName: "임종율의 보드교실", resortName: "예비군"),
      _SkiTeam(teamName: "송준석의 코딩교실", resortName: "멀티캠퍼스"),
      _SkiTeam(
          teamName: "고승민의 스키교실",
          resortName: "지산리조트",
          teamProfileImage: "assets/images/person3.png"),
      _SkiTeam(teamName: "임종율의 보드교실", resortName: "예비군"),
      _SkiTeam(teamName: "송준석의 코딩교실", resortName: "멀티캠퍼스"),
      _SkiTeam(
          teamName: "고승민의 스키교실",
          resortName: "지산리조트",
          teamProfileImage: "assets/images/person3.png"),
      _SkiTeam(teamName: "임종율의 보드교실", resortName: "예비군"),
      _SkiTeam(teamName: "송준석의 코딩교실", resortName: "멀티캠퍼스"),
    ];

    return GoskiContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 사장 메인 카드
          SizedBox(
            child: GoskiCard(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                          color: goskiLightGray,
                          border: Border(
                              bottom: BorderSide(
                            color: goskiDashGray,
                            width: 1.0, // 경계선 두께
                            style: BorderStyle.solid,
                          ))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: imageSize,
                              height: imageSize,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/logo.png'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GoskiText(
                                  text: tr('최지찬'),
                                  size: goskiFontXXLarge,
                                ),
                                GoskiText(
                                  text: tr('helloBoss'),
                                  size: goskiFontLarge,
                                  color: goskiDarkGray,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GoskiText(
                            text: tr('availableWithdrawal'),
                            size: goskiFontLarge),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GoskiText(
                              text: tr('xxxxxxxx원'),
                              size: goskiFontLarge,
                              isBold: true,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenSizeController.getHeightByRatio(0.01),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GoskiMiddlesizeButton(
                                width: screenSizeController.getWidthByRatio(1),
                                text: tr('settlement'),
                                onTap: onTap),
                            GoskiMiddlesizeButton(
                                width: screenSizeController.getWidthByRatio(1),
                                text: tr('myAccount'),
                                onTap: onTap),
                            GoskiMiddlesizeButton(
                                width: screenSizeController.getWidthByRatio(1),
                                text: tr('sendMyAccount'),
                                onTap: onTap),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // 사장 보유 팀 리스트
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: skiTeamList.length,
                itemBuilder: (BuildContext context, int index) {
                  final skiTeam = skiTeamList[index];

                  return GoskiCard(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: imageSize,
                                height: imageSize,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(skiTeam.teamProfileImage),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              GoskiText(
                                text:
                                    tr('skiTeamName', args: [skiTeam.teamName]),
                                size: goskiFontLarge,
                                isBold: true,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenSizeController.getHeightByRatio(0.01),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GoskiMiddlesizeButton(
                                  width:
                                      screenSizeController.getWidthByRatio(1),
                                  text: tr('teamSchedule'),
                                  onTap: onTap),
                              GoskiMiddlesizeButton(
                                  width:
                                      screenSizeController.getWidthByRatio(1),
                                  text: tr('updateTeamInfo'),
                                  onTap: onTap),
                              GoskiMiddlesizeButton(
                                  width:
                                      screenSizeController.getWidthByRatio(1),
                                  text: tr('settlement'),
                                  onTap: onTap),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class _SkiTeam {
  final String teamName;
  final String resortName;
  final String teamProfileImage;

  _SkiTeam(
      {required this.teamName,
      required this.resortName,
      this.teamProfileImage = "assets/images/penguin.png"});
}
