import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/default_image.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/data/model/instructor.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/lesson/u023_lesson_reservation.dart';
import 'package:goski_student/ui/main/u003_student_main.dart';
import 'package:goski_student/view_model/reservation_view_model.dart';

final ReservationViewModel reservationViewModel =
    Get.find<ReservationViewModel>();
final ScreenSizeController screenSizeController =
    Get.find<ScreenSizeController>();

class ReservationCompleteScreen extends StatefulWidget {
  BeginnerResponse? teamInformation;
  Instructor? instructor;

  ReservationCompleteScreen({
    super.key,
    this.teamInformation,
    this.instructor,
  });

  @override
  State<ReservationCompleteScreen> createState() =>
      _ReservationCompleteScreenState();
}

class _ReservationCompleteScreenState extends State<ReservationCompleteScreen> {
  final imageWidth = screenSizeController.getWidthByRatio(0.5);

  @override
  Widget build(BuildContext context) {
    final reservationInfo = reservationViewModel.reservation.value;

    return GoskiContainer(
      buttonName: "toMain",
      onConfirm: () {
        Get.offAll(StudentMainScreen());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            s3Penguin,
            width: imageWidth,
            height: imageWidth,
            fit: BoxFit.fitHeight,
          ),
          GoskiText(text: tr('completePayment'), size: goskiFontXXLarge),
          const BuildInterval(),
          GoskiCard(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    GoskiText(
                      text: tr('reservationInfo'),
                      size: goskiFontXLarge,
                      isBold: true,
                    )
                  ]),
                  const BuildInterval(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (widget.teamInformation != null)
                              GoskiText(
                                text: tr(widget.teamInformation!.teamName),
                                size: goskiFontLarge,
                              ),
                            if (widget.teamInformation == null &&
                                widget.instructor != null)
                              GoskiText(
                                text: tr(widget.instructor!.teamName),
                                size: goskiFontLarge,
                              ),
                          ],
                        ),
                        Row(
                          children: [
                            if (widget.instructor != null)
                              GoskiText(
                                text: tr('designatedInstructor',
                                    args: [widget.instructor!.userName]),
                                size: goskiFontMedium,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GoskiText(
                              text: tr('date'),
                              size: goskiFontMedium,
                              color: goskiDarkGray,
                            ),
                            GoskiText(
                              text: formatSessionTime(
                                reservationInfo.lessonDate,
                                reservationInfo.startTime,
                                reservationInfo.duration,
                              ),
                              size: goskiFontLarge,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GoskiText(
                          text: tr('studentNumber'),
                          size: goskiFontMedium,
                          color: goskiDarkGray,
                        ),
                        GoskiText(
                          text: tr('hintStudentCount',
                              args: [reservationInfo.studentCount.toString()]),
                          size: goskiFontLarge,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.teamInformation != null)
                          GoskiText(
                            text: tr('price', args: [
                              NumberFormat('###,###,###')
                                  .format(widget.teamInformation!.cost)
                            ]),
                            size: goskiFontLarge,
                            isBold: true,
                          ),
                        if (widget.teamInformation == null &&
                            widget.instructor != null)
                          GoskiText(
                            text: tr('price', args: [
                              NumberFormat('###,###,###')
                                  .format(widget.instructor!.cost)
                            ]),
                            size: goskiFontLarge,
                            isBold: true,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
