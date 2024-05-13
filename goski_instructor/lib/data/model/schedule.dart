import 'package:goski_instructor/data/model/student_info.dart';

class ScheduleResponse {
  int resortId;
  int studentCount;
  String lessonDate;
  String startTime;
  int duration;
  String lessonType;
  int lessonId;
  int teamId;
  String teamName;
  String resortName;
  List<StudentInfoResponse> studentInfos;
  String representativeName;
  bool isDesignated;
  int instructorId;
  ScheduleResponse({
    required this.resortId,
    required this.studentCount,
    required this.lessonDate,
    required this.startTime,
    required this.duration,
    required this.lessonType,
    required this.lessonId,
    required this.teamId,
    required this.teamName,
    required this.resortName,
    required this.studentInfos,
    required this.representativeName,
    required this.isDesignated,
    required this.instructorId,
  });
}
