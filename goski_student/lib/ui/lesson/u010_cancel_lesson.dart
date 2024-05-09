import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/text_formatter.dart';
import 'package:goski_student/data/model/lesson_list_response.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_expansion_tile.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/view_model/cancel_lesson_view_model.dart';
import 'package:goski_student/view_model/lesson_list_view_model.dart';

class CancelLessonScreen extends StatelessWidget {
  final cancelLessonViewModel = Get.find<CancelLessonViewModel>();
  final lessonListViewModel = Get.find<LessonListViewModel>();

  CancelLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LessonListItem lesson = lessonListViewModel.selectedLesson.value;

    return Obx(
      () => Scaffold(
        appBar: GoskiSubHeader(
          title: tr('cancelLesson'),
        ),
        body: GoskiContainer(
          buttonName: "cancelLesson",
          onConfirm: () async {
            bool result = await cancelLessonViewModel.cancelLesson(lessonListViewModel.selectedLesson.value.lessonId);

            if (result) {
              await lessonListViewModel.getLessonList();
              Get.back();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoskiCard(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GoskiText(
                                text: tr('reservationInfo'),
                                size: goskiFontLarge,
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
                                  GoskiText(
                                      text: tr(lesson.resortName),
                                      size: goskiFontMedium),
                                  GoskiText(
                                      text: tr(' - '), size: goskiFontMedium),
                                  GoskiText(
                                      text: tr(lesson.teamName),
                                      size: goskiFontMedium),
                                ],
                              ),
                              Row(
                                children: [
                                  GoskiText(
                                      text: tr('designatedInstructor',
                                          args: [lesson.instructorName == null ? '이름 없음' : lesson.instructorName!]),
                                      size: goskiFontMedium),
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
                              GoskiText(
                                text: tr('date'),
                                size: goskiFontSmall,
                                color: goskiDarkGray,
                              ),
                              dateRow(lesson),
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
                                size: goskiFontSmall,
                                color: goskiDarkGray,
                              ),
                              GoskiText(
                                  text: tr(
                                      '${lesson.studentCount.toString()} 명'),
                                  size: goskiFontMedium),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GoskiText(
                                text: tr('paymentAmount'),
                                size: goskiFontMedium,
                              ),
                              GoskiText(
                                text: tr('moneyUnit',
                                    args: [formatFromInt(cancelLessonViewModel.lessonCost.value)]),
                                size: goskiFontMedium,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const BuildInterval(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GoskiExpansionTile(
                    title: GoskiText(
                      text: tr('refundPolicy'),
                      size: goskiFontMedium,
                    ),
                    backgroundColor: goskiLightGray,
                    radius: 15,
                    children: [
                      GoskiText(
                        text: tr('refundPolicyDetail'),
                        size: goskiFontMedium,
                      ),
                    ],
                  ),
                ),
                const BuildInterval(),
                GoskiCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GoskiText(
                          text: tr("checkRefund"),
                          size: goskiFontMedium,
                          isBold: true,
                        ),
                        const BuildInterval(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GoskiText(
                                text: tr('paymentAmount'), size: goskiFontMedium),
                            GoskiText(
                                text: tr('moneyUnit',
                                    args: [formatFromInt(cancelLessonViewModel.lessonCost.value)]),
                                size: goskiFontMedium),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GoskiText(
                                text: tr('refundCharge'), size: goskiFontMedium),
                            GoskiText(
                                text: '- ${tr('moneyUnit', args: [formatFromInt(cancelLessonViewModel.lessonCost.value ~/ 100 * (100 - cancelLessonViewModel.paybackRate.value))])}',
                                size: goskiFontMedium),
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                          height: 15,
                          color: goskiDashGray,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GoskiText(
                              text: tr('expectedRefund'),
                              size: goskiFontMedium,
                            ),
                            GoskiText(
                              text: tr('moneyUnit',
                                  args: [formatFromInt(cancelLessonViewModel.lessonCost.value ~/ 100 * cancelLessonViewModel.paybackRate.value)]),
                              size: goskiFontMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const BuildInterval(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dateRow(LessonListItem lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GoskiText(
          text: DateFormat('yyyy.MM.dd (E)')
              .format(lesson.startTime)
              .toString(),
          size: goskiFontMedium,
        ),
        Row(
          children: [
            GoskiText(
              text:
                  DateFormat('HH:mm').format(lesson.startTime).toString(),
              size: goskiFontMedium,
            ),
            GoskiText(
              text: DateFormat('~HH:mm').format(lesson.endTime).toString(),
              size: goskiFontMedium,
            ),
          ],
        )
      ],
    );
  }
}