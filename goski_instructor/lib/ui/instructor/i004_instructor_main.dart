import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_build_interval.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class InstructorMainScreen extends StatelessWidget {
  final List<TeamInfo> teamList = [
    TeamInfo(
        teamName: '팀이름1',
        teamImage: 'assets/images/penguin.png',
        teamIntroduction: '1팀소개입니다.'),
    TeamInfo(
        teamName: '팀이름2',
        teamImage: 'assets/images/penguin.png',
        teamIntroduction: '2팀소개입니다.'),
    TeamInfo(
        teamName: '팀이름3',
        teamImage: 'assets/images/penguin.png',
        teamIntroduction: '3팀소개입니다.'),
  ];
  final List<String> tiemList = [
    '8시',
    '9시',
    '10시',
    '11시',
    '12시',
    '13시',
    '14시',
    '15시',
    '16시',
  ];
  InstructorMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GoskiContainer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildProfile(),
            const BuildInterval(),
            buildPageView(),
            const BuildInterval(),
            GoskiCard(
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: goskiDarkGray,
                    ),
                    height: 1000,
                    width: screenSizeController.getWidthByRatio(0.13),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenSizeController.getHeightByRatio(0.05),
                          width: double.infinity,
                        ),
                        const BuildTimeContainer(),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: goskiDarkGray,
                    ),
                    height: 1000,
                    width: screenSizeController.getWidthByRatio(0.25),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: goskiWhite,
                          ),
                          height: screenSizeController.getHeightByRatio(0.1),
                          width: screenSizeController.getWidthByRatio(0.25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image:
                                        AssetImage("assets/images/person1.png"),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              GoskiText(
                                text: tr('임종율'),
                                size: goskiFontLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProfile() {
    final profileSize = screenSizeController.getWidthByRatio(0.25);
    return GoskiCard(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenSizeController.getHeightByRatio(0.02),
          horizontal: screenSizeController.getWidthByRatio(0.07),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: profileSize,
                  height: profileSize,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage("assets/images/person1.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GoskiText(
                      text: tr('임종율'),
                      size: goskiFontXXLarge,
                    ),
                    GoskiText(
                      text: tr('dynamicInstructor', args: ['']),
                      size: goskiFontXLarge,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: screenSizeController.getHeightByRatio(0.03),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UserMenu(
                  iconName: 'couponBox',
                  iconImage: 'assets/images/couponBox.svg',
                  onClick: () => logger.d("쿠폰함"),
                ),
                UserMenu(
                  iconName: 'reviewHistory',
                  iconImage: 'assets/images/reviewHistory.svg',
                  onClick: () => logger.d("리뷰 내역"),
                ),
                UserMenu(
                  iconName: 'lessonHistory',
                  iconImage: 'assets/images/lessonHistory.svg',
                  onClick: () => logger.d("강습"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageView() {
    return SizedBox(
      height: screenSizeController.getHeightByRatio(0.18),
      child: PageView.builder(
        itemCount: teamList.length,
        itemBuilder: (context, index) {
          return GoskiCard(
            child: Row(
              children: [
                Container(
                  width: screenSizeController.getWidthByRatio(0.3),
                  height: screenSizeController.getHeightByRatio(0.13),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(teamList[index].teamImage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                SizedBox(width: screenSizeController.getWidthByRatio(0.02)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GoskiText(
                          text: teamList[index].teamName,
                          size: goskiFontXLarge),
                      SizedBox(
                        height: screenSizeController.getHeightByRatio(0.02),
                      ),
                      GoskiText(
                          text: teamList[index].teamIntroduction,
                          size: goskiFontLarge),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BuildTimeContainer extends StatelessWidget {
  const BuildTimeContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenSizeController.getHeightByRatio(0.1),
      width: double.infinity,
      child: const Center(
        child: GoskiText(
          text: '8시',
          size: goskiFontLarge,
        ),
      ),
    );
  }
}

class UserMenu extends StatelessWidget {
  final String iconName;
  final String iconImage;
  final VoidCallback onClick;

  const UserMenu({
    required this.iconName,
    required this.iconImage,
    required this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          iconImage,
          width: 45,
          height: 45,
          colorFilter: const ColorFilter.mode(
            goskiBlack,
            BlendMode.srcIn,
          ),
        ),
        GoskiText(
          text: tr(
            iconName,
          ),
          size: goskiFontLarge,
        )
      ],
    );
  }
}

class TeamInfo {
  final String teamName;
  final String teamImage;
  final String teamIntroduction;

  TeamInfo(
      {required this.teamName,
      required this.teamImage,
      required this.teamIntroduction});
}
