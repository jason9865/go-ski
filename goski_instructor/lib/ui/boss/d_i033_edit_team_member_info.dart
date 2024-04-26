import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/ui/component/goski_textfield.dart';

import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../const/util/screen_size_controller.dart';
import '../common/d_i008_notification_setting.dart';
import '../common/d_i018_add_external_schedule.dart';
import '../component/goski_smallsize_button.dart';
import '../component/goski_text.dart';

class EditTeamMemberInfoDialog extends StatefulWidget {
  const EditTeamMemberInfoDialog({super.key});

  @override
  State<EditTeamMemberInfoDialog> createState() =>
      _EditTeamMemberInfoDialogState();
}

class _EditTeamMemberInfoDialogState extends State<EditTeamMemberInfoDialog> {
  final List permissionList = [
    tr('permissionInviteTeam'),
    tr('permissionAddTeam'),
    tr('permissionEditTeam'),
    tr('permissionDeleteTeam'),
  ];
  final List permissionIsCheckedList = [false, true, true, false];

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final titlePadding = screenSizeController.getHeightByRatio(0.005);
    final contentPadding = screenSizeController.getHeightByRatio(0.015);

    return Flexible(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red, // TODO. 사진 크기가 잘 보이도록 배경 추가 실제 사용시 배경 제거 필요
                    borderRadius: BorderRadius.circular(10)
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    'assets/images/penguin.png',
                    width: screenSizeController.getWidthByRatio(0.2),
                    height: screenSizeController.getWidthByRatio(0.25),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: screenSizeController.getWidthByRatio(0.25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TitleAlignCenterWithInputRow(
                          title: tr('position'),
                          child: _TightPaddingBorderWhiteContainer(
                            child: TextWithIconRow(
                              text: tr('hintPosition'),
                              icon: Icons.keyboard_arrow_down,
                              onClicked: () {},
                            ),
                          ),
                        ),
                        SizedBox(height: titlePadding),
                        TitleAlignCenterWithInputRow(
                          title: tr('name'),
                          child: const GoskiText(
                            text: 'OOO',
                            size: goskiFontMedium,
                          ),
                        ),
                        SizedBox(height: titlePadding * 1.5),
                        TitleAlignCenterWithInputRow(
                          title: tr('phoneNumber'),
                          child: const GoskiText(
                            text: '010-0000-0000',
                            size: goskiFontMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: contentPadding,
            ),
            SizedBox(
              width: double.infinity,
              child: GoskiText(
                text: tr('setLessonPrice'),
                size: goskiFontLarge,
                isBold: true,
              ),
            ),
            SizedBox(
              height: titlePadding,
            ),
            GoskiTextField(
              hintText: tr('hintSetLessonPrice'),
            ),
            SizedBox(
              height: contentPadding,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: permissionList.length,
              itemBuilder: (context, index) {
                return NotificationSettingRow(
                    title: permissionList[index],
                    isChecked: permissionIsCheckedList[index],
                    onClicked: (value) {
                      setState(() {
                        permissionIsCheckedList[index] = value;
                      });
                    });
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: screenSizeController.getHeightByRatio(0.02),
                );
              },
            ),
            SizedBox(
              height: contentPadding * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GoskiSmallsizeButton(
                  width: screenSizeController.getWidthByRatio(1),
                  text: tr('cancel'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                GoskiSmallsizeButton(
                  width: screenSizeController.getWidthByRatio(1),
                  text: tr('save'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TitleAlignCenterWithInputRow extends StatelessWidget {
  final String title;
  final Widget child;
  final int titleRatio;
  final double fontSize;

  const TitleAlignCenterWithInputRow({
    super.key,
    required this.title,
    required this.child,
    this.titleRatio = 4,
    this.fontSize = goskiFontMedium,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: titleRatio,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GoskiText(
                text: title,
                size: fontSize,
                isBold: true,
              ),
            ],
          ),
        ),
        Flexible(
          flex: 10 - titleRatio,
          child: child,
        ),
      ],
    );
  }
}

class _TightPaddingBorderWhiteContainer extends StatelessWidget {
  final Widget? child;

  const _TightPaddingBorderWhiteContainer({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final horizontalPadding = screenSizeController.getWidthByRatio(0.015);
    final verticalPadding = screenSizeController.getWidthByRatio(0.005);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      decoration: BoxDecoration(
          color: goskiWhite,
          border: Border.all(width: 1, color: goskiDarkGray),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
