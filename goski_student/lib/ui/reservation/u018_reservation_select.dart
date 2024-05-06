import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_border_white_container.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_difficulty_switch.dart';
import 'package:goski_student/ui/component/goski_dropdown.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_switch.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/view_model/reservation_view_model.dart';
import 'package:goski_student/view_model/ski_resort_view_model.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();
// final ReservationViewModel reservationViewModel =
//     Get.put(ReservationViewModel());
final screenSizeController = Get.find<ScreenSizeController>();
final SkiResortViewModel skiResortViewModel = Get.put(SkiResortViewModel());

class ReservationSelectScreen extends StatelessWidget {
  ReservationSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contentPadding = screenSizeController.getHeightByRatio(0.015);

    return Scaffold(
      appBar: GoskiSubHeader(
        title: tr("reservation"),
      ),
      body: GoskiContainer(
        buttonName: 'next',
        onConfirm: () => {print("다음으로")},
        child: GoskiCard(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _SkiResortDropdown(),
                SizedBox(height: contentPadding),
                _StudentNumberDropdown(),
                SizedBox(height: contentPadding),
                _DateTimeSelectors(),
                SizedBox(height: contentPadding),
                _DifficultyLevelSwitch(),
                SizedBox(height: contentPadding),
                // Add more widgets as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SkiResortDropdown extends StatelessWidget {
  _SkiResortDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // logger.d(skiResortViewModel.skiResortNames);

    return Row(
      children: [
        GoskiText(
          text: tr('skiResort'),
          size: goskiFontLarge,
          isBold: true,
          isExpanded: true,
        ),
        SizedBox(
          width: screenSizeController.getWidthByRatio(0.6),
          child: Obx(() => GoskiDropdown(
                hint: tr('selectSkiResort'),
                list: skiResortViewModel.skiResortNames,
                // TODO. selected 저장
              )),
        ),
      ],
    );
  }
}

class _StudentNumberDropdown extends StatelessWidget {
  const _StudentNumberDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GoskiText(
          text: tr('studentNumber'),
          size: goskiFontLarge,
          isBold: true,
          isExpanded: true,
        ),
        SizedBox(
          width: screenSizeController.getWidthByRatio(0.6),
          child: GoskiDropdown(
            hint: tr('selectStudentNumber'),
            list: ['1:1', '1:2', '1:3', '1:4이상'],
          ),
        ),
      ],
    );
  }
}

class _DateTimeSelectors extends StatelessWidget {
  _DateTimeSelectors({
    super.key,
  });

  final List<String> goskiLessonType = [
    tr('ski'),
    tr('board'),
  ];

  @override
  Widget build(BuildContext context) {
    final contentPadding = screenSizeController.getHeightByRatio(0.015);

    return Column(children: [
      SizedBox(
        width: double.infinity,
        child: GoskiText(
          text: tr('selectDateTime'),
          size: goskiFontLarge,
          isBold: true,
        ),
      ),
      SizedBox(height: contentPadding),
      GoskiBorderWhiteContainer(
        child: TextWithIconRow(
          text: tr('hintDate'),
          icon: Icons.calendar_month,
          // onClicked: () => _selectDate(),
          onClicked: () {
            // TODO. 시간 선택 버튼을 눌렀을 때 동작 추가 필요
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
            text: tr('lessonType'),
            size: goskiFontLarge,
            isBold: true,
            isExpanded: true,
          ),
          GoskiSwitch(
            items: goskiLessonType,
            width: screenSizeController.getWidthByRatio(0.5),
            onToggle: (selectedType) {
              print(goskiLessonType[selectedType]);
              print(selectedType);
            },
          ),
        ],
      )
    ]);
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    // if (selected != null) {
    //   setState(() {
    //     _selectedDate = (DateFormat.yMMMd()).format(selected);
    //   });
    // }
  }
}

class _DifficultyLevelSwitch extends StatelessWidget {
  const _DifficultyLevelSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final contentPadding = screenSizeController.getHeightByRatio(0.015);

    return Column(
      children: [
        Row(
          children: [
            GoskiText(
              text: tr('difficulty'),
              size: goskiFontLarge,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GoskiText(
              text: text,
              size: goskiFontMedium,
              color: goskiDarkGray,
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
