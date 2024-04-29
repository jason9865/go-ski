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
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class TeamScheduleScreen extends StatefulWidget {
  const TeamScheduleScreen({super.key});

  @override
  State<TeamScheduleScreen> createState() => _TeamScheduleScreenState();
}

class _TeamScheduleScreenState extends State<TeamScheduleScreen> {
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
    return GoskiContainer(
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
    );
  }

  void updateScheduleList(List<Map<String, dynamic>> dummy) async {
    scheduleList.clear();
    dateList.clear();
    final DateTime now = DateTime.now();
    if (selectedDate.isEmpty) {
      selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }

    for (int i = 0; i < dummy.length; i++) {
      if (DateTime.parse(dummy[i]['lesson_date']).month == now.month &&
          DateTime.parse(dummy[i]['lesson_date']).day == now.day) continue;
      if (DateTime.parse(dummy[i]['lesson_date']).isBefore(now)) {
        dummy.remove(dummy[i]);
      }
    }

    Map<String, dynamic> firstLesson = dummy[0];
    DateTime firstLessonDate = DateTime.parse(firstLesson['lesson_date']);
    Map<String, dynamic> lastLesson = dummy[dummy.length - 1];
    DateTime lastLessonDate = DateTime.parse(lastLesson['lesson_date']);
    Duration firstLessonToLastLesson =
        lastLessonDate.difference(firstLessonDate);

    int length = firstLessonToLastLesson.inDays + 1;

    Map<String, int> dateTimeIndex = {};
    int index = 0;
    for (int i = 0; i < length; i++) {
      DateTime indexDate = firstLessonDate.add(Duration(days: i));
      dateList.add(indexDate);

      for (int j = 0; j < dummy.length; j++) {
        DateTime dummyDateIndex = DateTime.parse(dummy[j]['lesson_date']);
        if (dummyDateIndex.isAfter(indexDate)) {
          break;
        }
        if (dummyDateIndex == indexDate) {
          scheduleList.add(
            Schedule(
              indexDate,
              Instructor(
                name: dummy[j]['instructor_name'],
                profileUrl: dummy[j]['instructor_profile_url'],
              ),
            ),
          );
          dateTimeIndex[
                  '${dummy[j]['lesson_date']}-${dummy[j]['instructor_name']}'] =
              index++;
          // dummy.remove(dummy[j]);
        }
      }
    }
    for (int i = 0; i < dummy.length; i++) {
      if (dummy[i]['lesson_date'] != selectedDate) continue;
      logger.e("checkPoint");
      int index = dateTimeIndex[
          '${dummy[i]['lesson_date']}-${dummy[i]['instructor_name']}']!; // dateTimeIndex로 dummy에 해당하는 Schedule 객체를 scheduleList에서 search
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
    "is_designated": "0"
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
