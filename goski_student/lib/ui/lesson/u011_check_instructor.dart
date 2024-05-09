import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/data/model/instructor_profile_response.dart';
import 'package:goski_student/data/model/lesson_list_response.dart';
import 'package:goski_student/data/model/review_response.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/view_model/instructor_profile_view_model.dart';
import 'package:goski_student/view_model/lesson_list_view_model.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class CheckInstructorScreen extends StatelessWidget {
  final lessonListViewModel = Get.find<LessonListViewModel>();
  final instructorProfileViewModel = Get.find<InstructorProfileViewModel>();

  CheckInstructorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Rx<LessonListItem> lesson = lessonListViewModel.selectedLesson;

    return Obx(
      () => Scaffold(
        appBar: GoskiSubHeader(
          title: tr('instructorProfile'),
        ),
        body: GoskiContainer(
          child: SingleChildScrollView(
            child: GoskiCard(
              child: Container(
                color: goskiWhite,
                child: Column(
                  children: [
                    Container(
                      color: goskiLightGray,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                screenSizeController.getHeightByRatio(0.01)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoskiText(
                              text: lesson.value.resortName,
                              size: goskiFontXLarge,
                            ),
                            const GoskiText(
                              text: ' - ',
                              size: goskiFontXLarge,
                            ),
                            GoskiText(
                              text: lesson.value.teamName,
                              size: goskiFontXLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                    buildProfile(),
                    const Divider(
                      height: 0,
                    ),
                    buildSelfIntroduction(),
                    const Divider(
                      height: 0,
                    ),
                    buildCertificateImages(),
                    const Divider(
                      height: 0,
                    ),
                    buildReviews(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfile() {
    Rx<InstructorProfile> profile =
        instructorProfileViewModel.instructorProfile;

    return Padding(
      padding: EdgeInsets.all(
        screenSizeController.getWidthByRatio(0.03),
      ),
      child: Row(
        children: [
          Container(
            width: screenSizeController.getWidthByRatio(0.25),
            height: screenSizeController.getWidthByRatio(0.3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(profile.value.profileUrl!),
          ),
          Expanded(
            child: Column(
              children: [
                buildBasicInfoRow(
                  tr('name'),
                  GoskiText(
                    text: profile.value.userName,
                    size: goskiFontLarge,
                  ),
                ),
                buildBasicInfoRow(
                  tr('gender'),
                  GoskiText(
                    text: tr(profile.value.gender.name),
                    size: goskiFontLarge,
                  ),
                ),
                buildBasicInfoRow(
                  tr('certificate'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GoskiText(
                            text: tr('ski'),
                            size: goskiFontMedium,
                          ),
                          GoskiText(
                            text: tr(' : '),
                            size: goskiFontMedium,
                          ),
                          GoskiText(
                            text: instructorProfileViewModel.skiCertificate
                                .join(', '),
                            size: goskiFontMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GoskiText(
                            text: tr('board'),
                            size: goskiFontMedium,
                          ),
                          GoskiText(
                            text: tr(' : '),
                            size: goskiFontMedium,
                          ),
                          GoskiText(
                            text: instructorProfileViewModel.boardCertificate
                                .join(', '),
                            size: goskiFontMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBasicInfoRow(String category, Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenSizeController.getHeightByRatio(0.004)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenSizeController.getWidthByRatio(0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoskiText(
                  text: category,
                  size: goskiFontLarge,
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget buildSelfIntroduction() {
    Rx<InstructorProfile> profile =
        instructorProfileViewModel.instructorProfile;

    return Padding(
      padding: EdgeInsets.all(
        screenSizeController.getWidthByRatio(0.03),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenSizeController.getHeightByRatio(0.005)),
            child: Row(
              children: [
                GoskiText(
                  text: tr('selfIntroduction'),
                  size: goskiFontLarge,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenSizeController.getWidthByRatio(0.01)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: GoskiText(
                    text: profile.value.description,
                    size: goskiFontMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCertificateImages() {
    Rx<InstructorProfile> profile =
        instructorProfileViewModel.instructorProfile;

    return Padding(
      padding: EdgeInsets.all(
        screenSizeController.getWidthByRatio(0.03),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenSizeController.getHeightByRatio(0.005)),
            child: Row(
              children: [
                GoskiText(
                  text: tr('certificate'),
                  size: goskiFontLarge,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              screenSizeController.getWidthByRatio(0.01),
            ),
            child: Card(
              color: goskiWhite,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: screenSizeController.getHeightByRatio(0.15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: profile.value.certificates.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                          profile.value.certificates[index].certificateImageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReviews() {
    RxList<ReviewResponse> reviewList = instructorProfileViewModel.reviewList;

    return Padding(
      padding: EdgeInsets.all(
        screenSizeController.getWidthByRatio(0.03),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenSizeController.getHeightByRatio(0.005)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GoskiText(
                      text: tr('review'),
                      size: goskiFontLarge,
                    ),
                    GoskiText(
                      text: ' (${reviewList.length})',
                      size: goskiFontMedium,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: goskiYellow,
                      size: 20,
                    ),
                    GoskiText(
                      text: ' ${instructorProfileViewModel.getAvgRate()}',
                      size: goskiFontMedium,
                    ),
                  ],
                )
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: min(3, reviewList.length),
            itemBuilder: (context, index) {
              return buildReview(reviewList[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget buildReview(ReviewResponse review) {
    List<Widget> starList = [];

    for (int i = 0; i < review.rating; i++) {
      starList.add(buildStar());
    }

    for (int i = 0; i < 5 - review.rating; i++) {
      starList.add(buildEmptyStar());
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSizeController.getWidthByRatio(0.03),
        vertical: screenSizeController.getHeightByRatio(0.005),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GoskiText(
                text: review.content,
                size: goskiFontMedium,
              ),
              Row(
                children: starList,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStar() {
    return const Icon(
      Icons.star,
      color: goskiYellow,
      size: 18,
    );
  }

  Widget buildEmptyStar() {
    return const Icon(
      Icons.star_border,
      color: goskiYellow,
      size: 18,
    );
  }
}
