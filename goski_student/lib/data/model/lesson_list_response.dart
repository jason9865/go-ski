

class LessonListItemResponse {
  int lessonId;
  int teamId;
  String teamName;
  int instructorId;
  String instructorName;
  String profileUrl;
  String resortName;
  DateTime lessonDate;
  DateTime startTime;
  // String startTime;
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
    return LessonListItemResponse(
      lessonId: json['lessonId'] as int,
      teamId: json['teamId'] as int,
      teamName: json['teamName'] as String,
      instructorId: json['instructorId'] as int,
      instructorName: json['instructorName'] as String,
      profileUrl: json['profileUrl'] as String,
      resortName: json['resortName'] as String,
      lessonDate: DateTime.parse(json['lessonDate']),
      startTime: DateTime.parse(json['startTime']),
      // startTime: json['startTime'] as String,
      duration: json['duration'] as int,
      lessonStatus: json['lessonStatus'] as String,
    );
  }
}

class LessonListItem {
  int lessonId;
  int teamId;
  String teamName;
  int instructorId;
  String instructorName;
  String profileUrl;
  String resortName;
  DateTime lessonDate;
  DateTime startTime;
  DateTime endTime;
  // String startTime;
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
      endTime: startTime.add(Duration(milliseconds: duration)),
      duration: duration,
      lessonStatus: lessonStatus,
    );
  }
}
