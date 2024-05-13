import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/data/data_source/lesson_payment_service.dart';
import 'package:goski_student/data/model/instructor.dart';
import 'package:goski_student/data/repository/lesson_payment_repository.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_image_dialog.dart';
import 'package:goski_student/ui/component/goski_modal.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/lesson/u023_lesson_reservation.dart';
import 'package:goski_student/view_model/lesson_payment_view_model.dart';
import 'package:goski_student/view_model/student_info_view_model.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class AdvancedInstructorsIntroductionScreen extends StatefulWidget {
  Instructor instructor;

  AdvancedInstructorsIntroductionScreen({
    super.key,
    required this.instructor,
  });

  @override
  State<AdvancedInstructorsIntroductionScreen> createState() =>
      _InstructorsIntroductionScreen();
}

class _InstructorsIntroductionScreen
    extends State<AdvancedInstructorsIntroductionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoskiSubHeader(
        title: tr('designatedReserve',
            args: [NumberFormat('###,###,###').format(widget.instructor.cost)]),
      ),
      body: GoskiContainer(
        onConfirm: () {
          logger.d("지정강사 예약");
          Get.to(
              LessonReservationScreen(
                instructor: widget.instructor,
              ), binding: BindingsBuilder(() {
            Get.lazyPut(() => LessonPaymentService());
            Get.lazyPut(() => LessonPaymentRepository());
            // Get.put(() => StudentInfoViewModel());
            Get.lazyPut(() => StudentInfoViewModel());
            Get.lazyPut(() => LessonPaymentViewModel());
          }));
        },
        buttonName: tr('designatedReserve',
            args: [NumberFormat('###,###,###').format(widget.instructor.cost)]),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenSizeController.getHeightByRatio(0.9),
                child: GoskiCard(
                  child: Container(
                    color: goskiWhite,
                    child: Column(
                      children: [
                        Container(
                          color: goskiLightGray,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenSizeController
                                    .getHeightByRatio(0.01)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GoskiText(
                                  text: tr(widget.instructor.teamName),
                                  size: goskiFontXLarge,
                                ),
                                // GoskiText(
                                //   text: ' - ',
                                //   size: goskiFontXLarge,
                                // ),
                                // GoskiText(
                                //   text: '팀이름1',
                                //   size: goskiFontXLarge,
                                // ),
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
            ],
          ),
        ),
      ),
    );
  }

  // void fetchData() {
  //   instructor = _Instructor(
  //     resort: dummy["resort"],
  //     teamName: dummy["teamName"],
  //     instructorName: dummy["instructorName"],
  //     gender: dummy["gender"],
  //     certificateList: dummy["certificateList"],
  //     selfIntroduction: dummy["selfIntroduction"],
  //     certificateImageList: dummy["certificateImageList"],
  //     rating: dummy["rating"],
  //     reviewList: dummy["reviewList"],
  //   );
  // }

  Widget buildProfile() {
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
              image: DecorationImage(
                image: NetworkImage(widget.instructor.instructorUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                buildBasicInfoRow(
                  tr('name'),
                  GoskiText(
                    text: widget.instructor.userName,
                    size: goskiFontLarge,
                  ),
                ),
                buildBasicInfoRow(
                  tr('gender'),
                  GoskiText(
                    text: tr(widget.instructor.gender),
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
                          SizedBox(
                            width: screenSizeController.getWidthByRatio(0.3),
                            child: GoskiText(
                              text: widget.instructor.skiCertificate.join(', '),
                              size: goskiFontMedium,
                            ),
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
                          SizedBox(
                            width: screenSizeController.getWidthByRatio(0.3),
                            child: GoskiText(
                              text:
                                  widget.instructor.boardCertificate.join(', '),
                              size: goskiFontMedium,
                            ),
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
                    text: tr(widget.instructor.description),
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
                  itemCount: widget.instructor.certificateList.length,
                  itemBuilder: (context, idx) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return GoskiModal(
                                title: tr('feedbackImage'),
                                child: GoskiImageDialog(
                                  isLocalImage: false,
                                  imageUrl: widget.instructor
                                      .certificateList[idx].certificateImageUrl,
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Image.network(
                            widget.instructor.certificateList[idx]
                                .certificateImageUrl,
                            fit: BoxFit.fill,
                          ),
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
                      text: ' ${widget.instructor.reviewCount}개',
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
                      text: ' ${widget.instructor.rating}',
                      size: goskiFontMedium,
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.instructor.reviews!.length < 3
                    ? widget.instructor.reviews?.length
                    : 3,
                itemBuilder: (context, idx) {
                  return buildReview(widget.instructor.reviews![idx]);
                }),
          ),
        ],
      ),
    );
  }

  Widget buildReview(LessonReview lessonReview) {
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
                text: lessonReview.reviewContent,
                size: goskiFontMedium,
              ),
              Row(
                children: [
                  for (int i = 0; i < lessonReview.rating; i++) buildStar(),
                  for (int i = lessonReview.rating; i < 5; i++)
                    buildEmptyStar(),
                ],
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
