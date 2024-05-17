import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/data/model/lesson_list_response.dart';
import 'package:goski_instructor/ui/component/goski_badge.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_sub_header.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/ui/instructor/i015_feedback.dart';
import 'package:goski_instructor/view_model/lesson_list_view_model.dart';

import '../../main.dart';

class LessonListScreen extends StatefulWidget {
  LessonListScreen({super.key});

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {
  final lessonListViewModel = Get.find<LessonListViewModel>();

  @override
  void initState() {
    super.initState();
    lessonListViewModel.getLessonList();
  }

  @override
  Widget build(BuildContext context) {
    cardOnTap() => {print("강습 세부정보")};
    VoidCallback myOnTap;
    List<LessonList> lessonList = lessonListViewModel.lessonList;

    return Obx(() {
      if (lessonListViewModel.isLoadingLessonList.value) {
        return Scaffold(
          appBar: GoskiSubHeader(title: tr('lessonHistory')),
          body: const GoskiContainer(
            child: Center(
              child: CircularProgressIndicator(
                color: goskiBlack,
              ),
            ),
          ),
        );
      } else if (lessonListViewModel.lessonList.isEmpty) {
        return Scaffold(
          appBar: GoskiSubHeader(title: tr('lessonHistory')),
          body: GoskiContainer(
            child: Center(
              child: GoskiText(
                text: tr('noLessonHistory'),
                size: goskiFontLarge,
              ),
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: GoskiSubHeader(
            title: tr('lessonHistory'),
          ),
          body: GoskiContainer(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: lessonList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final lesson = lessonList[index];
                    String lessonStatus = 'notStart';
                    Color lessonBackgroundColor;
                    String buttonString = 'notStart';
                    bool buttonStatus = true;

                    final now = DateTime.now();
                    if (lesson.startTime.isBefore(now) &&
                        lesson.endTime.isAfter(now)) {
                      lessonStatus = 'onGoing';
                      lessonBackgroundColor = goskiYellow;
                      buttonString = 'sendMessage';
                      myOnTap = () {
                        print("쪽지보내기 ? 피드백 작성? 피드백 수정");
                      };
                    } else if (lesson.startTime.isAfter(now)) {
                      lessonBackgroundColor = goskiBlue;
                      buttonStatus = false;
                      myOnTap = () {
                        print("쪽지보내기 ? 피드백 작성? 피드백 수정");
                      };
                      if (lesson.startTime
                          .isBefore(now.add(const Duration(minutes: 30)))) {
                        buttonString = 'sendMessage';
                        buttonStatus = true;
                      }
                    } else if (lesson.endTime.isBefore(now)) {
                      // 피드백 작성여부에 따른 분기 필요
                      lessonStatus = 'noFeedback';
                      lessonBackgroundColor = goskiDarkPink;
                      buttonString = 'createFeedback';
                      myOnTap = () {
                        Get.to(() => FeedbackScreen(
                              resortName: lesson.resortName,
                              teamName: lesson.teamName,
                              startTime: lesson.startTime,
                              endTime: lesson.endTime,
                            ));
                      };
                    } else {
                      lessonStatus = 'yesFeedback';
                      lessonBackgroundColor = goskiBlack;
                      buttonString = 'updateFeedback';
                      myOnTap = () {
                        Get.to(() => FeedbackScreen(
                              resortName: lesson.resortName,
                              teamName: lesson.teamName,
                              startTime: lesson.startTime,
                              endTime: lesson.endTime,
                              // 기존에 저장되어있는 피드백 정보들도 같이
                            ));
                      };
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GoskiBadge(
                                      text: tr(lessonStatus),
                                      backgroundColor: lessonBackgroundColor,
                                    ),
                                  ),
                                  if (buttonStatus)
                                    GestureDetector(
                                      onTap: myOnTap,
                                      child: Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GoskiText(
                                              text: tr(buttonString),
                                              size: goskiFontMedium),
                                          const Icon(
                                            Icons.keyboard_arrow_right,
                                            size: goskiFontMedium,
                                          ),
                                        ],
                                      )),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                text: tr(DateFormat(
                                                        'yyyy.MM.dd (E)')
                                                    .format(lesson.startTime)
                                                    .toString()),
                                                size: goskiFontSmall,
                                                color: goskiDarkGray,
                                              ),
                                              Row(
                                                children: [
                                                  GoskiText(
                                                    text: tr(DateFormat('HH:mm')
                                                        .format(
                                                            lesson.startTime)
                                                        .toString()),
                                                    size: goskiFontSmall,
                                                    color: goskiDarkGray,
                                                  ),
                                                  GoskiText(
                                                    text: tr(DateFormat(
                                                            '~HH:mm')
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
                                                lesson.studentInfoList[0].name,
                                                lesson.studentInfoList.length
                                                    .toString()
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
                  })),
        );
      }
    });
  }
}

class _Lesson {
  final String resortName;
  final String teamName;
  final DateTime startTime;
  final DateTime endTime;
  final List<_StudentInfo> studentList;

  _Lesson(
      {required this.resortName,
      required this.teamName,
      required this.startTime,
      required this.endTime,
      required this.studentList});
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
