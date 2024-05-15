import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/data/model/review_response.dart';
import 'package:goski_instructor/ui/component/goski_badge.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_sub_header.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/view_model/review_view_model.dart';

import '../../main.dart';

class ReviewListScreen extends StatefulWidget {
  const ReviewListScreen({super.key});

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  final reviewlistviewModel = Get.find<ReviewViewModel>();

  @override
  void initState() {
    super.initState();
    reviewlistviewModel.getReviewList();
  }

  @override
  Widget build(BuildContext context) {
    List<Review> reviewList = reviewlistviewModel.reviewList;

    return Obx(() {
      if (reviewlistviewModel.isLoadingReviewList.value) {
        return Scaffold(
          appBar: GoskiSubHeader(title: tr('reviewHistory')),
          body: const GoskiContainer(
            child: Center(
              child: CircularProgressIndicator(
                color: goskiBlack,
              ),
            ),
          ),
        );
      } else if (reviewlistviewModel.reviewList.isEmpty) {
        return Scaffold(
          appBar: GoskiSubHeader(title: tr('reviewHistory')),
          body: GoskiContainer(
            child: Center(
              child: GoskiText(
                text: tr('noReviewHistory'),
                size: goskiFontLarge,
              ),
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: GoskiSubHeader(
            title: tr('reviewHistory'),
          ),
          body: GoskiContainer(
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
                                  text: DateFormat('yyyy-MM-dd')
                                      .format(review.lessonDate),
                                  size: goskiFontSmall,
                                  color: goskiDarkGray,
                                ),
                                GoskiText(
                                  text: " ${review.lessonTime}",
                                  size: goskiFontSmall,
                                  color: goskiDarkGray,
                                )
                              ],
                            ),
                            SizedBox(
                              height:
                                  screenSizeController.getHeightByRatio(0.005),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GoskiText(
                                  text: review.representativeName,
                                  size: goskiFontMedium,
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
                              height:
                                  screenSizeController.getHeightByRatio(0.01),
                            ),
                            GoskiText(
                                text: review.content, size: goskiFontMedium),
                            SizedBox(
                              height:
                                  screenSizeController.getHeightByRatio(0.01),
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
                                    text:
                                        '+${review.instructorTags.length - 2}',
                                    backgroundColor: goskiLightGray,
                                    textColor: goskiBlack,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
        );
      }
    });
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
