import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:logger/logger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class InstructorsIntroductionScreen extends StatefulWidget {
  const InstructorsIntroductionScreen({super.key});

  @override
  State<InstructorsIntroductionScreen> createState() =>
      _InstructorsIntroductionScreen();
}

class _InstructorsIntroductionScreen
    extends State<InstructorsIntroductionScreen> {
  Instructor? instructor;
  final PageController _pageController = PageController();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoskiContainer(
      onConfirm: () => logger.d("지정강사 예약"),
      buttonName: "180,000원 - 지정강사 예약",
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenSizeController.getHeightByRatio(0.8),
              child: PageView.builder(
                itemCount: 4,
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
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GoskiText(
                                  text: 'OO리조트',
                                  size: goskiFontXLarge,
                                ),
                                GoskiText(
                                  text: ' - ',
                                  size: goskiFontXLarge,
                                ),
                                GoskiText(
                                  text: '팀이름1',
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
            const BuildInterval(),
            SmoothPageIndicator(
              controller: _pageController,
              count: 4,
              effect: const WormEffect(),
            ),
          ],
        ),
      ),
    );
  }

  void fetchData() {
    instructor = Instructor(
      resort: dummy["resort"],
      teamName: dummy["teamName"],
      instructorName: dummy["instructorName"],
      gender: dummy["gender"],
      certificateList: dummy["certificateList"],
      selfIntroduction: dummy["selfIntroduction"],
      certificateImageList: dummy["certificateImageList"],
      rating: dummy["rating"],
      reviewList: dummy["reviewList"],
    );
  }

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
              image: const DecorationImage(
                image: AssetImage("assets/images/person1.png"),
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
                  const GoskiText(
                    text: '임종율',
                    size: goskiFontLarge,
                  ),
                ),
                buildBasicInfoRow(
                  tr('gender'),
                  GoskiText(
                    text: tr('male'),
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
                          const GoskiText(
                            text: 'Teaching 1, ',
                            size: goskiFontMedium,
                          ),
                          const GoskiText(
                            text: 'Level 1',
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
                          const GoskiText(
                            text: 'Level 1',
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: GoskiText(
                    text:
                        '안녕하세요, 저는 임종율입니다. 스키와 보드에 대한 열정을 가지고 있어요. 스키장에서 만나 뵐 수 있기를 기대합니다. 함께 멋진 겨울 스포츠의 추억을 만들어 가요!',
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
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.asset(
                          "assets/images/certificate.png",
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
                    const GoskiText(
                      text: ' (3개)',
                      size: goskiFontMedium,
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: goskiYellow,
                      size: 20,
                    ),
                    GoskiText(
                      text: ' 4.5',
                      size: goskiFontMedium,
                    ),
                  ],
                )
              ],
            ),
          ),
          buildReview(),
          buildReview(),
          buildReview(),
        ],
      ),
    );
  }

  Widget buildReview() {
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
              const GoskiText(
                text: '리뷰1 내용 ...',
                size: goskiFontMedium,
              ),
              Row(
                children: [
                  buildStar(),
                  buildStar(),
                  buildStar(),
                  buildStar(),
                  buildStar(),
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
}

Map<String, dynamic> dummy = {
  "resort": "OO리조트",
  "teamName": "팀이름1",
  "instructorName": "송준석",
  "gender": "male",
  "certificateList": [
    {
      "ski": [
        "Level1",
        "Teaching1",
      ],
    },
    {
      "board": [
        "Level1",
      ],
    },
  ],
  "selfIntroduction": "자기소개입니다.",
  "certificateImageList": [
    "assets/images/certificate.png",
    "assets/images/certificate.png",
    "assets/images/certificate.png",
  ],
  "rating": 4.5,
  "reviewList": [
    {
      "star": 3,
      "reviewContent": "리뷰1",
    },
    {
      "star": 4.5,
      "reviewContent": "리뷰2",
    },
    {
      "star": 4,
      "reviewContent": "리뷰3",
    },
    {
      "star": 5,
      "reviewContent": "리뷰4",
    },
  ],
};

class Instructor {
  final String resort;
  final String teamName;
  final String instructorName;
  final String gender;
  final List<Map<String, List<String>>> certificateList;
  final String? selfIntroduction;
  final List<String> certificateImageList;
  final double? rating;
  final List<Map<String, dynamic>>? reviewList;

  Instructor({
    required this.resort,
    required this.teamName,
    required this.instructorName,
    required this.gender,
    required this.certificateList,
    this.selfIntroduction,
    required this.certificateImageList,
    this.rating,
    this.reviewList,
  });
}
