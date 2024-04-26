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
import 'package:goski_instructor/ui/component/goski_floating_button.dart';
import 'package:goski_instructor/ui/component/goski_instructor_card.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

class TeamListScreen extends StatelessWidget {
  TeamListScreen({
    super.key,
  });

  // 추후 API연동 후 response로 대체
  // 추가로 position(직급)에 따라 Color를 자동으로 설정하면 좋을듯.
  final List<Instructor> instructors = [
    Instructor(
      position: '교육팀장',
      badgeColor: goskiBlue,
      name: '고승민',
      phoneNumber: '123-456-7890',
    ),
    Instructor(
        position: '팀장',
        badgeColor: goskiGreen,
        name: '임종율',
        phoneNumber: '123-456-7890',
        imagePath: 'assets/images/person1.png'),
    Instructor(
        position: '코치',
        badgeColor: goskiDarkGray,
        name: '김태훈',
        phoneNumber: '123-456-7890',
        imagePath: 'assets/images/person2.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();

    return Scaffold(
        body: GoskiContainer(
          child: GoskiCard(
              child: Column(children: [
            // 팀원 목록 + 팀원 초대 버튼
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              GoskiText(
                text: tr('TeamList'),
                size: goskiFontLarge,
                isBold: true,
              ),
              // GoskiSmallsizeButton(
              //     width: screenSizeController.getWidthByRatio(1),
              //     text: tr('inviteTeammate'),
              //     onTap: () {
              //       print('팀원 초대 버튼');
              //     })
            ]),
            SizedBox(
              height: screenSizeController.getHeightByRatio(0.02),
            ),
            // 팀원 리스트
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: instructors.length,
                itemBuilder: (BuildContext context, int index) {
                  final instructor = instructors[index];

                  return GoskiInstructorCard(
                    position: instructor.position,
                    badgeColor: instructor.badgeColor,
                    name: instructor.name,
                    phoneNumber: instructor.phoneNumber,
                    imagePath: instructor.imagePath,
                  );
                },
              ),
            ),
          ])),
        ),
        floatingActionButton: GoskiFloatingButton(
          onTap: () {
            print("Floating Action Button");
          },
        ));
  }
}

// 추후 API연동 후 response로 대체
class Instructor {
  final String position;
  final Color badgeColor;
  final String name;
  final String phoneNumber;
  final String imagePath;

  Instructor({
    required this.position,
    required this.badgeColor,
    required this.name,
    required this.phoneNumber,
    this.imagePath = 'assets/images/penguin.png',
  });
}
