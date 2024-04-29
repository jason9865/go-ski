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
import 'package:goski_student/ui/lesson/u014_feedback.dart';

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
          endTime: DateTime.now().add(const Duration(days: 1, hours: 2))),
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
      onConfirm: () => {print("돌아가기")},
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
            buttons.add(
                createButton(screenSizeController, 'cancelLesson', "강습 예약 취소", lesson));
          }
          if (lesson.startTime.isBefore(now.add(const Duration(minutes: 30))) &&
              lesson.endTime.isAfter(now)) {
            buttons.add(
                createButton(screenSizeController, 'sendMessage', "쪽지보내기", lesson));
          }
          if (lesson.endTime.isBefore(now)) {
            buttons.addAll([
              createButton(screenSizeController, 'reLesson', "재강습 신청", lesson),
              createButton(screenSizeController, 'feedback', "피드백 확인", lesson),
              createButton(screenSizeController, 'review', "리뷰 작성", lesson),
            ]);
          }

          MainAxisAlignment alignment = buttons.length == 1
              ? MainAxisAlignment.end
              : MainAxisAlignment.spaceEvenly;

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

  Widget createButton(ScreenSizeController screenSizeController, String textId,
      String debugMessage, _Lesson lesson) {
    VoidCallback myOnTap = (){
      print(debugMessage);
    };

    if (textId == 'feedback') {
      myOnTap =
      () {
        Get.to(() => FeedbackScreen(
              resortName: lesson.resortName,
              teamName: lesson.teamName,
              instructorName: lesson.instructorName,
              startTime: lesson.startTime,
              endTime: lesson.endTime,
          feedbackImages: ["assets/images/person1.png","assets/images/person1.png","assets/images/person1.png","assets/images/person1.png","assets/images/person1.png"],
          feedbackVideos: ["assets/images/person2.png","assets/images/person2.png","assets/images/person2.png","assets/images/person2.png","assets/images/person2.png","assets/images/person2.png"],
          feedbackText: "홍길동님, 안녕하세요!\n 오늘 스키 강습을 담당했던 김싸피라고 합니다.우리가 오늘 함께 연습했던 기술들에 대해서 간단하게 설명드리고, 그에 대한 피드백을 전달드리고자 합니다.\n첫 번째로, '스노우플라우'는 스키의 앞부분을 서로 가깝게 하고 뒷부분을 벌려 스키가 'V'자 형태를 이루게 하는 기술입니다. 이를 통해 속도를 조절하고 정지할 수 있죠. 홍길동님은 이 기술에서 체중 이동을 잘 해내셨어요. 정말 잘하셨습니다!\n다음으로, '스노우 플라우 턴'은 스노우플라우 자세에서 방향을 전환하는 기술입니다. 이때 중요한 것은 스키 끝이 서로 너무 멀어지지 않게 조절하는 것인데, 여기서 조금 아쉬웠던 점이 있습니다. 앞으로 이 부분에 조금 더 신경을 써 주시면 좋겠습니다.\n마지막으로, '슈템턴'은 한쪽 스키의 끝을 들고 반대쪽 스키로 회전하는 기술입니다. 여기서는 발을 모으는 타이밍이 조금 맞지 않았어요. 이 기술은 타이밍이 중요하므로, 다음 강습에서는 이 부분을 좀 더 집중적으로 연습해 보도록 하겠습니다.\n 오늘 강습에 참여해 주셔서 정말 감사합니다. 스키를 타며 즐거운 시간을 보내셨기를 바라며, 봄바람이 살랑이는 이 좋은 계절에 더욱 멋진 스키 실력을 쌓아가시길 응원합니다. 다음 강습에서 또 만나요!\n 김싸피 드림",
            ));
      };
    } else {
      myOnTap =
      () => print(debugMessage);
    }

    return GoskiMiddlesizeButton(
      width: screenSizeController.getWidthByRatio(1),
      text: tr(textId),
      onTap: myOnTap,
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

  Column detailColumn(
      _Lesson lesson, ScreenSizeController screenSizeController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        detailRow(
            'name',
            tr('dynamicInstructor', args: [lesson.instructorName]),
            goskiFontSmall),
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
              text: DateFormat('yyyy.MM.dd (E)')
                  .format(lesson.startTime)
                  .toString(),
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
