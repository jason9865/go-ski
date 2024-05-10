import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:goski_student/ui/reservation/u019_reservation_team_select.dart';
import 'package:goski_student/ui/reservation/u020_reservation_instructor_list.dart';
import 'package:goski_student/view_model/reservation_view_model.dart';
import 'package:goski_student/view_model/ski_resort_view_model.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();
final SkiResortViewModel skiResortViewModel = Get.find<SkiResortViewModel>();
final ReservationViewModel reservationViewModel =
    Get.find<ReservationViewModel>();

class ReservationSelectScreen extends StatelessWidget {
  const ReservationSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contentPadding = screenSizeController.getHeightByRatio(0.015);

    return Scaffold(
      appBar: GoskiSubHeader(
        title: tr("reservation"),
      ),
      body: GoskiContainer(
        buttonName: 'next',
        onConfirm: () {
          if (reservationViewModel.reservation.value.isValid() &&
              reservationViewModel.reservation.value.level == 'beginner') {
            reservationViewModel.submitReservation();
            Get.to(() => ReservationTeamSelectScreen(),
                binding: BindingsBuilder(() {
              Get.lazyPut(() => LessonTeamListViewModel());
            }));
          } else if (reservationViewModel.reservation.value.isValid()) {
            reservationViewModel.submitReservation();
            Get.to(() => ReservationInstructorListScreen());
          } else {
            logger.d("전부 입력 x");
            reservationViewModel.submitReservation();
          }
        },
        child: SingleChildScrollView(
          child: GoskiCard(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _SkiResortDropdown(),
                  SizedBox(height: contentPadding),
                  _StudentNumberField(),
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
    logger.d(skiResortViewModel.skiResortNames);

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
                selected: skiResortViewModel.skiResortSelected.value,
                onSelected: (idx) {
                  skiResortViewModel.setResort(idx);
                  reservationViewModel.reservation.value.resortId = idx + 1;
                  // FIXME. reservationViewModel.resortId를 skiResortName에 해당하는 resortId를 저장하도록 변경
                },
              )),
        ),
      ],
    );
  }
}

class _StudentNumberField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  // _StudentNumberField({super.key});
  _StudentNumberField() {
    _controller.addListener(() {
      if (_controller.text.isNotEmpty) {
        reservationViewModel
            .setTotalStudent(int.tryParse(_controller.text) ?? 0);
      }
    });
  }

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
          child: TextFormField(
            style: const TextStyle(
              color: goskiBlack,
              fontSize: goskiFontSmall,
            ),
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              hintText: tr('selectStudentNumber'),
              fillColor: goskiWhite,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: goskiDarkGray, width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: goskiDarkGray, width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
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
        child: Obx(() => TextWithIconRow(
              text: reservationViewModel.reservation.value.lessonDate == ''
                  ? tr('hintDate')
                  : reservationViewModel.reservation.value.lessonDate,
              icon: Icons.calendar_month,
              // selectedTime: reservationViewModel.reservation.value.lessonDate,
              onClicked: () {
                _selectDate(context);
              },
            )),
      ),
      SizedBox(height: screenSizeController.getHeightByRatio(0.005)),
      GoskiBorderWhiteContainer(
        child: TextWithIconRow(
          text: tr('hintTime'),
          icon: Icons.access_time_rounded,
          // selectedTime: reservationViewModel.reservation.value.startTime,
          onClicked: () {
            _selectTime(context);
          },
        ),
      ),
      SizedBox(height: screenSizeController.getHeightByRatio(0.005)),
      SizedBox(
        width: double.infinity,
        child: Obx(() => GoskiDropdown(
              hint: tr('hintDuration'),
              list: skiResortViewModel.lessonTimeStrings,
              selected: skiResortViewModel.lessonTimeStrings.isNotEmpty
                  ? skiResortViewModel.lessonTimeStrings[
                      skiResortViewModel.selectedLessonTimeIndex.value]
                  : "",
              onSelected: (idx) {
                skiResortViewModel.selectedLessonTimeIndex.value = idx;
                // Update your reservation view model as needed
                reservationViewModel.reservation.value.duration =
                    skiResortViewModel.selectedResortLessonTimes[idx];
              },
            )),
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
              selectedType == 0
                  ? reservationViewModel.reservation.value.lessonType = 'SKI'
                  : reservationViewModel.reservation.value.lessonType = 'BOARD';
            },
          ),
        ],
      )
    ]);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      reservationViewModel
          .setLessonDate(DateFormat('yyyy-MM-dd').format(picked));
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final dateTime =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      final formattedTime = DateFormat('HHmm').format(dateTime);
      reservationViewModel.setStartTime(formattedTime);
    }
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
            const Icon(Icons.info_outline)
          ],
        ),
        SizedBox(height: contentPadding),
        GoskiDifficultySwitch(
          onSelected: (_selectedDifficulty) {
            print(_selectedDifficulty);
            reservationViewModel.reservation.value.level = _selectedDifficulty;
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
              // color: selectedTime.isEmpty ? goskiDarkGray : goskiBlack,
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
