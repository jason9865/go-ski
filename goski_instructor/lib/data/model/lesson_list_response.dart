import 'package:goski_instructor/data/model/student_info.dart';
import 'package:intl/intl.dart';

class LessonListResponse {
  int lessonId;
  int teamId;
  String teamName;
  String resortName;
  DateTime lessonDate;
  DateTime startTime;
  int duration;
  String representativeName;
  bool isDesignated;
  List<StudentInfoResponse> studentInfoList;
  String lessonStatus;

  // bool hasReview;
  // int studentCount;

  LessonListResponse({
    required this.lessonId,
    required this.teamId,
    required this.teamName,
    required this.resortName,
    required this.lessonDate,
    required this.startTime,
    required this.duration,
    required this.representativeName,
    required this.isDesignated,
    required this.studentInfoList,
    required this.lessonStatus,
    // required this.hasReview,
    // required this.studentCount,
  });

  factory LessonListResponse.fromJson(Map<String, dynamic> json) {
    String timeString = json['startTime'];
    String formattedTimeString =
        "${timeString.substring(0, 2)}:${timeString.substring(2)}";
    String lessonDate = json['lessonDate'];
    String formattedDate = DateFormat('yyyy-MM-dd')
        .format(DateFormat('yyyy-MM-dd').parse(lessonDate));
    String combinedDateTimeString = "$formattedDate $formattedTimeString";
    DateTime dateTime =
        DateFormat("yyyy-MM-dd HH:mm").parse(combinedDateTimeString);
    List<dynamic> studentInfo = json['studentInfo'] as List<dynamic>;
    List<StudentInfoResponse> studentInfos =
        studentInfo.map((json) => StudentInfoResponse.fromJson(json)).toList();

    return LessonListResponse(
      lessonId: json['lessonId'] as int,
      teamId: json['teamId'] as int,
      teamName: json['teamName'] as String,
      resortName: json['resortName'] as String,
      lessonDate: DateTime.parse(lessonDate),
      startTime: dateTime,
      duration: json['duration'] as int,
      representativeName: json['representativeName'] as String,
      isDesignated: json['isDesignated'] as bool,
      studentInfoList: studentInfos,
      lessonStatus: json['lessonStatus'] as String,
      // hasReview: json['hasReview'] as bool,
      // studentCount: json['studentCount'] as int,
    );
  }

  @override
  String toString() {
    return 'LessonListResponse{lessonId: $lessonId, teamId: $teamId, teamName: $teamName, resortName: $resortName, lessonDate: $lessonDate, startTime: $startTime, duration: $duration, representativeName: $representativeName, isDesignated: $isDesignated, studentInfoList: $studentInfoList, lessonStatus: $lessonStatus}';
  }
}

class LessonList {
  int lessonId;
  int teamId;
  String teamName;
  String resortName;
  DateTime lessonDate;
  DateTime startTime;
  DateTime endTime;
  int duration;
  String representativeName;
  bool isDesignated;
  List<StudentInfoResponse> studentInfoList;
  String lessonStatus;

  // bool hasReview;
  // int studentCount;

  LessonList({
    required this.lessonId,
    required this.teamId,
    required this.teamName,
    required this.resortName,
    required this.lessonDate,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.representativeName,
    required this.isDesignated,
    required this.studentInfoList,
    required this.lessonStatus,
    // required this.hasReview,
    // required this.studentCount,
  });

  @override
  String toString() {
    return 'LessonList{lessonId: $lessonId, teamId: $teamId, teamName: $teamName, resortName: $resortName, lessonDate: $lessonDate, startTime: $startTime, endTime: $endTime, duration: $duration, representativeName: $representativeName, isDesignated: $isDesignated, studentInfoList: $studentInfoList, lessonStatus: $lessonStatus}';
  }
}

extension LessonListItemResponseToLessonListItem on LessonListResponse {
  LessonList toLessonList() {
    return LessonList(
      lessonId: lessonId,
      teamId: teamId,
      teamName: teamName,
      resortName: resortName,
      lessonDate: lessonDate,
      startTime: startTime,
      endTime: startTime.add(Duration(hours: duration)),
      duration: duration,
      representativeName: representativeName,
      isDesignated: isDesignated,
      studentInfoList: studentInfoList,
      lessonStatus: lessonStatus,
      // hasReview: hasReview,
      // studentCount: studentCount,
    );
  }
}
