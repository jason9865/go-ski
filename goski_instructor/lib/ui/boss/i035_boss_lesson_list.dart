import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_badge.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

class BossLessonListScreen extends StatelessWidget {
  const BossLessonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    cardOnTap() => {print("강습 세부정보")};
    myOnTap() => {print("쪽지보내기 ? 피드백 작성? 피드백 수정")};

    final List<_StudentInfo> studentList = [
      _StudentInfo(
          studentName: "고승민",
          height: "height",
          weight: "weight",
          footSize: 260,
          age: "age",
          gender: "gender"),
      _StudentInfo(
          studentName: "고정원",
          height: "height",
          weight: "weight",
          footSize: 260,
          age: "age",
          gender: "gender"),
      _StudentInfo(
          studentName: "송준석",
          height: "height",
          weight: "weight",
          footSize: 260,
          age: "age",
          gender: "gender"),
      _StudentInfo(
          studentName: "임종율",
          height: "height",
          weight: "weight",
          footSize: 260,
          age: "age",
          gender: "gender"),
    ];
    final List<_Lesson> lessonList = [
      _Lesson(
          resortName: "지산스키장",
          startTime: DateTime.now().add(const Duration(minutes: 30)),
          endTime: DateTime.now(),
          studentList: studentList),
      _Lesson(
          resortName: "지산스키장",
          startTime: DateTime.now().add(const Duration(days: 1)),
          endTime: DateTime.now(),
          studentList: studentList),
      _Lesson(
          resortName: "지산스키장",
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(hours: 3)),
          studentList: studentList),
      _Lesson(
          resortName: "지산스키장",
          startTime: DateTime.now().subtract(const Duration(days: 1)),
          endTime: DateTime.now().subtract(const Duration(hours: 5)),
          studentList: studentList),
      _Lesson(
          resortName: "지산스키장",
          startTime: DateTime.now().subtract(const Duration(days: 1)),
          endTime: DateTime.now().subtract(const Duration(hours: 5)),
          studentList: studentList),
      _Lesson(
          resortName: "지산스키장",
          startTime: DateTime.now().subtract(const Duration(days: 1)),
          endTime: DateTime.now().subtract(const Duration(hours: 5)),
          studentList: studentList,
          rating: 3.9),
    ];

    return GoskiContainer(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: lessonList.length,
            itemBuilder: (BuildContext context, int index) {
              final lesson = lessonList[index];
              String lessonStatus = 'notStart';
              Color lessonBackgroundColor;
              String buttonString = 'notStart';
              bool buttonStatus = false;

              final now = DateTime.now();
              if (lesson.startTime.isBefore(now) &&
                  lesson.endTime.isAfter(now)) {
                lessonStatus = 'onGoing';
                lessonBackgroundColor = goskiDarkPink;
                buttonString = 'sendMessage';
              } else if (lesson.startTime.isAfter(now)) {
                lessonBackgroundColor = goskiBlue;
                if (lesson.startTime
                    .isBefore(now.add(const Duration(minutes: 30)))) {
                  buttonString = 'sendMessage';
                }
              } else if (lesson.endTime.isBefore(now) && lesson.rating != -1) {
                // 피드백 작성여부에 따른 분기 필요
                lessonStatus = 'lessonFinished';
                lessonBackgroundColor = goskiGreen;
                buttonStatus = true;
              } else {
                lessonStatus = 'lessonFinished';
                lessonBackgroundColor = goskiGreen;
                buttonString = 'updateFeedback';
              }

              return GestureDetector(
                onTap: cardOnTap,
                child: GoskiCard(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GoskiBadge(
                                text: tr(lessonStatus),
                                backgroundColor: lessonBackgroundColor,
                              ),
                            ),
                            if (buttonStatus)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: goskiYellow,
                                  ),
                                  GoskiText(
                                    text: tr(lesson.rating.toString()),
                                    size: goskiFontSmall,
                                    color: goskiDarkGray,
                                  ),
                                ],
                              )
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GoskiText(
                                            text: tr('location'),
                                            size: goskiFontMedium,
                                            isBold: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    GoskiText(
                                        text: tr(lesson.resortName),
                                        size: goskiFontSmall),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSizeController
                                      .getHeightByRatio(0.005),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GoskiText(
                                            text: tr('date'),
                                            size: goskiFontMedium,
                                            isBold: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GoskiText(
                                          text: tr(DateFormat('yyyy.MM.dd (E)')
                                              .format(lesson.startTime)
                                              .toString()),
                                          size: goskiFontSmall,
                                          color: goskiDarkGray,
                                        ),
                                        Row(
                                          children: [
                                            GoskiText(
                                              text: tr(DateFormat('HH:mm')
                                                  .format(lesson.startTime)
                                                  .toString()),
                                              size: goskiFontSmall,
                                              color: goskiDarkGray,
                                            ),
                                            GoskiText(
                                              text: tr(DateFormat('~HH:mm')
                                                  .format(lesson.endTime)
                                                  .toString()),
                                              size: goskiFontSmall,
                                              color: goskiDarkGray,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenSizeController
                                      .getHeightByRatio(0.005),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GoskiText(
                                            text: tr('reservationPerson'),
                                            size: goskiFontMedium,
                                            isBold: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    GoskiText(
                                        text: tr('extraPerson', args: [
                                          lesson.studentList[0].studentName,
                                          lesson.studentList.length.toString()
                                        ]),
                                        size: goskiFontSmall),
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}

class _Lesson {
  final String resortName;
  final DateTime startTime;
  final DateTime endTime;
  final List<_StudentInfo> studentList;
  final double rating;

  _Lesson(
      {required this.resortName,
      required this.startTime,
      required this.endTime,
      required this.studentList,
      this.rating = -1});
}

class _StudentInfo {
  final String studentName;
  final String height;
  final String weight;
  final int footSize;
  final String age;
  final String gender;

  _StudentInfo({
    required this.studentName,
    required this.height,
    required this.weight,
    required this.footSize,
    required this.age,
    required this.gender,
  });
}
