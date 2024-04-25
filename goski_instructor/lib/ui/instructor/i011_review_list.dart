import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_badge.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_tag.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

class ReviewListScreen extends StatelessWidget {
  const ReviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();

    final List<_InstructorTag> instTagList = [
      _InstructorTag(tagName: "최고에요", tagReviewId: 1),
      _InstructorTag(tagName: "친절해요", tagReviewId: 2),
      _InstructorTag(tagName: "잘생겼어요", tagReviewId: 3),
      _InstructorTag(tagName: "못생겼어요", tagReviewId: 4),
      _InstructorTag(tagName: "착해요", tagReviewId: 5),
    ];

    final List<_Review> reviewList = [
      _Review(
        lessonDate: "2024.04.25",
        lessonTime: "14:00~16:00",
        rating: 4,
        content: "강사님 최고에요!",
        representativeName: "랜덤닉네임",
        instructorTags: instTagList,
      ),
      _Review(
        lessonDate: "2024.04.25",
        lessonTime: "14:00~16:00",
        rating: 4,
        content: "강사님 최고에요!",
        representativeName: "랜덤닉네임",
        instructorTags: instTagList,
      ),
      _Review(
        lessonDate: "2024.04.25",
        lessonTime: "14:00~16:00",
        rating: 4,
        content: "강사님 최고에요!",
        representativeName: "랜덤닉네임",
        instructorTags: instTagList,
      ),
      _Review(
        lessonDate: "2024.04.25",
        lessonTime: "14:00~16:00",
        rating: 4,
        content: "강사님 최고에요!",
        representativeName: "랜덤닉네임",
        instructorTags: instTagList,
      ),
      _Review(
        lessonDate: "2024.04.25",
        lessonTime: "14:00~16:00",
        rating: 4,
        content: "강사님 최고에요!",
        representativeName: "랜덤닉네임",
        instructorTags: instTagList,
      ),
      _Review(
        lessonDate: "2024.04.25",
        lessonTime: "14:00~16:00",
        rating: 4,
        content: "강사님 최고에요!",
        representativeName: "랜덤닉네임",
        instructorTags: instTagList,
      ),
      _Review(
        lessonDate: "2024.04.25",
        lessonTime: "14:00~16:00",
        rating: 4,
        content: "강사님 최고에요!",
        representativeName: "랜덤닉네임",
        instructorTags: instTagList,
      ),
      _Review(
        lessonDate: "2024.04.25",
        lessonTime: "14:00~16:00",
        rating: 4,
        content: "강사님 최고에요!",
        representativeName: "랜덤닉네임",
        instructorTags: instTagList,
      ),
      _Review(
        lessonDate: "2024.04.25",
        lessonTime: "14:00~16:00",
        rating: 4,
        content: "강사님 최고에요!",
        representativeName: "랜덤닉네임",
        instructorTags: instTagList,
      ),
    ];

    return GoskiContainer(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: reviewList.length,
            itemBuilder: (BuildContext context, int index) {
              final review = reviewList[index];

              return GoskiCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GoskiText(
                            text: review.lessonDate,
                            size: bodySmall,
                            color: goskiDarkGray,
                          ),
                          GoskiText(
                            text: " ${review.lessonTime}",
                            size: bodySmall,
                            color: goskiDarkGray,
                          )
                        ],
                      ),
                      SizedBox(
                        height: screenSizeController.getHeightByRatio(0.005),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GoskiText(
                            text: review.representativeName,
                            size: bodyMedium,
                            isBold: true,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (index) {
                              return Icon(
                                index < review.rating
                                    ? Icons.star
                                    : Icons.star_border,
                                // 조건에 따라 별 채우기 또는 테두리
                                color: Colors.yellow, // 별점 색상
                              );
                            }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: screenSizeController.getHeightByRatio(0.01),
                      ),
                      GoskiText(text: review.content, size: bodyMedium),
                      SizedBox(
                        height: screenSizeController.getHeightByRatio(0.01),
                      ),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: [
                          ...review.instructorTags
                              .take(2)
                              .map((tag) => GoskiBadge(
                                    text: tag.tagName,
                                    backgroundColor: goskiLightGray,
                                    textColor: goskiBlack,
                                  )),
                          if (review.instructorTags.length > 2)
                            GoskiBadge(
                              text: '+${review.instructorTags.length - 2}',
                              backgroundColor: goskiLightGray,
                              textColor: goskiBlack,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}

class _Review {
  final String lessonDate;
  final String lessonTime;
  final double rating;
  final String content;
  final String representativeName;
  final List<_InstructorTag> instructorTags;

  _Review(
      {required this.lessonDate,
      required this.lessonTime,
      required this.rating,
      required this.content,
      required this.representativeName,
      required this.instructorTags});
}

class _InstructorTag {
  final int tagReviewId;
  final String tagName;

  _InstructorTag({required this.tagReviewId, required this.tagName});
}
