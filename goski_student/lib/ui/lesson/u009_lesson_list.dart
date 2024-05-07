import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/data/model/lesson_list_response.dart';
import 'package:goski_student/ui/component/goski_badge.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_middlesize_button.dart';
import 'package:goski_student/ui/component/goski_modal.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/lesson/d_u012_send_message.dart';
import 'package:goski_student/ui/lesson/u010_cancel_lesson.dart';
import 'package:goski_student/ui/lesson/u014_feedback.dart';
import 'package:goski_student/ui/lesson/u015_review.dart';
import 'package:goski_student/view_model/lesson_list_view_model.dart';

class LessonListScreen extends StatelessWidget {
  final lessonListViewModel = Get.find<LessonListViewModel>();

  LessonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    cardOnTap() => print("강습 세부정보");

    return Obx(
      () => Scaffold(
        appBar: GoskiSubHeader(title: tr('lessonHistory')),
        body: GoskiContainer(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: lessonListViewModel.lessonList.length,
            itemBuilder: (BuildContext context, int index) {
              final lesson = lessonListViewModel.lessonList[index];
              final now = DateTime.now();
              String lessonStatus = 'notStart';
              Color lessonBackgroundColor = goskiDarkPink;

              if (lesson.startTime.isBefore(now) &&
                  lesson.endTime.isAfter(now)) {
                lessonStatus = 'onGoing';
                lessonBackgroundColor = goskiBlue;
              } else if (lesson.endTime.isBefore(now)) {
                lessonStatus = 'lessonFinished';
                lessonBackgroundColor = goskiGreen;
              }

              List<Widget> buttons = [];
              if (lessonStatus == 'notStart') {
                buttons.add(createButton(
                  screenSizeController,
                  'cancelLesson',
                  tr('cancelLesson'),
                  lesson,
                  () {},
                ));
              }
              if (lesson.startTime
                      .isBefore(now.add(const Duration(minutes: 30))) &&
                  lesson.endTime.isAfter(now)) {
                buttons.add(createButton(
                  screenSizeController,
                  'sendMessage',
                  tr('sendMessage'),
                  lesson,
                  () {
                    goToSendMessageDialog(context, lesson);
                  },
                ));
              }
              if (lesson.endTime.isBefore(now)) {
                buttons.addAll([
                  createButton(
                    screenSizeController,
                    'reLesson',
                    tr('reLessonRequest'),
                    lesson,
                    () {},
                  ),
                  createButton(
                    screenSizeController,
                    'feedback',
                    tr('feedbackCheck'),
                    lesson,
                    () {},
                  ),
                  createButton(
                    screenSizeController,
                    'review',
                    tr('writeReview'),
                    lesson,
                    () {},
                  ),
                ]);
              }

              MainAxisAlignment alignment = buttons.length == 1
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.spaceBetween;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: GestureDetector(
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void goToCancelLessonScreen() {
    Get.to(() => CancelLessonScreen());
  }

  void goToReviewScreen(LessonListItem lesson) {
    Get.to(() => ReviewScreen(
          resortName: lesson.resortName,
          teamName: lesson.teamName,
          instructorName: lesson.instructorName!,
          startTime: lesson.startTime,
          endTime: lesson.endTime,
        ));
  }

  void goToFeedbackScreen(LessonListItem lesson) {
    Get.to(() => FeedbackScreen(
          resortName: lesson.resortName,
          teamName: lesson.teamName,
          instructorName: lesson.instructorName!,
          startTime: lesson.startTime,
          endTime: lesson.endTime,
          feedbackImages: [
            "assets/images/person1.png",
            "assets/images/person1.png",
            "assets/images/person1.png",
            "assets/images/person1.png",
            "assets/images/person1.png"
          ],
          feedbackVideos: [
            "assets/images/person2.png",
            "assets/images/person2.png",
            "assets/images/person2.png",
            "assets/images/person2.png",
            "assets/images/person2.png",
            "assets/images/person2.png"
          ],
          feedbackText:
              "홍길동님, 안녕하세요!\n 오늘 스키 강습을 담당했던 김싸피라고 합니다.우리가 오늘 함께 연습했던 기술들에 대해서 간단하게 설명드리고, 그에 대한 피드백을 전달드리고자 합니다.\n첫 번째로, '스노우플라우'는 스키의 앞부분을 서로 가깝게 하고 뒷부분을 벌려 스키가 'V'자 형태를 이루게 하는 기술입니다. 이를 통해 속도를 조절하고 정지할 수 있죠. 홍길동님은 이 기술에서 체중 이동을 잘 해내셨어요. 정말 잘하셨습니다!\n다음으로, '스노우 플라우 턴'은 스노우플라우 자세에서 방향을 전환하는 기술입니다. 이때 중요한 것은 스키 끝이 서로 너무 멀어지지 않게 조절하는 것인데, 여기서 조금 아쉬웠던 점이 있습니다. 앞으로 이 부분에 조금 더 신경을 써 주시면 좋겠습니다.\n마지막으로, '슈템턴'은 한쪽 스키의 끝을 들고 반대쪽 스키로 회전하는 기술입니다. 여기서는 발을 모으는 타이밍이 조금 맞지 않았어요. 이 기술은 타이밍이 중요하므로, 다음 강습에서는 이 부분을 좀 더 집중적으로 연습해 보도록 하겠습니다.\n 오늘 강습에 참여해 주셔서 정말 감사합니다. 스키를 타며 즐거운 시간을 보내셨기를 바라며, 봄바람이 살랑이는 이 좋은 계절에 더욱 멋진 스키 실력을 쌓아가시길 응원합니다. 다음 강습에서 또 만나요!\n 김싸피 드림",
        ));
  }

  void goToSendMessageDialog(BuildContext context, LessonListItem lesson) {
    showDialog(
      context: context,
      builder: (context) {
        return GoskiModal(
          title: tr('sendMessageTitle', args: [
            (lesson.instructorName == null ? '이름 없음' : lesson.instructorName!)
          ]),
          child: SendMessageDialog(),
        );
      },
    ).then((value) {
      lessonListViewModel.initMessage(lesson);
    });
  }

  Widget createButton(ScreenSizeController screenSizeController, String textId,
      String debugMessage, LessonListItem lesson, VoidCallback myOnTap) {
    return GoskiMiddlesizeButton(
      width: screenSizeController.getWidthByRatio(0.95),
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

  Row profileRow(
      LessonListItem lesson, ScreenSizeController screenSizeController) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Image.asset(
            lesson.profileUrl != null
                ? lesson.profileUrl!
                : 'assets/images/person1.png',
            width: 90,
            height: screenSizeController.getHeightByRatio(0.12),
            fit: BoxFit.fitHeight,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenSizeController.getWidthByRatio(0.05)),
          child: detailColumn(lesson, screenSizeController),
        ),
      ],
    );
  }

  Column detailColumn(
      LessonListItem lesson, ScreenSizeController screenSizeController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        detailRow(
            'name',
            tr('dynamicInstructor', args: [
              lesson.instructorName == null ? '이름 없음' : lesson.instructorName!
            ]),
            goskiFontSmall),
        SizedBox(height: screenSizeController.getHeightByRatio(0.005)),
        detailRow('location', lesson.resortName, goskiFontSmall),
        SizedBox(height: screenSizeController.getHeightByRatio(0.005)),
        dateRow(lesson),
        SizedBox(height: screenSizeController.getHeightByRatio(0.005)),
      ],
    );
  }

  Row dateRow(LessonListItem lesson) {
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

  Row timeRow(LessonListItem lesson) {
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
      width: 60,
      child: GoskiText(
        text: tr(labelId),
        size: goskiFontMedium,
        isBold: true,
      ),
    );
  }

  Widget buttonRow(List<Widget> buttons, MainAxisAlignment alignment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: alignment,
        children: buttons,
      ),
    );
  }
}
