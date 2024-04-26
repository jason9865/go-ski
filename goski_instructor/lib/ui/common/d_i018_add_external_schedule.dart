import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/ui/component/goski_switch.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/ui/component/goski_textfield.dart';
import 'package:goski_instructor/ui/instructor/d_i013_lesson_detail.dart';

import '../../const/util/screen_size_controller.dart';
import '../component/goski_smallsize_button.dart';

class AddExternalScheduleDialog extends StatelessWidget {
  const AddExternalScheduleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final titlePadding = screenSizeController.getHeightByRatio(0.010);
    final contentPadding = screenSizeController.getHeightByRatio(0.015);

    return Flexible(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWithInputRow(
              title: tr('mainInstructor'),
              text: tr('hintMainInstructor'),
              icon: Icons.keyboard_arrow_down,
              onClicked: () {
                // TODO. 담당 강사 클릭시 동작 추가 필요
              },
            ),
            SizedBox(height: contentPadding),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: GoskiText(
                    text: tr('type'),
                    size: goskiFontLarge,
                    isBold: true,
                  ),
                ),
                Flexible(
                  flex: 6,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double parentWidth = constraints.maxWidth;
                      return GoskiSwitch(
                        items: [tr('ski'), tr('board'), tr('rest')],
                        width: parentWidth,
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: contentPadding),
            SizedBox(
              width: double.infinity,
              child: GoskiText(
                text: tr('selectDateTime'),
                size: goskiFontLarge,
                isBold: true,
              ),
            ),
            SizedBox(height: titlePadding),
            BorderWhiteContainer(
              child: TextWithIconRow(
                text: tr('hintDate'),
                icon: Icons.calendar_month,
                onClicked: () {
                  // TODO. 날짜 선택 버튼을 눌렀을 때 동작 추가 필요
                },
              ),
            ),
            SizedBox(height: titlePadding),
            BorderWhiteContainer(
              child: TextWithIconRow(
                text: tr('hintTime'),
                icon: Icons.access_time_rounded,
                onClicked: () {
                  // TODO. 시간 선택 버튼을 눌렀을 때 동작 추가 필요
                },
              ),
            ),
            SizedBox(height: contentPadding),
            TitleWithInputRow(
              title: tr('studentNumber'),
              text: tr('hintStudentNumber'),
              icon: Icons.keyboard_arrow_down,
              onClicked: () {
                // TODO. 인원 선택 클릭시 동작 추가 필요
              },
            ),
            SizedBox(height: contentPadding),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: GoskiText(
                    text: tr('reservationPerson'),
                    size: goskiFontLarge,
                    isBold: true,
                  ),
                ),
                Flexible(
                  flex: 6,
                  child: GoskiTextField(
                    hintText: tr('hintReservationPerson'),
                    hasInnerPadding: false,
                  ),
                ),
              ],
            ),
            SizedBox(height: contentPadding),
            SizedBox(
              width: double.infinity,
              child: GoskiText(
                text: tr('specialNote'),
                size: goskiFontLarge,
                isBold: true,
              ),
            ),
            SizedBox(height: titlePadding),
            Flexible(
              flex: 1,
              child: GoskiTextField(
                hintText: tr('hintSpecialNote'),
                maxLines: 3,
              ),
            ),
            SizedBox(height: contentPadding),
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
                  text: tr('send'),
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

class TitleWithInputRow extends StatelessWidget {
  final String title, text;
  final IconData icon;
  final VoidCallback onClicked;

  const TitleWithInputRow({
    super.key,
    required this.title,
    required this.text,
    required this.icon,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: GoskiText(
            text: title,
            size: goskiFontLarge,
            isBold: true,
          ),
        ),
        Flexible(
          flex: 6,
          child: BorderWhiteContainer(
            child: TextWithIconRow(
              text: text,
              icon: icon,
              onClicked: onClicked,
            ),
          ),
        ),
      ],
    );
  }
}

class TextWithIconRow extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onClicked;

  const TextWithIconRow({
    super.key,
    required this.text,
    required this.icon,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Row(
        children: [
          Expanded(
            child: GoskiText(
              text: text,
              size: goskiFontMedium,
            ),
          ),
          Icon(
            size: goskiFontLarge,
            icon,
          ),
        ],
      ),
    );
  }
}
