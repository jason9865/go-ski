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
import 'package:goski_instructor/ui/component/goski_text.dart';
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
  final List<TeamInfo> teamList = [
    TeamInfo(
        teamName: '팀이름1',
        teamImage: 'assets/images/penguin.png',
        teamIntroduction: '1팀소개입니다.'),
    TeamInfo(
        teamName: '팀이름2',
        teamImage: 'assets/images/penguin.png',
        teamIntroduction: '2팀소개입니다.'),
    TeamInfo(
        teamName: '팀이름3',
        teamImage: 'assets/images/penguin.png',
        teamIntroduction: '3팀소개입니다.'),
  ];

  // 좌측 타임라인 생성을 위한 리스트
  final List<String> timeList = List.generate(17, (index) => '${8 + index}시');
  List<Schedule> scheduleList = [];
  final instructorMainViewModel = Get.find<InstructorMainViewModel>();

  @override
  void initState() {
    super.initState();
    instructorMainViewModel.getInstructorInfo();
    instructorMainViewModel.getTeamList();
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

  void updateScheduleList(List<Map<String, dynamic>> dummy) {
    scheduleList.clear();
    final DateTime now = DateTime.now();

    // 오늘 이전까지 데이터 제거
    dummy.removeWhere((entry) {
      DateTime lessonDate = DateTime.parse(entry['lesson_date']);
      return lessonDate.isBefore(DateTime(now.year, now.month, now.day));
    });

    DateTime firstLessonDate = DateTime.parse(dummy.first['lesson_date']);
    DateTime lastLessonDate = DateTime.parse(dummy.last['lesson_date']);
    int length = lastLessonDate.difference(firstLessonDate).inDays + 1;

    Map<String, int> dateTimeIndex = {};
    for (int i = 0; i < length; i++) {
      DateTime indexDate = firstLessonDate.add(Duration(days: i));
      dateTimeIndex[indexDate.toString().substring(0, 10)] = i;
      scheduleList.add(Schedule(indexDate));
    }
    for (int i = 0; i < dummy.length; i++) {
      int index = dateTimeIndex[dummy[i][
          'lesson_date']]!; // dateTimeIndex로 dummy에 해당하는 Schedule 객체를 scheduleList에서 search
      List<ScheduleItem> target =
          scheduleList[index].items; // 바꿀 Schedule Column
      int startTimeIndex = parseTimeToIndex(dummy[i][
          "start_time"]); // dummy["start_time"]를 Schedule.items의 index로 parsing
      target[startTimeIndex].duration = double.parse(dummy[i]["duration"]);
      target[startTimeIndex].studentCount = int.parse(dummy[i]["studentCount"]);
      target[startTimeIndex].name = dummy[i]["name"];
      target[startTimeIndex].lessonType = dummy[i]["lessonType"];
      target[startTimeIndex].isDesignated =
          int.parse(dummy[i]["is_designated"]);
      for (int i = 1; i <= (target[startTimeIndex].duration / 0.5) - 1; i++) {
        if (startTimeIndex + i < target.length) {
          target[startTimeIndex + i].duration = 0.0;
        }
      }
    }
  }

  // 시간String을 index로 parsing, ex. "0800" => 0
  int parseTimeToIndex(String time) {
    int hour = int.parse(time.substring(0, 2));
    int minute = int.parse(time.substring(2, 4));

    int totalMinutes = hour * 60 + minute;

    return totalMinutes ~/ 30 - 16;
  }

  Widget buildTeamPageView() {
    return SizedBox(
      height: screenSizeController.getHeightByRatio(0.18),
      child: PageView.builder(
        itemCount: instructorMainViewModel.instructorTeamList.length,
        itemBuilder: (context, index) {
          return GoskiCard(
            child: Container(
              color: goskiWhite,
              child: Row(
                children: [
                  SizedBox(width: screenSizeController.getWidthByRatio(0.02)),
                  Container(
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
                  SizedBox(width: screenSizeController.getWidthByRatio(0.02)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GoskiText(
                            text: instructorMainViewModel
                                .instructorTeamList[index].teamName,
                            size: goskiFontXLarge),
                        SizedBox(
                          height: screenSizeController.getHeightByRatio(0.01),
                        ),
                        GoskiText(
                            text: instructorMainViewModel
                                .instructorTeamList[index].description,
                            size: goskiFontLarge),
                      ],
                    ),
                  ),
                  SizedBox(width: screenSizeController.getWidthByRatio(0.02)),
                ],
              ),
            ),
          );
        },
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
      width: screenSizeController.getWidthByRatio(0.115),
      child: Column(
        children: [
          SizedBox(
            height: screenSizeController.getHeightByRatio(0.075),
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
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: scheduleList.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: screenSizeController.getWidthByRatio(0.25),
            child: buildSchedule(scheduleList[index]),
          );
        },
      ),
    );
  }

  Widget buildSchedule(Schedule schedule) {
    String weekday = weekdayToString(schedule.lessonDate.weekday);
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
                    '$weekday\n${schedule.lessonDate.month}/${schedule.lessonDate.day}',
                size: goskiFontLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ...schedule.items.map(
            (item) => BuildScheduleContainer(scheduleItem: item),
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
          bottom: BorderSide(color: goskiLightGray),
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
  final ScheduleItem scheduleItem;

  const BuildScheduleContainer({
    required this.scheduleItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: scheduleItem.name.isEmpty ? goskiWhite : goskiLightGray,
      ),
      height:
          screenSizeController.getHeightByRatio(0.05 * scheduleItem.duration),
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Center(
            child: GoskiText(
              text: scheduleItem.name.isEmpty
                  ? ''
                  : '1:${scheduleItem.studentCount} ${tr(scheduleItem.lessonType)}\n${scheduleItem.name}',
              size: goskiFontLarge,
              textAlign: TextAlign.center,
            ),
          ),
          if (scheduleItem.isDesignated == 1)
            const Positioned(
              top: -8,
              child: Icon(
                Icons.push_pin_rounded,
                color: goskiRed,
              ),
            ),
        ],
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

class TeamInfo {
  final String teamName;
  final String teamImage;
  final String teamIntroduction;

  TeamInfo(
      {required this.teamName,
      required this.teamImage,
      required this.teamIntroduction});
}

class ScheduleItem {
  double duration;
  int studentCount;
  String name;
  String lessonType;
  int isDesignated;

  ScheduleItem({
    this.duration = 0.5,
    this.studentCount = 0,
    this.name = '',
    this.lessonType = '',
    this.isDesignated = 0,
  });
}

class Schedule {
  List<ScheduleItem> items;
  DateTime lessonDate;

  Schedule(this.lessonDate)
      : items = List.generate(32, (index) => ScheduleItem());
}

List<Map<String, dynamic>> dummy = [
  {
    'lesson_date': "2024-04-28",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    'lesson_date': "2024-04-29",
    "start_time": "0830",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "1"
  },
  {
    'lesson_date': "2024-04-29",
    "start_time": "1300",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    'lesson_date': "2024-04-29",
    "start_time": "1600",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    'lesson_date': "2024-04-30",
    "start_time": "0900",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "1"
  },
  {
    'lesson_date': "2024-04-30",
    "start_time": "1500",
    "duration": "3",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    'lesson_date': "2024-05-01",
    "start_time": "0930",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    'lesson_date': "2024-05-02",
    "start_time": "1000",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    'lesson_date': "2024-05-04",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    'lesson_date': "2024-05-05",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    'lesson_date': "2024-05-06",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    'lesson_date': "2024-05-07",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    'lesson_date': "2024-05-08",
    "start_time": "1000",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
];
