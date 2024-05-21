import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/main.dart';
import 'package:goski_student/ui/component/goski_border_white_container.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_difficulty_switch.dart';
import 'package:goski_student/ui/component/goski_dropdown.dart';
import 'package:goski_student/ui/component/goski_modal.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_switch.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/reservation/u019_reservation_team_select.dart';
import 'package:goski_student/ui/reservation/u020_reservation_instructor_list.dart';
import 'package:goski_student/view_model/reservation_view_model.dart';
import 'package:goski_student/view_model/ski_resort_view_model.dart';

final SkiResortViewModel skiResortViewModel = Get.find<SkiResortViewModel>();
final ReservationViewModel reservationViewModel =
    Get.find<ReservationViewModel>();

class ReservationSelectScreen extends StatelessWidget {
  const ReservationSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contentPadding = screenSizeController.getHeightByRatio(0.015);
    reservationViewModel.clearData();
    skiResortViewModel.clearData();

    return Scaffold(
      appBar: GoskiSubHeader(
        title: tr("reservation"),
      ),
      body: GoskiContainer(
        buttonName: 'next',
        onConfirm: () {
          if (reservationViewModel.reservation.value.isValid() &&
              (reservationViewModel.reservation.value.level == 'BEGINNER' ||
                  reservationViewModel.reservation.value.level == 'beginner')) {
            reservationViewModel.submitReservation();
            Get.to(() => const ReservationTeamSelectScreen(),
                binding: BindingsBuilder(() {
              Get.lazyPut(() => LessonTeamListViewModel());
            }));
          } else if (reservationViewModel.reservation.value.isValid()) {
            reservationViewModel.submitReservation();
            Get.to(() => const ReservationInstructorListScreen(),
                binding: BindingsBuilder(() {
              Get.lazyPut(() => LessonInstructorListViewModel());
            }));
          } else {
            if (!Get.isSnackbarOpen) {
              Get.snackbar(tr('reservationInfo'), tr('checkReservationInfo'));
              reservationViewModel.submitReservation();
            }
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
                  const _DifficultyLevelSwitch(),
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
                selected: skiResortViewModel.skiResortSelected.value,
                onSelected: (idx) {
                  skiResortViewModel.setResort(idx);
                  reservationViewModel.reservation.update((val) =>
                      val?.duration =
                          skiResortViewModel.selectedResortLessonTimes[0]);
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
        if (int.tryParse(_controller.text)! > 8) {
          _controller.text = "8";
          if (!Get.isSnackbarOpen) {
            Get.snackbar(
                tr('errorStudentNumberTitle'), tr('errorStudentNumberContent'));
          }
        }

        reservationViewModel
            .setTotalStudent(int.tryParse(_controller.text) ?? 0);
      } else {
        reservationViewModel.setTotalStudent(0);
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
        Container(
          width: screenSizeController.getWidthByRatio(0.6),
          padding: EdgeInsets.symmetric(
            horizontal: screenSizeController.getWidthByRatio(0.02),
            vertical: screenSizeController.getWidthByRatio(0.025),
          ),
          decoration: BoxDecoration(
              color: goskiWhite,
              border: Border.all(width: 1, color: goskiDarkGray),
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            style: const TextStyle(
              color: goskiBlack,
              fontSize: goskiFontMedium,
            ),
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              isDense: true,
              hintText: tr('selectStudentNumber'),
              fillColor: goskiWhite,
              filled: true,
              contentPadding: const EdgeInsets.all(0),
              border: InputBorder.none,
            ),
            cursorColor: goskiBlack,
          ),
        ),
      ],
    );
  }
}

class _DateTimeSelectors extends StatelessWidget {
  _DateTimeSelectors();

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
          child: Obx(
        () => TextWithIconRow(
          text: reservationViewModel.reservation.value.startTime == ''
              ? tr('hintTime')
              : "${reservationViewModel.reservation.value.startTime.substring(0, 2)}:${reservationViewModel.reservation.value.startTime.substring(2, 4)}",
          icon: Icons.access_time_rounded,
          // selectedTime: reservationViewModel.reservation.value.startTime,
          onClicked: () {
            showDialog(
              context: context,
              builder: (context) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: goskiBlack,
                      surface: goskiBackground,
                      surfaceTint: Colors.transparent,
                    ),
                    buttonTheme: const ButtonThemeData(
                        textTheme: ButtonTextTheme.primary),
                  ),
                  child: GoskiModal(
                    title: tr('selectTime'),
                    child: reservationTimePicker(context),
                  ),
                );
              },
            );
            // _selectTime(context);
          },
        ),
      )),
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
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: goskiBlack,
              surface: goskiBackground,
              surfaceTint: Colors.transparent,
            ),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      reservationViewModel
          .setLessonDate(DateFormat('yyyy-MM-dd').format(picked));
    }
  }

  Widget reservationTimePicker(BuildContext context) {
    String selectedHour = "08";
    String selectedMinute = "00";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: screenSizeController.getHeightByRatio(0.2),
                child: CupertinoPicker(
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int index) {
                    selectedHour = (8 + index).toString();
                  },
                  children: List<Widget>.generate(15, (int index) {
                    return Center(child: Text('${8 + index}'));
                  }),
                ),
              ),
            ),
            const GoskiText(
              text: ":",
              size: goskiFontLarge,
            ),
            Expanded(
              child: SizedBox(
                height: screenSizeController.getHeightByRatio(0.2),
                child: CupertinoPicker(
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int index) {
                    selectedMinute = (index * 30).toString();
                  },
                  children: const <Widget>[
                    Center(child: Text('00')),
                    Center(child: Text('30')),
                  ],
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: GoskiText(
                text: tr('cancel'),
                size: goskiFontLarge,
              ),
            ),
            TextButton(
              onPressed: () {
                selectedHour =
                    selectedHour.length == 1 ? "0$selectedHour" : selectedHour;
                selectedMinute = selectedMinute.length == 1
                    ? "0$selectedMinute"
                    : selectedMinute;

                reservationViewModel
                    .setStartTime("$selectedHour$selectedMinute");
                Navigator.of(context).pop();
              },
              child: GoskiText(
                text: tr('confirm'),
                size: goskiFontLarge,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _DifficultyLevelSwitch extends StatelessWidget {
  const _DifficultyLevelSwitch();

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
          onSelected: (selectedDifficulty) {
            reservationViewModel.reservation.value.level = selectedDifficulty;
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
