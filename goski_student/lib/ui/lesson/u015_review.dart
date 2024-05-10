import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_multi_select_tags.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/component/goski_textfield.dart';
import 'package:goski_student/ui/lesson/u014_feedback.dart';
import 'package:goski_student/view_model/lesson_list_view_model.dart';
import 'package:goski_student/view_model/review_view_model.dart';

class ReviewScreen extends StatelessWidget {
  final imageWidth = screenSizeController.getWidthByRatio(0.5);
  final lessonListViewModel = Get.find<LessonListViewModel>();
  final reviewViewModel = Get.find<ReviewViewModel>();
  final bool goFeedbackScreen;

  ReviewScreen({
    super.key,
    required this.goFeedbackScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: GoskiSubHeader(
            title: tr('review'),
          ),
          body: GoskiContainer(
            buttonName: reviewViewModel.rating > 0 ? tr('completed') : null,
            onConfirm: reviewViewModel.rating > 0
                ? () async {
                    bool result = await reviewViewModel.writeReview(
                        lessonListViewModel.selectedLesson.value.lessonId);

                    await lessonListViewModel.getLessonList();

                    if (result) {
                      if (goFeedbackScreen) {
                        Get.off(() => FeedbackScreen());
                      } else {
                        Get.back();
                      }
                    }
                  }
                : null,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/penguin.png",
                    width: imageWidth,
                    height: imageWidth,
                    fit: BoxFit.fitHeight,
                  ),
                  infoCard(context),
                  StarRating(
                    onChanged: (rating) {
                      reviewViewModel.rating.value = rating;
                    },
                    value: reviewViewModel.rating.value,
                  ),
                  if (reviewViewModel.rating > 0) ...[
                    GoskiCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GoskiText(
                              text: tr('lessonReview'),
                              size: goskiFontMedium,
                              isBold: true,
                            ),
                            GoskiTextField(
                              hintText: tr('reviewHint'),
                              maxLines: 2,
                              onTextChange: (text) {
                                reviewViewModel.content.value = text;
                              },
                            ),
                            const BuildInterval(),
                            GoskiText(
                              text: tr("instructorReview"),
                              size: goskiFontMedium,
                              isBold: true,
                            ),
                            GoskiMultiSelectTags(
                              tags: reviewViewModel.reviewTagList
                                  .map((reviewTag) => reviewTag.tagName)
                                  .toList(),
                              isSelected: reviewViewModel.isSelected,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                  if (goFeedbackScreen) ...[
                    GestureDetector(
                      onTap: () {
                        Get.off(() => FeedbackScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GoskiText(
                              text: tr('skip'),
                              size: goskiFontXSmall,
                              color: goskiDarkGray,
                            )
                          ],
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          )),
    );
  }

  Widget infoCard(BuildContext context) {
    var lesson = lessonListViewModel.selectedLesson;

    return GoskiCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoskiText(text: lesson.value.resortName, size: goskiFontLarge),
                const GoskiText(text: " - ", size: goskiFontLarge),
                GoskiText(text: lesson.value.teamName, size: goskiFontLarge),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoskiText(
                  text: tr(DateFormat('yyyy.MM.dd (E) HH:mm')
                      .format(lesson.value.startTime)
                      .toString()),
                  size: goskiFontSmall,
                  color: goskiDarkGray,
                ),
                GoskiText(
                  text: tr(DateFormat('~HH:mm')
                      .format(lesson.value.endTime)
                      .toString()),
                  size: goskiFontSmall,
                  color: goskiDarkGray,
                ),
              ],
            ),
            GoskiText(
              text: tr('dynamicInstructor', args: [
                lesson.value.instructorName == null
                    ? '이름 없음'
                    : lesson.value.instructorName!
              ]),
              size: goskiFontSmall,
              color: goskiDarkGray,
            ),
          ],
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int value;
  final void Function(int) onChanged;

  const StarRating({super.key, this.value = 0, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) {
          return IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              index < value ? Icons.star : Icons.star_border,
            ),
            color: goskiYellow,
            iconSize: 40,
            onPressed: () {
              onChanged(index + 1);
            },
          );
        },
      ),
    );
  }
}
