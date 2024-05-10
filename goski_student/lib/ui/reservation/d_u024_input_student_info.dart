import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/data/model/student_info.dart';
import 'package:goski_student/main.dart';
import 'package:goski_student/ui/component/goski_select_grid.dart';
import 'package:goski_student/ui/component/goski_switch.dart';
import 'package:goski_student/ui/lesson/u023_lesson_reservation.dart';

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
  final studentInfoSelectList = StudentInfoSelectList();

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final titlePadding = screenSizeController.getHeightByRatio(0.005);
    final contentPadding = screenSizeController.getHeightByRatio(0.015);
    var _studentInfo = StudentInfo();

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
                _studentInfo.name = text;
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
                  items: ['남자', '여자'],
                  width: parentWidth,
                  // TODO : 남자인지 여자인지 저장
                  onToggle: (selectedType) {
                    selectedType == 0
                        ? _studentInfo.gender = 'MALE'
                        : _studentInfo.gender = 'FEMALE';
                  },
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
              items: studentInfoSelectList.heightList,
              rows: 2,
              onItemClicked: (index) {
                _studentInfo.height =
                    studentInfoSelectList.heightList[index].name;
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
              items: studentInfoSelectList.ageList,
              rows: 2,
              onItemClicked: (index) {
                _studentInfo.age = studentInfoSelectList.ageList[index].name;
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
              items: studentInfoSelectList.weightList,
              rows: 2,
              onItemClicked: (index) {
                _studentInfo.weight =
                    studentInfoSelectList.weightList[index].name;
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
                _studentInfo.footSize = int.parse(text);
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
                    if (_studentInfo.isValid()) {
                      logger.d(_studentInfo.toString());
                      studentInfoViewModel.addStudentInfo(_studentInfo);
                      Navigator.pop(context);
                    } else
                      logger.e("전체 작성 미완료 ${_studentInfo.toString()}");
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
