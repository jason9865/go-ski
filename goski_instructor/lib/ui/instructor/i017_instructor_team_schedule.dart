import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/const/util/week_day_parser.dart';
import 'package:goski_instructor/ui/component/goski_build_interval.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_dropdown.dart';
import 'package:goski_instructor/ui/component/goski_floating_button.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class InstructorTeamScheduleScreen extends StatefulWidget {
  const InstructorTeamScheduleScreen({super.key});

  @override
  State<InstructorTeamScheduleScreen> createState() =>
      _InstructorTeamScheduleScreen();
}

class _InstructorTeamScheduleScreen
    extends State<InstructorTeamScheduleScreen> {
  final List<String> timeList = List.generate(17, (index) => '${8 + index}시');
  List<Schedule> scheduleList = [];
  List<DateTime> dateList = [];
  String selectedDate = '';
  final imageSize = screenSizeController.getWidthByRatio(0.25);
  @override
  void initState() {
    super.initState();
    updateScheduleList(dummy);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoskiContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTeamCard(),
              const BuildInterval(),
              buildSelectDateDropdown(),
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
      floatingActionButton: GoskiFloatingButton(
        onTap: () => logger.d("일정 추가"),
      ),
    );
  }

  void updateScheduleList(List<Map<String, dynamic>> dummy) async {
    scheduleList.clear();
    dateList.clear();
    final DateTime now = DateTime.now();

    if (selectedDate.isEmpty) {
      selectedDate = DateFormat('yyyy-MM-dd').format(now);
    }

    // 오늘 이전까지 데이터 제거
    dummy.removeWhere((entry) {
      DateTime lessonDate = DateTime.parse(entry['lesson_date']);
      return lessonDate.isBefore(DateTime(now.year, now.month, now.day));
    });

    // 최소 및 최대 날짜 계산 for dateList
    if (dummy.isNotEmpty) {
      DateTime firstLessonDate = DateTime.parse(dummy.first['lesson_date']);
      DateTime lastLessonDate = DateTime.parse(dummy.last['lesson_date']);
      int length = lastLessonDate.difference(firstLessonDate).inDays + 1;

      for (int i = 0; i < length; i++) {
        dateList.add(firstLessonDate.add(Duration(days: i)));
      }
    }

    Map<String, int> dateTimeIndex = {};
    int index = 0;

    // lesson_date && instructor_name를 기준으로 Schedule instance 생성 및 추가
    for (var entry in dummy) {
      if (entry['lesson_date'] != selectedDate) continue;

      String key = '${entry['lesson_date']}-${entry['instructor_name']}';
      if (!dateTimeIndex.containsKey(key)) {
        dateTimeIndex[key] = index++;

        DateTime lessonDate = DateTime.parse(entry['lesson_date']);
        Instructor instructor = Instructor(
          name: entry['instructor_name'],
          profileUrl: entry['instructor_profile_url'],
        );

        scheduleList.add(Schedule(lessonDate, instructor));
      }
    }

    // Schedule 업데이트
    for (Schedule schedule in scheduleList) {
      String key =
          '${schedule.lessonDate.toString().substring(0, 10)}-${schedule.instructor.name}';
      int scheduleIndex = dateTimeIndex[key]!;

      dummy
          .where((entry) =>
              entry['lesson_date'] ==
                  schedule.lessonDate.toString().substring(0, 10) &&
              entry['instructor_name'] == schedule.instructor.name)
          .forEach((entry) {
        updateScheduleItem(schedule, entry, scheduleIndex);
      });
    }
  }

  void updateScheduleItem(
      Schedule schedule, Map<String, dynamic> entry, int index) {
    List<ScheduleItem> target = scheduleList[index].items;
    int startTimeIndex = parseTimeToIndex(entry["start_time"]);
    target[startTimeIndex].duration = double.parse(entry["duration"]);
    target[startTimeIndex].studentCount = int.parse(entry["studentCount"]);
    target[startTimeIndex].name = entry["name"];
    target[startTimeIndex].lessonType = entry["lessonType"];
    target[startTimeIndex].isDesignated = int.parse(entry["is_designated"]);

    for (int i = 1; i <= (target[startTimeIndex].duration / 0.5) - 1; i++) {
      if (startTimeIndex + i < target.length) {
        target[startTimeIndex + i].duration = 0.0;
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

  Widget buildTeamCard() {
    return GoskiCard(
      child: Container(
        color: goskiWhite,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenSizeController.getHeightByRatio(0.02),
            horizontal: screenSizeController.getWidthByRatio(0.02),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/images/penguin.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GoskiText(
                    text: tr('dynamicTeam', args: ['Goski']),
                    size: goskiFontXXLarge,
                  ),
                  const GoskiText(
                    text: 'OO리조트',
                    size: goskiFontLarge,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => logger.d("팀 정보 페이지 이동"),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.arrow_forward_ios),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSelectDateDropdown() {
    List<String> formattedDateList = dateList.map((date) {
      return '${date.month}월 ${date.day}일 (${weekdayToString(date.weekday)})';
    }).toList();
    return Row(
      children: [
        SizedBox(
          width: screenSizeController.getWidthByRatio(0.4),
          child: GoskiDropdown(
            hint: tr('hintDate'),
            list: formattedDateList,
            onChanged: (dynamic newValue) {
              setState(() {
                selectedDate =
                    DateFormat('yyyy-MM-dd').format(dateList[newValue]);
                updateScheduleList(dummy);
              });
            },
          ),
        ),
      ],
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
      width: screenSizeController.getWidthByRatio(0.13),
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
          if (DateFormat('yyyy-MM-dd').format(scheduleList[index].lessonDate) ==
              selectedDate) {
            return SizedBox(
              width: screenSizeController.getWidthByRatio(0.25),
              child: buildSchedule(scheduleList[index]),
            );
          }
          return null;
        },
      ),
    );
  }

  Widget buildSchedule(Schedule schedule) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: imageSize / 2,
                  height: imageSize / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(schedule.instructor.profileUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                GoskiText(
                  text: schedule.instructor.name,
                  size: goskiFontMedium,
                ),
              ],
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

class Instructor {
  String name;
  String profileUrl;
  Instructor({
    required this.name,
    required this.profileUrl,
  });
}

class Schedule {
  List<ScheduleItem> items;
  DateTime lessonDate;
  Instructor instructor;

  Schedule(
    this.lessonDate,
    this.instructor,
  ) : items = List.generate(32, (index) => ScheduleItem());
}

List<Map<String, dynamic>> dummy = [
  {
    "instructor_name": "송준석",
    "instructor_profile_url": "assets/images/person1.png",
    "lesson_date": "2024-04-28",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    "instructor_name": "송준석",
    "instructor_profile_url": "assets/images/person1.png",
    "lesson_date": "2024-04-29",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "1"
  },
  {
    "instructor_name": "최지찬",
    "instructor_profile_url": "assets/images/person1.png",
    "lesson_date": "2024-04-29",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    "instructor_name": "장승호",
    "instructor_profile_url": "assets/images/person1.png",
    "lesson_date": "2024-04-29",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    "instructor_name": "임종율",
    "instructor_profile_url": "assets/images/person1.png",
    "lesson_date": "2024-04-29",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    "instructor_name": "송준석",
    "instructor_profile_url": "assets/images/person1.png",
    "lesson_date": "2024-04-30",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    "instructor_name": "송준석",
    "instructor_profile_url": "assets/images/person1.png",
    "lesson_date": "2024-04-30",
    "start_time": "1400",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    "instructor_name": "임종율",
    "instructor_profile_url": "assets/images/person1.png",
    "lesson_date": "2024-04-30",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    "instructor_name": "고승민",
    "instructor_profile_url": "assets/images/person1.png",
    "lesson_date": "2024-04-30",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
  {
    "instructor_name": "송준석",
    "instructor_profile_url": "assets/images/person1.png",
    "lesson_date": "2024-05-02",
    "start_time": "0800",
    "duration": "2",
    "name": "송준석", //예약자 이름
    "studentCount": "2",
    "lessonType": "ski", //스키, 보드 여부
    "is_designated": "0"
  },
];
