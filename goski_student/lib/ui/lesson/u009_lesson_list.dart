import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/default_image.dart';
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
import 'package:goski_student/ui/lesson/u011_check_instructor.dart';
import 'package:goski_student/ui/lesson/u014_feedback.dart';
import 'package:goski_student/ui/lesson/u015_review.dart';
import 'package:goski_student/view_model/cancel_lesson_view_model.dart';
import 'package:goski_student/view_model/feedback_view_model.dart';
import 'package:goski_student/view_model/instructor_profile_view_model.dart';
import 'package:goski_student/view_model/lesson_list_view_model.dart';
import 'package:goski_student/view_model/review_view_model.dart';

class LessonListScreen extends StatefulWidget {

  const LessonListScreen({super.key});

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {
  final lessonListViewModel = Get.find<LessonListViewModel>();

  final feedbackViewModel = Get.find<FeedbackViewModel>();

  final reviewViewModel = Get.find<ReviewViewModel>();

  final cancelLessonViewModel = Get.find<CancelLessonViewModel>();

  final instructorProfileViewModel = Get.find<InstructorProfileViewModel>();

  @override
  void initState() {
    super.initState();
    lessonListViewModel.getLessonList();
  }

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
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
          appBar: GoskiSubHeader(title: tr('lessonHistory')),
          body: GoskiContainer(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: lessonListViewModel.lessonList.length,
              itemBuilder: (BuildContext context, int index) {
                final lesson = lessonListViewModel.lessonList[index];
                final now = DateTime.now();
                String lessonStatus = lesson.lessonStatus;
                if (lessonStatus == 'yesFeedback') {
                  lessonStatus = 'lessonFinished';
                }
                Color lessonBackgroundColor = lessonStatus == 'notStart'
                    ? goskiDarkPink
                    : lessonStatus == 'onGoing'
                        ? goskiBlue
                        : goskiGreen;

                List<Widget> buttons = [];
                if (lessonStatus == 'notStart') {
                  buttons.add(createButton(
                    screenSizeController,
                    'cancelLesson',
                    tr('cancelLesson'),
                    lesson,
                    () {
                      goToCancelLessonScreen(lesson);
                    },
                  ));
                }
                if (lessonStatus != 'lessonFinished' && lessonStatus != 'cancelLesson' && lesson.instructorId != null) {
                  buttons.add(createButton(
                    screenSizeController,
                    'instructorProfile',
                    tr('instructorProfile'),
                    lesson,
                        () {
                      goToCheckInstructorScreen(lesson);
                    },
                  ));
                }
                if (lesson.startTime
                        .isBefore(now.add(const Duration(minutes: 30))) &&
                    lesson.endTime.isAfter(now) && lessonStatus != 'cancelLesson') {
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
                      () {
                        if (lesson.hasReview) {
                          goToFeedbackScreen(lesson);
                        } else {
                          goToReviewScreen(lesson, true);
                        }
                      },
                    ),
                  ]);
                  if (!lesson.hasReview) {
                    buttons.add(
                      createButton(
                        screenSizeController,
                        'writeReview',
                        tr('writeReview'),
                        lesson,
                        () {
                          goToReviewScreen(lesson, false);
                        },
                      ),
                    );
                  }
                }
                MainAxisAlignment alignment = buttons.length == 1
                    ? MainAxisAlignment.center
                    : buttons.length == 2
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.spaceBetween;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
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
          ),
        );
      }
    });
  }

  void goToCancelLessonScreen(LessonListItem lesson) async {
    lessonListViewModel.selectedLesson.value = lesson;
    cancelLessonViewModel.getLessonCost(lesson.lessonId);

    Get.to(() => CancelLessonScreen());
  }

  void goToCheckInstructorScreen(LessonListItem lesson) async {
    lessonListViewModel.selectedLesson.value = lesson;
    await instructorProfileViewModel.getInstructorProfile(lesson.instructorId!);
    await instructorProfileViewModel.getInstructorReview(lesson.instructorId!);

    Get.to(() => CheckInstructorScreen());
  }

  void goToReviewScreen(LessonListItem lesson, bool goFeedbackScreen) async {
    lessonListViewModel.selectedLesson.value = lesson;
    await reviewViewModel.getReviewTagList();
    reviewViewModel.initReview();

    Get.to(() => ReviewScreen(goFeedbackScreen: goFeedbackScreen));
  }

  void goToFeedbackScreen(LessonListItem lesson) async {
    lessonListViewModel.selectedLesson.value = lesson;
    feedbackViewModel.getFeedback(lesson.lessonId);

    Get.to(() => FeedbackScreen());
  }

  void goToSendMessageDialog(BuildContext context, LessonListItem lesson) {
    lessonListViewModel.initMessage(lesson);

    showDialog(
      context: context,
      builder: (context) {
        return GoskiModal(
          title: tr('sendMessageTitle', args: [
            (lesson.instructorName == null ? '이름 없음' : lesson.instructorName!)
          ]),
          child: const SendMessageDialog(),
        );
      },
    );
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
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Image.network(
            lesson.profileUrl != null ? lesson.profileUrl! : s3Penguin,
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
            lesson.instructorName != null
                ? tr('dynamicInstructor', args: [lesson.instructorName!])
                : tr('unDesignated'),
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
