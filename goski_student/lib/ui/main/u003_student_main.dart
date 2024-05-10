import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/const/util/url_launch_util.dart';
import 'package:goski_student/ui/component/goski_bottomsheet.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_expansion_tile.dart';
import 'package:goski_student/ui/component/goski_main_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/lesson/u009_lesson_list.dart';
import 'package:goski_student/ui/lesson/u017_settlement.dart';
import 'package:goski_student/ui/main/b_u028_select_resort.dart';
import 'package:goski_student/ui/main/u026_coupon.dart';
import 'package:goski_student/ui/reservation/u018_reservation_select.dart';
import 'package:goski_student/view_model/lesson_list_view_model.dart';
import 'package:goski_student/view_model/main_view_model.dart';
import 'package:goski_student/view_model/reservation_view_model.dart';
import 'package:goski_student/view_model/settlement_view_model.dart';
import 'package:goski_student/view_model/ski_resort_view_model.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class StudentMainScreen extends StatelessWidget {
  // TODO: 추후에 API에서 광고 이미지 링크와 클릭시 이동 링크를 받아오도록 수정 필요
  final List<String> advList = [
    'https://adnet21.co.kr/data/file/b0301/thumb-3717079066_0ksWLuKg_1EC9588_EC9790EB8DB4EBB0B8EBA6AC_20ECB488.mov_000017462_1000x563.png',
    'https://imagescdn.gettyimagesbank.com/500/202111/jv12498198.jpg',
    'https://i.ytimg.com/vi/uNYg8av06Ow/maxresdefault.jpg',
    'https://www.greened.kr/news/photo/202212/299330_329087_4332.png',
    'https://cdn.gpkorea.com/news/photo/202212/96211_210544_551.jpg',
    'https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=https%3A%2F%2Ft1.daumcdn.net%2Fcfile%2Ftistory%2F276A8A3651D3914524',
  ];
  final mainViewModel = Get.find<MainViewModel>();
  final lessonListViewModel = Get.find<LessonListViewModel>();
  final settlementViewModel = Get.find<SettlementViewModel>();

  StudentMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: const GoskiMainHeader(),
        body: GoskiContainer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildProfileCard(),
                const BuildInterval(),
                buildAdvertisement(),
                const BuildInterval(),
                buildResortInfo(context),
                const BuildInterval(),
                const BuildInterval(),
                buildManual(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileCard() {
    return GoskiCard(
      child: Container(
        color: goskiWhite,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenSizeController.getHeightByRatio(0.02),
            horizontal: screenSizeController.getWidthByRatio(0.07),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GoskiText(
                        text: tr('hello'),
                        size: goskiFontLarge,
                        color: goskiDarkGray,
                      ),
                      Obx(
                        () => GoskiText(
                          text: tr('dynamicUser',
                              args: [mainViewModel.userInfo.value.userName]),
                          size: goskiFontXXLarge,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const BuildInterval(),
              const BuildInterval(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserMenu(
                    iconName: 'myLesson',
                    iconImage: 'assets/images/user.svg',
                    onClick: () => {
                      logger.d("나의 강습"),
                      Get.to(() => const LessonListScreen())
                    },
                  ),
                  UserMenu(
                    iconName: 'paymentHistory',
                    iconImage: 'assets/images/receipt.svg',
                    onClick: () => {
                      logger.d("결제 내역"),
                      settlementViewModel.getSettlementList(),
                      Get.to(() => const SettlementScreen())
                    },
                  ),
                  UserMenu(
                    iconName: 'reservation',
                    iconImage: 'assets/images/calendar.svg',
                    onClick: () =>
                        // {logger.d("예약"), Get.toNamed("/reservation")},
                        {
                      logger.d("예약"),
                      Get.to(() => const ReservationSelectScreen(),
                          binding: BindingsBuilder(() {
                        Get.lazyPut<ReservationViewModel>(
                            () => ReservationViewModel());
                        Get.put(SkiResortViewModel());
                      }))
                    },
                  ),
                  UserMenu(
                    iconName: 'couponBox',
                    iconImage: 'assets/images/couponBox.svg',
                    onClick: () => {
                      logger.d("쿠폰함"),
                      Get.to(() => CouponScreen()),
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAdvertisement() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2,
        enlargeCenterPage: true,
      ),
      items: advList
          .map((item) => GestureDetector(
                onTap: () {
                  // TODO: 추후에 광고 클릭시 이동 링크로 변경 필요
                  UrlLaunchUtil.launch('https://ssafy.com/');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: goskiDashGray,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: screenSizeController.getWidthByRatio(1),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget buildResortInfo(BuildContext context) {
    return GoskiCard(
      child: Container(
        color: goskiWhite,
        height: screenSizeController.getHeightByRatio(0.5),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => showGoskiBottomSheet(
                        context: context, child: SelectResortBottomSheet()),
                    child: Row(
                      children: [
                        GoskiText(
                          text:
                              mainViewModel.selectedSkiResort.value.resortName,
                          size: goskiFontXLarge,
                        ),
                        const Icon(
                          size: 35,
                          Icons.keyboard_arrow_down,
                        ),
                      ],
                    ),
                  ),
                  buildWeather(),
                ],
              ),
              const Expanded(
                child: Center(
                  child: GoskiText(
                    text: "24/25 시즌에 만나요!",
                    size: goskiFontXXLarge,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWeather() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (mainViewModel.isWeatherLoading.value) ...[
            const SizedBox(
              height: 30,
              width: 30,
              child: Center(
                child: CircularProgressIndicator(
                  color: goskiBlack,
                ),
              ),
            )
          ] else ...[
            Image.network(
              mainViewModel.weather.value.iconUrl,
              height: 30,
              width: 30,
            ),
            Row(
              children: [
                GoskiText(
                  text: mainViewModel.weather.value.temp.toString(),
                  size: goskiFontXLarge,
                ),
                Image.asset(
                  height: 20,
                  'assets/images/celsius.png',
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }

  Widget buildManual() {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildManualButton('termsOfUse', () => logger.d("이용약관")),
                const Text(' | '),
                buildManualButton('privacyPolicy', () => logger.d("개인정보처리방침")),
                const Text(' | '),
                buildManualButton('businessInfo', () => logger.d("사업자 정보")),
                const Text(' | '),
                buildManualButton('refundPolicy2', () => logger.d("환불 정책	")),
              ],
            ),
            SizedBox(
              height: screenSizeController.getHeightByRatio(0.01),
            ),
            GoskiText(
              text: tr('disclaimer'),
              size: goskiFontMedium,
            ),
            SizedBox(
              height: screenSizeController.getHeightByRatio(0.01),
            ),
            GoskiText(
              text: tr('copyright'),
              size: goskiFontMedium,
              color: goskiDarkGray,
            ),
            SizedBox(
              height: screenSizeController.getHeightByRatio(0.01),
            ),
            GoskiExpansionTile(
              backgroundColor: goskiDashGray,
              title: GoskiText(
                text: tr('goskiBusinessInfo'),
                size: goskiFontMedium,
              ),
              children: const [
                Text('사업자정보 입력'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildManualButton(String buttonName, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: GoskiText(
        text: tr(buttonName),
        size: goskiFontMedium,
      ),
    );
  }
}

class UserMenu extends StatelessWidget {
  final String iconName;
  final String iconImage;
  final VoidCallback onClick;

  const UserMenu({
    required this.iconName,
    required this.iconImage,
    required this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        children: [
          SvgPicture.asset(
            iconImage,
            width: 45,
            height: 45,
            colorFilter: const ColorFilter.mode(
              goskiBlack,
              BlendMode.srcIn,
            ),
          ),
          GoskiText(
            text: tr(
              iconName,
            ),
            size: goskiFontLarge,
          )
        ],
      ),
    );
  }
}
