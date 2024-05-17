import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/const/util/week_day_parser.dart';
import 'package:goski_instructor/ui/component/goski_build_interval.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_main_header.dart';
import 'package:goski_instructor/ui/component/goski_modal.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/ui/instructor/d_i013_lesson_detail.dart';
import 'package:goski_instructor/view_model/instructor_main_view_model.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class InstructorMainScreen extends StatefulWidget {
  const InstructorMainScreen({super.key});

  @override
  State<InstructorMainScreen> createState() => _InstructorMainScreenState();
}

class _InstructorMainScreenState extends State<InstructorMainScreen> {
  // 좌측 타임라인 생성을 위한 리스트
  final List<String> timeList = List.generate(16, (index) => '${8 + index}');
  final instructorMainViewModel = Get.find<InstructorMainViewModel>();

  @override
  void initState() {
    super.initState();
    instructorMainViewModel.getInstructorInfo();
    instructorMainViewModel.getTeamList();
    instructorMainViewModel.getScheduleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GoskiMainHeader(),
      body: GoskiContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildProfileCard(),
              const BuildInterval(),
              buildTeamPageView(),
              const BuildInterval(),
              GoskiCard(
                child: Row(
                  children: [
                    buildTimeLine(),
                    buildScheduleView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileCard() {
    final profileSize = screenSizeController.getWidthByRatio(0.25);
    return Obx(
      () => GoskiCard(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    instructorMainViewModel
                            .instructorInfo.value.profileUrl.isNotEmpty
                        ? Container(
                            width: profileSize,
                            height: profileSize,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(instructorMainViewModel
                                    .instructorInfo.value.profileUrl),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          )
                        : SizedBox(
                            width: profileSize,
                            height: profileSize,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GoskiText(
                          text: instructorMainViewModel
                              .instructorInfo.value.userName,
                          size: goskiFontXXLarge,
                        ),
                        GoskiText(
                          text: tr('dynamicInstructor', args: ['']),
                          size: goskiFontXLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSizeController.getHeightByRatio(0.03),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserMenu(
                      iconName: 'couponBox',
                      iconImage: 'assets/images/couponBox.svg',
                      onClick: () {
                        Get.toNamed('/coupon');
                      },
                    ),
                    UserMenu(
                      iconName: 'reviewHistory',
                      iconImage: 'assets/images/reviewHistory.svg',
                      onClick: () {
                        Get.toNamed('/reviewList');
                      },
                    ),
                    UserMenu(
                      iconName: 'lessonHistory',
                      iconImage: 'assets/images/lessonHistory.svg',
                      onClick: () {
                        Get.toNamed('/lessonList');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTeamPageView() {
    return Obx(
      () => SizedBox(
        height: screenSizeController.getHeightByRatio(0.18),
        child: PageView.builder(
          itemCount: instructorMainViewModel.instructorTeamList.length,
          itemBuilder: (context, index) {
            return GoskiCard(
              child: Container(
                color: goskiWhite,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSizeController.getWidthByRatio(0.03),
                      ),
                      child: Container(
                        width: screenSizeController.getWidthByRatio(0.3),
                        height: screenSizeController.getHeightByRatio(0.13),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(instructorMainViewModel
                                .instructorTeamList[index].profileUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: screenSizeController.getWidthByRatio(0.02)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoskiText(
                              text: instructorMainViewModel
                                  .instructorTeamList[index].teamName,
                              size: goskiFontLarge,
                              maxLine: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height:
                                  screenSizeController.getHeightByRatio(0.01),
                            ),
                            GoskiText(
                              text: instructorMainViewModel
                                  .instructorTeamList[index].description,
                              size: goskiFontMedium,
                              maxLine: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildTimeLine() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: goskiLightGray),
        ),
        color: goskiWhite,
      ),
      height: screenSizeController.getHeightByRatio(0.925),
      width: screenSizeController.getWidthByRatio(0.15) - 8,
      child: Column(
        children: [
          SizedBox(
            height: screenSizeController.getHeightByRatio(0.1),
            width: double.infinity,
          ),
          ...timeList.map((time) => BuildTimeContainer(hour: time)),
        ],
      ),
    );
  }

  Widget buildScheduleView() {
    return SizedBox(
      height: screenSizeController.getHeightByRatio(0.925),
      width: screenSizeController.getWidthByRatio(0.75),
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: instructorMainViewModel.scheduleColumnList.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: screenSizeController.getWidthByRatio(0.25),
              child: buildSchedule(
                  instructorMainViewModel.scheduleColumnList[index]),
            );
          },
        ),
      ),
    );
  }

  Widget buildSchedule(ScheduleColumn scheduleColumn) {
    String weekday = weekdayToString(scheduleColumn.lessonDate.weekday);
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: goskiLightGray,
          ),
        ),
        color: goskiWhite,
      ),
      height: screenSizeController.getHeightByRatio(0.925),
      width: screenSizeController.getWidthByRatio(0.25),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: goskiWhite,
              border: Border(
                bottom: BorderSide(
                  color: goskiLightGray,
                ),
              ),
            ),
            height: screenSizeController.getHeightByRatio(0.1),
            width: screenSizeController.getWidthByRatio(0.25),
            child: Center(
              child: GoskiText(
                text:
                    '$weekday\n${scheduleColumn.lessonDate.month}/${scheduleColumn.lessonDate.day}',
                size: goskiFontLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ...scheduleColumn.items.map(
            (item) => BuildScheduleContainer(scheduleColumnItem: item),
          ),
        ],
      ),
    );
  }
}

class BuildTimeContainer extends StatelessWidget {
  final String hour;

  const BuildTimeContainer({
    super.key,
    required this.hour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: goskiLightGray),
        ),
      ),
      height: screenSizeController.getHeightByRatio(0.05),
      width: double.infinity,
      child: Center(
        child: GoskiText(
          text: hour,
          size: goskiFontLarge,
        ),
      ),
    );
  }
}

class BuildScheduleContainer extends StatelessWidget {
  final ScheduleColumnItem scheduleColumnItem;

  const BuildScheduleContainer({
    required this.scheduleColumnItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: scheduleColumnItem.lessonId != 0
          ? () => showDialog(
                context: context,
                builder: (BuildContext context) => GoskiModal(
                  title: tr('lessonInfo'),
                  child: LessonDetailDialog(
                    lessonId: scheduleColumnItem.lessonId,
                  ),
                ),
              )
          : () => 0,
      child: Container(
        decoration: BoxDecoration(
          color: scheduleColumnItem.representativeName.isEmpty
              ? goskiWhite
              : goskiBackground,
          border: scheduleColumnItem.representativeName.isEmpty
              ? const Border.symmetric(
                  horizontal: BorderSide(color: goskiDarkGray, width: 0.02),
                  vertical: BorderSide(color: goskiDarkGray, width: 0.02),
                )
              : Border.all(color: goskiDarkGray, width: 0.1),
        ),
        height: screenSizeController
            .getHeightByRatio(0.05 * scheduleColumnItem.duration),
        width: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Center(
              child: GoskiText(
                text: scheduleColumnItem.representativeName.isEmpty
                    ? ''
                    : '1:${scheduleColumnItem.studentCount} ${tr(scheduleColumnItem.lessonType)}\n${scheduleColumnItem.representativeName}',
                size: goskiFontMedium,
                textAlign: TextAlign.center,
              ),
            ),
            if (scheduleColumnItem.isDesignated)
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.check,
                  color: goskiDarkPink,
                  size: 20,
                ),
              ),
          ],
        ),
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
