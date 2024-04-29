import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_border_white_container.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_difficulty_switch.dart';
import 'package:goski_student/ui/component/goski_dropdown.dart';
import 'package:goski_student/ui/component/goski_switch.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class ReservationSelectScreen extends StatelessWidget {
  const ReservationSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final contentPadding = screenSizeController.getHeightByRatio(0.015);

    return GoskiContainer(
      buttonName: tr('next'),
      onConfirm: () => {print("다음으로")},
      child: GoskiCard(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _SkiResortDropdown(screenSizeController: screenSizeController),
              SizedBox(height: contentPadding),
              _StudentNumberDropdown(
                  screenSizeController: screenSizeController),
              SizedBox(height: contentPadding),
              _DateTimeSelectors(screenSizeController: screenSizeController),
              SizedBox(height: contentPadding),
              _DifficultyLevelSwitch(
                  screenSizeController: screenSizeController),
              SizedBox(height: contentPadding),
              // Add more widgets as needed
            ],
          ),
        ),
      ),
    );
  }
}

class _SkiResortDropdown extends StatelessWidget {
  final ScreenSizeController screenSizeController;

  const _SkiResortDropdown({super.key, required this.screenSizeController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GoskiText(
          text: tr('skiResort'),
          size: goskiFontMedium,
          isBold: true,
          isExpanded: true,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: SizedBox(
            width: screenSizeController.getWidthByRatio(0.6),
            child: GoskiDropdown(
              hint: tr('selectSkiResort'),
              list: ['지산리조트', '곤지암리조트', '비발디파크'],
            ),
          ),
        ),
      ],
    );
  }
}

class _StudentNumberDropdown extends StatelessWidget {
  final ScreenSizeController screenSizeController;

  const _StudentNumberDropdown({super.key, required this.screenSizeController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GoskiText(
          text: tr('studentNumber'),
          size: goskiFontMedium,
          isBold: true,
          isExpanded: true,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: SizedBox(
            width: screenSizeController.getWidthByRatio(0.6),
            child: GoskiDropdown(
              hint: tr('selectStudentNumber'),
              list: ['1:1', '1:2', '1:3', '1:4이상'],
            ),
          ),
        ),
      ],
    );
  }
}

class _DateTimeSelectors extends StatelessWidget {
  final ScreenSizeController screenSizeController;

  const _DateTimeSelectors({super.key, required this.screenSizeController});

  @override
  Widget build(BuildContext context) {
    final contentPadding = screenSizeController.getHeightByRatio(0.015);

    return Column(children: [
      SizedBox(
        width: double.infinity,
        child: GoskiText(
          text: tr('selectDateTime'),
          size: goskiFontMedium,
          isBold: true,
        ),
      ),
      SizedBox(height: contentPadding),
      GoskiBorderWhiteContainer(
        child: TextWithIconRow(
          text: tr('hintDate'),
          icon: Icons.calendar_month,
          onClicked: () {
            // TODO. 날짜 선택 버튼을 눌렀을 때 동작 추가 필요
          },
        ),
      ),
      SizedBox(height: screenSizeController.getHeightByRatio(0.005)),
      GoskiBorderWhiteContainer(
        child: TextWithIconRow(
          text: tr('hintTime'),
          icon: Icons.access_time_rounded,
          onClicked: () {
            // TODO. 시간 선택 버튼을 눌렀을 때 동작 추가 필요
          },
        ),
      ),
      SizedBox(height: contentPadding),
      Row(
        children: [
          GoskiText(
            text: tr("강습 종류"),
            size: goskiFontMedium,
            isBold: true,
            isExpanded: true,
          ),
          GoskiSwitch(
            items: [
              tr('ski'),
              tr('board'),
            ],
            width: screenSizeController.getWidthByRatio(0.5),
          ),
        ],
      )
    ]);
  }
}

class _DifficultyLevelSwitch extends StatelessWidget {
  final ScreenSizeController screenSizeController;

  const _DifficultyLevelSwitch({super.key, required this.screenSizeController});

  @override
  Widget build(BuildContext context) {
    final contentPadding = screenSizeController.getHeightByRatio(0.015);

    return Column(
      children: [
        Row(
          children: [
            GoskiText(
              text: tr('difficulty'),
              size: goskiFontMedium,
              isBold: true,
            ),
            Icon(Icons.info_outline)
          ],
        ),
        SizedBox(height: contentPadding),
        GoskiDifficultySwitch(
          onSelected: (selectedDifficulty) {
            print(selectedDifficulty);
          },
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
