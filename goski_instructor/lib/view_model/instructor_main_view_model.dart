import 'package:get/get.dart';
import 'package:goski_instructor/data/model/instructor.dart';
import 'package:goski_instructor/data/model/schedule.dart';
import 'package:goski_instructor/data/model/team.dart';
import 'package:goski_instructor/data/repository/schedule_repository.dart';
import 'package:goski_instructor/data/repository/team_repository.dart';
import 'package:goski_instructor/data/repository/user_repository.dart';
import 'package:goski_instructor/main.dart';
import 'package:logger/logger.dart';

class InstructorMainViewModel extends GetxController {
  final UserRespository userRespository = Get.find();
  final TeamRepository teamRepository = Get.find();
  final ScheduleRepository scheduleRepository = Get.find();
  Rx<Instructor> instructorInfo = Instructor().obs;
  RxList<Team> instructorTeamList = <Team>[].obs;
  RxList<Schedule> scheduleList = <Schedule>[].obs;
  RxList<ScheduleColumn> scheduleColumnList = <ScheduleColumn>[].obs;
  late Schedule lesson;

  void getInstructorInfo() async {
    var response = await userRespository.getInstructorInfo();
    if (response != null) {
      instructorInfo.value = response;
    }
  }

  void getTeamList() async {
    var response = await teamRepository.getInstructorTeamList();
    if (response != null) {
      instructorTeamList.assignAll(response);
    }
  }

  void getScheduleList() async {
    var response = await scheduleRepository.getScheduleList();
    if (response != null) {
      scheduleList.clear();
      scheduleList.assignAll(response);
      sortScheduleListByLessonDate();
      updateScheduleList();
    }
  }

  void getLesson(int lessonId) {
    lesson = scheduleList.firstWhere((item) => item.lessonId == lessonId);
  }

  void sortScheduleListByLessonDate() {
    scheduleList.sort((a, b) =>
        DateTime.parse(a.lessonDate).compareTo(DateTime.parse(b.lessonDate)));
  }

  void updateScheduleList() {
    scheduleColumnList.clear();
    final DateTime now = DateTime.now();

    // 오늘 이전까지 데이터 제거
    scheduleList.removeWhere((schedule) {
      DateTime lessonDate = DateTime.parse(schedule.lessonDate);
      return lessonDate.isBefore(DateTime(now.year, now.month, now.day));
    });
    if (scheduleList.isEmpty) return;
    DateTime firstLessonDate = DateTime.parse(scheduleList.first.lessonDate);
    DateTime lastLessonDate = DateTime.parse(scheduleList.last.lessonDate);
    int length = lastLessonDate.difference(firstLessonDate).inDays + 1;

    Map<String, int> dateTimeIndex = {};
    for (int i = 0; i < length; i++) {
      DateTime indexDate = firstLessonDate.add(Duration(days: i));
      dateTimeIndex[indexDate.toString().substring(0, 10)] = i;
      scheduleColumnList.add(ScheduleColumn(indexDate));
    }

    for (int i = 0; i < scheduleList.length; i++) {
      int index = dateTimeIndex[scheduleList[i]
          .lessonDate]!; // dateTimeIndex로 scheduleList에 해당하는 Schedule 객체를 scheduleList에서 search
      List<ScheduleColumnItem> target =
          scheduleColumnList[index].items; // 바꿀 ScheduleColumn
      int startTimeIndex = parseTimeToIndex(scheduleList[i]
          .startTime); // scheduleList.startTime을 ScheduleColumn.items의 index로 parsing
      target[startTimeIndex].duration = scheduleList[i].duration.toDouble();
      target[startTimeIndex].studentCount = scheduleList[i].studentCount;
      target[startTimeIndex].lessonId = scheduleList[i].lessonId;
      target[startTimeIndex].representativeName =
          scheduleList[i].representativeName;
      target[startTimeIndex].lessonType = scheduleList[i].lessonType;
      target[startTimeIndex].isDesignated = scheduleList[i].isDesignated;
      for (int i = 1; i <= (target[startTimeIndex].duration / 0.5) - 1; i++) {
        if (startTimeIndex + i < target.length) {
          target[startTimeIndex + i].duration = 0;
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
}

class ScheduleColumnItem {
  double duration;
  int studentCount;
  String representativeName;
  String lessonType;
  bool isDesignated;
  int lessonId;

  ScheduleColumnItem({
    this.duration = 0.5,
    this.studentCount = 0,
    this.representativeName = '',
    this.lessonType = '',
    this.isDesignated = false,
    this.lessonId = 0,
  });
}

class ScheduleColumn {
  List<ScheduleColumnItem> items;
  DateTime lessonDate;

  ScheduleColumn(this.lessonDate)
      : items = List.generate(32, (index) => ScheduleColumnItem());
}
