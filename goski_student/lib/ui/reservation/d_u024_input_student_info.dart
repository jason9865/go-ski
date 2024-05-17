import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/data/model/student_info.dart';
import 'package:goski_student/main.dart';
import 'package:goski_student/ui/component/goski_select_grid.dart';
import 'package:goski_student/ui/component/goski_switch.dart';
import 'package:goski_student/ui/lesson/u023_lesson_reservation.dart';

import '../../const/font_size.dart';
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
    final titlePadding = screenSizeController.getHeightByRatio(0.005);
    final contentPadding = screenSizeController.getHeightByRatio(0.015);
    var studentInfo = StudentInfo();

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
                studentInfo.name = text;
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
                  onToggle: (selectedType) {
                    selectedType == 0
                        ? studentInfo.gender = 'MALE'
                        : studentInfo.gender = 'FEMALE';
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
                studentInfo.height =
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
                studentInfo.age = studentInfoSelectList.ageList[index].name;
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
                studentInfo.weight =
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
                studentInfo.footSize = int.parse(text.replaceAll(',', ''));
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
                    if (studentInfo.isValid()) {
                      if (studentInfo.footSize % 10 == 0 &&
                          studentInfo.footSize >= 100 &&
                          studentInfo.footSize <= 350) {
                        studentInfoViewModel.addStudentInfo(studentInfo);
                        Navigator.pop(context);
                      } else {
                        showCheckFootSizeDialog(context);
                      }
                    } else {
                      String content = '';

                      if (studentInfo.name == '') {
                          content = tr('pleaseEnterStudentName');
                      } else if (studentInfo.height == '') {
                        content = tr('pleaseEnterStudentHeight');
                      } else if (studentInfo.age == '') {
                        content = tr('pleaseEnterStudentAge');
                      } else if (studentInfo.weight == '') {
                        content = tr('pleaseEnterStudentWeight');
                      } else {
                        content = tr('pleaseEnterStudentFootSize');
                      }

                      showCompleteStudentInfoDialog(context, content);
                    }
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

void showCompleteStudentInfoDialog(BuildContext context, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: GoskiText(
          text: tr('incompleteInformation'),
          size: goskiFontLarge,
        ),
        content: GoskiText(
          text: content,
          size: goskiFontMedium,
        ),
        actions: <Widget>[
          TextButton(
            child: GoskiText(
              text: tr('confirm'),
              size: goskiFontMedium,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}

void showCheckFootSizeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: GoskiText(
          text: tr('rewriteFootSize'),
          size: goskiFontLarge,
        ),
        content: GoskiText(
          text: tr('feetSizeDialogContent'),
          size: goskiFontMedium,
        ),
        actions: <Widget>[
          TextButton(
            child: GoskiText(
              text: tr('confirm'),
              size: goskiFontMedium,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
