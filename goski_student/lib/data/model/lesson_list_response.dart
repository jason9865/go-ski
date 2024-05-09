import 'package:intl/intl.dart';

class LessonListItemResponse {
  int lessonId;
  int teamId;
  String teamName;
  int? instructorId;
  String? instructorName;
  String? profileUrl;
  String resortName;
  DateTime lessonDate;
  DateTime startTime;
  int duration;
  String lessonStatus;

  LessonListItemResponse({
    required this.lessonId,
    required this.teamId,
    required this.teamName,
    required this.instructorId,
    required this.instructorName,
    required this.profileUrl,
    required this.resortName,
    required this.lessonDate,
    required this.startTime,
    required this.duration,
    required this.lessonStatus,
  });

  factory LessonListItemResponse.fromJson(Map<String, dynamic> json) {
    String timeString = json['startTime'];
    String formattedTimeString = "${timeString.substring(0, 2)}:${timeString.substring(2)}";
    String lessonDate = json['lessonDate'];
    String formattedDate = DateFormat('yyyy-MM-dd').parse(lessonDate).toString();
    String combinedDateTimeString = "$formattedDate $formattedTimeString";
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm").parse(combinedDateTimeString);

    return LessonListItemResponse(
      lessonId: json['lessonId'] as int,
      teamId: json['teamId'] as int,
      teamName: json['teamName'] as String,
      instructorId: json['instructorId'] as int?,
      instructorName: json['instructorName'] as String?,
      profileUrl: json['profileUrl'] as String?,
      resortName: json['resortName'] as String,
      lessonDate: DateTime.parse(lessonDate),
      startTime: dateTime,
      duration: json['duration'] as int,
      lessonStatus: json['lessonStatus'] as String,
    );
  }

  @override
  String toString() {
    return 'LessonListItemResponse{lessonId: $lessonId, teamId: $teamId, teamName: $teamName, instructorId: $instructorId, instructorName: $instructorName, profileUrl: $profileUrl, resortName: $resortName, lessonDate: $lessonDate, startTime: $startTime, duration: $duration, lessonStatus: $lessonStatus}';
  }
}

class LessonListItem {
  int lessonId;
  int teamId;
  String teamName;
  int? instructorId;
  String? instructorName;
  String? profileUrl;
  String resortName;
  DateTime lessonDate;
  DateTime startTime;
  DateTime endTime;
  int duration;
  String lessonStatus;

  LessonListItem({
    required this.lessonId,
    required this.teamId,
    required this.teamName,
    required this.instructorId,
    required this.instructorName,
    required this.profileUrl,
    required this.resortName,
    required this.lessonDate,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.lessonStatus,
  });

  @override
  String toString() {
    return 'LessonListItem{lessonId: $lessonId, teamId: $teamId, teamName: $teamName, instructorId: $instructorId, instructorName: $instructorName, profileUrl: $profileUrl, resortName: $resortName, lessonDate: $lessonDate, startTime: $startTime, endTime: $endTime, duration: $duration, lessonStatus: $lessonStatus}';
  }
}

extension LessonListItemResponseToLessonListItem on LessonListItemResponse {
  LessonListItem toLessonListItem() {
    return LessonListItem(
      lessonId: lessonId,
      teamId: teamId,
      teamName: teamName,
      instructorId: instructorId,
      instructorName: instructorName,
      profileUrl: profileUrl,
      resortName: resortName,
      lessonDate: lessonDate,
      startTime: startTime,
      endTime: startTime.add(Duration(hours: duration)),
      duration: duration,
      lessonStatus: lessonStatus,
    );
  }
}
