import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/data/data_source/lesson_payment_service.dart';
import 'package:goski_student/data/model/instructor.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/data/repository/lesson_payment_repository.dart';
import 'package:goski_student/main.dart';
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
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InstructorsIntroductionScreen extends StatefulWidget {
  final BeginnerResponse teamInfo;
  final List<Instructor> instructorList;
  final int index;

  const InstructorsIntroductionScreen({
    super.key,
    required this.teamInfo,
    required this.instructorList,
    required this.index,
  });

  @override
  State<InstructorsIntroductionScreen> createState() =>
      _InstructorsIntroductionScreen();
}

class _InstructorsIntroductionScreen
    extends State<InstructorsIntroductionScreen> {
  late PageController _pageController;
  late var cost = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    cost = widget.instructorList[widget.index].cost;
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoskiSubHeader(
        title: tr('designatedLesson'),
      ),
      body: GoskiContainer(
        onConfirm: () {
          logger.d("지정강사 예약");
          Get.to(
              LessonReservationScreen(
                teamInformation: widget.teamInfo,
                instructor: widget.instructorList[widget.index],
              ), binding: BindingsBuilder(() {
            Get.lazyPut(() => LessonPaymentService());
            Get.lazyPut(() => LessonPaymentRepository());
            // Get.put(() => StudentInfoViewModel());
            Get.lazyPut(() => StudentInfoViewModel());
            Get.lazyPut(() => LessonPaymentViewModel());
          }));
        },
        buttonName: tr('designatedReserve',
            args: [NumberFormat('###,###,###').format(cost)]),
        child: Column(
          children: [
            SizedBox(
              height: screenSizeController.getHeightByRatio(0.73),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    cost = widget.instructorList[index].cost;
                  });
                },
                itemCount: widget.instructorList.length,
                itemBuilder: (context, index) => GoskiCard(
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
                                  text: tr(widget.teamInfo.teamName),
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
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const Divider(
                                  height: 0,
                                ),
                                buildProfile(index),
                                const Divider(
                                  height: 0,
                                ),
                                buildSelfIntroduction(index),
                                const Divider(
                                  height: 0,
                                ),
                                buildCertificateImages(index),
                                const Divider(
                                  height: 0,
                                ),
                                buildReviews(index),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const BuildInterval(),
            SmoothPageIndicator(
              controller: _pageController,
              count: widget.instructorList.length,
              effect: ScrollingDotsEffect(
                dotHeight: screenSizeController.getHeightByRatio(0.01),
                dotWidth: screenSizeController.getHeightByRatio(0.01),
                activeDotScale: 1.3,
                activeDotColor: goskiBlack
              ),
            ),
          ],
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

  Widget buildProfile(int index) {
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
                image: NetworkImage(widget.instructorList[index].instructorUrl),
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
                    text: widget.instructorList[index].userName,
                    size: goskiFontLarge,
                  ),
                ),
                buildBasicInfoRow(
                  tr('gender'),
                  GoskiText(
                    text: tr(widget.instructorList[index].gender),
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
                              text: widget.instructorList[index].skiCertificate
                                  .join(', '),
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
                              text: widget
                                  .instructorList[index].boardCertificate
                                  .join(', '),
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

  Widget buildSelfIntroduction(int index) {
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
                    text: tr(widget.instructorList[index].description),
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

  Widget buildCertificateImages(int index) {
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
              margin: EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: screenSizeController.getHeightByRatio(0.15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      widget.instructorList[index].certificateList.length,
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
                                  imageUrl: widget.instructorList[index]
                                      .certificateList[idx].certificateImageUrl,
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Image.network(
                            widget.instructorList[index].certificateList[idx]
                                .certificateImageUrl,
                            fit: BoxFit.fitHeight,
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

  Widget buildReviews(int index) {
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
                      text: ' ${widget.instructorList[index].reviewCount}개',
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
                      text:
                          ' ${(widget.instructorList[index].rating ?? 0.0).toStringAsFixed(1)}',
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
            itemCount: widget.instructorList[index].reviews!.length < 3
                ? widget.instructorList[index].reviews?.length
                : 3,
            itemBuilder: (context, idx) {
              return buildReview(widget.instructorList[index].reviews![idx]);
            },
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
              Expanded(
                child: GoskiText(
                  text: lessonReview.reviewContent,
                  size: goskiFontMedium,
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis,
                ),
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
