import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/ui/component/goski_select_grid.dart';
import 'package:goski_student/ui/component/goski_switch.dart';

import '../../const/font_size.dart';
import '../../const/util/screen_size_controller.dart';
import '../../const/util/student_info_list.dart';
import '../component/goski_smallsize_button.dart';
import '../component/goski_text.dart';
import '../component/goski_textfield.dart';

class InputStudentInfoDialog extends StatefulWidget {
  const InputStudentInfoDialog({super.key});

  @override
  State<InputStudentInfoDialog> createState() => _InputStudentInfoDialogState();
}

class _InputStudentInfoDialogState extends State<InputStudentInfoDialog> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GoskiText(
              text: tr('name'),
              size: goskiFontLarge,
              isBold: true,
            ),
            SizedBox(height: titlePadding),
            GoskiTextField(
              hintText: tr('hintName'),
              onTextChange: (text) {
                // TODO: 로직 추가 필요
              },
            ),
            SizedBox(height: contentPadding),
            GoskiText(
              text: tr('gender'),
              size: goskiFontLarge,
              isBold: true,
            ),
            SizedBox(height: titlePadding),
            LayoutBuilder(
              builder: (context, constraints) {
                double parentWidth = constraints.maxWidth;
                return GoskiSwitch(
                  items: [tr('MALE'), tr('FEMALE')],
                  width: parentWidth,
                );
              },
            ),
            SizedBox(height: contentPadding),
            GoskiText(
              text: tr('height'),
              size: goskiFontLarge,
              isBold: true,
            ),
            SizedBox(height: titlePadding),
            GoskiSelectGrid(
              items: StudentInfoList().heightList,
              rows: 2,
              onItemClicked: (index) {
              },
            ),
            SizedBox(height: contentPadding),
            GoskiText(
              text: tr('age'),
              size: goskiFontLarge,
              isBold: true,
            ),
            SizedBox(height: titlePadding),
            GoskiSelectGrid(
              items: StudentInfoList().ageList,
              rows: 2,
              onItemClicked: (index) {
              },
            ),
            SizedBox(height: contentPadding),
            GoskiText(
              text: tr('weight'),
              size: goskiFontLarge,
              isBold: true,
            ),
            SizedBox(height: titlePadding),
            GoskiSelectGrid(
              items: StudentInfoList().weightList,
              rows: 2,
              onItemClicked: (index) {
              },
            ),
            SizedBox(height: contentPadding),
            GoskiText(
              text: tr('feetSize'),
              size: goskiFontLarge,
              isBold: true,
            ),
            SizedBox(height: titlePadding),
            GoskiTextField(
              hintText: tr('hintFeetSize'),
              isDigitOnly: true,
              onTextChange: (text) {
                // TODO: 로직 추가 필요
              },
            ),
            SizedBox(height: contentPadding * 2),
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
                  text: tr('confirm'),
                  onTap: () {
                    // TODO. 보내기 버튼 동작 추가 필요
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

class DummyStudentInfo {
  String name = '';
  int gender = 0; // 0 남성, 1여성
  int height = 0;
  int age = 0;
  int weight = 0;
  int feetSize = 0;
}
