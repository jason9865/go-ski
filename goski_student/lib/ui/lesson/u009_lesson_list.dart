import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_badge.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_middlesize_button.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class LessonListScreen extends StatelessWidget {
  const LessonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    cardOnTap() => print("강습 세부정보");

    final List<_Lesson> lessonList = [
      _Lesson(
          resortName: "지산스키장",
          teamName: "승민 스키교실",
          instructorName: "임종율",
          instructorProfileImage: "assets/images/person1.png",
          startTime: DateTime.now().add(const Duration(minutes: 30)),
          endTime: DateTime.now().add(const Duration(minutes: 50))),
      _Lesson(
          resortName: "지산스키장",
          teamName: "승민 스키교실",
          instructorName: "임종율",
          instructorProfileImage: "assets/images/person1.png",
          startTime: DateTime.now().add(const Duration(days: 1)),
          endTime: DateTime.now().add(const Duration(days: 1,hours: 2))),
      _Lesson(
          resortName: "지산스키장",
          teamName: "승민 스키교실",
          instructorName: "김태훈",
          instructorProfileImage: "assets/images/person2.png",
          startTime: DateTime.now(),
          endTime: DateTime.now().add(const Duration(hours: 3))),
      _Lesson(
          resortName: "지산스키장",
          teamName: "승민 스키교실",
          instructorName: "김태훈",
          instructorProfileImage: "assets/images/person2.png",
          startTime: DateTime.now().subtract(const Duration(days: 1)),
          endTime: DateTime.now().subtract(const Duration(hours: 5))),
      _Lesson(
          resortName: "지산스키장",
          teamName: "승민 스키교실",
          instructorName: "김태훈",
          instructorProfileImage: "assets/images/person2.png",
          startTime: DateTime.now().subtract(const Duration(days: 1)),
          endTime: DateTime.now().subtract(const Duration(hours: 5))),
      _Lesson(
          resortName: "지산스키장",
          teamName: "승민 스키교실",
          instructorName: "김태훈",
          instructorProfileImage: "assets/images/person2.png",
          startTime: DateTime.now().subtract(const Duration(days: 1)),
          endTime: DateTime.now().subtract(const Duration(hours: 5))),
    ];

    return GoskiContainer(
      onConfirm: ()=>{print("돌아가기")},
      buttonName: tr('back'),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: lessonList.length,
        itemBuilder: (BuildContext context, int index) {
          final lesson = lessonList[index];
          final now = DateTime.now();
          String lessonStatus = 'notStart';
          Color lessonBackgroundColor = goskiDarkPink;

          if (lesson.startTime.isBefore(now) && lesson.endTime.isAfter(now)) {
            lessonStatus = 'onGoing';
            lessonBackgroundColor = goskiBlue;
          } else if (lesson.endTime.isBefore(now)) {
            lessonStatus = 'lessonFinished';
            lessonBackgroundColor = goskiGreen;
          }

          List<Widget> buttons = [];
          if (lessonStatus == 'notStart') {
            buttons.add(createButton(screenSizeController, 'cancelLesson', "강습 예약 취소"));
          }
          if (lesson.startTime.isBefore(now.add(const Duration(minutes: 30))) && lesson.endTime.isAfter(now)) {
            buttons.add(createButton(screenSizeController, 'sendMessage', "쪽지보내기"));
          }
          if (lesson.endTime.isBefore(now)) {
            buttons.addAll([
              createButton(screenSizeController, 'reLesson', "재강습 신청"),
              createButton(screenSizeController, 'feedback', "피드백 확인"),
              createButton(screenSizeController, 'review', "리뷰 작성"),
            ]);
          }

          MainAxisAlignment alignment = buttons.length == 1 ? MainAxisAlignment.end : MainAxisAlignment.spaceEvenly;

          return GestureDetector(
            onTap: cardOnTap,
            child: GoskiCard(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    badgeRow(lessonStatus, lessonBackgroundColor),
                    profileRow(lesson, screenSizeController),
                    buttonRow(buttons, alignment),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget createButton(ScreenSizeController screenSizeController, String textId, String debugMessage) {
    return GoskiMiddlesizeButton(
      width: screenSizeController.getWidthByRatio(1),
      text: tr(textId),
      onTap: () => print(debugMessage),
      height: 30,
      size: goskiFontSmall,
    );
  }

  Row badgeRow(String lessonStatus, Color backgroundColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GoskiBadge(
            text: tr(lessonStatus),
            backgroundColor: backgroundColor,
          ),
        ),
      ],
    );
  }

  Row profileRow(_Lesson lesson, ScreenSizeController screenSizeController) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Image.asset(
            lesson.instructorProfileImage,
            width: 90,
            height: screenSizeController.getHeightByRatio(0.12),
            fit: BoxFit.fitHeight,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: detailColumn(lesson, screenSizeController),
        ),
      ],
    );
  }

  Column detailColumn(_Lesson lesson, ScreenSizeController screenSizeController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        detailRow('name', tr('dynamicInstructor', args: [lesson.instructorName]), goskiFontSmall),
        SizedBox(height: screenSizeController.getHeightByRatio(0.005)),
        detailRow('location', lesson.resortName, goskiFontSmall),
        SizedBox(height: screenSizeController.getHeightByRatio(0.005)),
        dateRow(lesson),
        SizedBox(height: screenSizeController.getHeightByRatio(0.005)),
      ],
    );
  }

  Row dateRow(_Lesson lesson) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelColumn('date'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GoskiText(
              text: DateFormat('yyyy.MM.dd (E)').format(lesson.startTime).toString(),
              size: goskiFontSmall,
              color: goskiDarkGray,
            ),
            timeRow(lesson),
          ],
        ),
      ],
    );
  }

  Row timeRow(_Lesson lesson) {
    return Row(
      children: [
        GoskiText(
          text: DateFormat('HH:mm').format(lesson.startTime).toString(),
          size: goskiFontSmall,
          color: goskiDarkGray,
        ),
        GoskiText(
          text: DateFormat('~HH:mm').format(lesson.endTime).toString(),
          size: goskiFontSmall,
          color: goskiDarkGray,
        ),
      ],
    );
  }

  Row detailRow(String labelId, String value, double fontSize) {
    return Row(
      children: [
        labelColumn(labelId),
        GoskiText(text: value, size: fontSize),
      ],
    );
  }

  SizedBox labelColumn(String labelId) {
    return SizedBox(
      width: 80,
      child: GoskiText(
        text: tr(labelId),
        size: goskiFontMedium,
        isBold: true,
      ),
    );
  }

  Row buttonRow(List<Widget> buttons, MainAxisAlignment alignment) {
    return Row(
      mainAxisAlignment: alignment,
      children: buttons,
    );
  }
}

class _Lesson {
  final String resortName;
  final String teamName;
  final String instructorName;
  final String instructorProfileImage;
  final DateTime startTime;
  final DateTime endTime;

  _Lesson({
    required this.resortName,
    required this.teamName,
    required this.instructorName,
    required this.instructorProfileImage,
    required this.startTime,
    required this.endTime,
  });
}
