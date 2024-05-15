// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:goski_instructor/data/model/student_info.dart';
import 'package:goski_instructor/main.dart';

class Schedule {
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
  List<StudentInfo> studentInfos = [];
  String representativeName;
  String? requestComplain;
  bool isDesignated;
  int instructorId;
  Schedule({
    this.resortId = 0,
    this.resortName = '',
    this.studentCount = 0,
    this.lessonDate = '',
    this.startTime = '',
    this.duration = 0,
    this.lessonType = '',
    this.lessonId = 0,
    this.teamId = 0,
    this.teamName = '',
    required this.studentInfos,
    this.representativeName = '',
    this.requestComplain = '',
    this.isDesignated = false,
    this.instructorId = 0,
  });

  @override
  String toString() {
    return 'Schedule(studentCount: $studentCount, lessonDate: $lessonDate, startTime: $startTime, duration: $duration, lessonType: $lessonType, lessonId: $lessonId, teamId: $teamId, teamName: $teamName, studentInfos: $studentInfos, representativeName: $representativeName, requestComplain: $requestComplain, isDesignated: $isDesignated, instructorId: $instructorId)';
  }

  @override
  bool operator ==(covariant Schedule other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.studentCount == studentCount &&
        other.lessonDate == lessonDate &&
        other.startTime == startTime &&
        other.duration == duration &&
        other.lessonType == lessonType &&
        other.lessonId == lessonId &&
        other.teamId == teamId &&
        other.teamName == teamName &&
        listEquals(other.studentInfos, studentInfos) &&
        other.representativeName == representativeName &&
        other.requestComplain == requestComplain &&
        other.isDesignated == isDesignated &&
        other.instructorId == instructorId;
  }

  @override
  int get hashCode {
    return studentCount.hashCode ^
        lessonDate.hashCode ^
        startTime.hashCode ^
        duration.hashCode ^
        lessonType.hashCode ^
        lessonId.hashCode ^
        teamId.hashCode ^
        teamName.hashCode ^
        studentInfos.hashCode ^
        representativeName.hashCode ^
        requestComplain.hashCode ^
        isDesignated.hashCode ^
        instructorId.hashCode;
  }
}

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
  String? requestComplain;
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
    this.requestComplain,
    required this.isDesignated,
    required this.instructorId,
  });

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleResponse(
      resortId: json['resortId'] ?? 0,
      studentCount: json['studentCount'] as int,
      lessonDate: json['lessonDate'],
      startTime: json['startTime'],
      duration: json['duration'] as int,
      lessonType: json['lessonType'],
      lessonId: json['lessonId'] as int,
      teamId: json['teamId'] as int,
      teamName: json['teamName'],
      resortName: json['resortName'] ?? '',
      studentInfos:
          List<StudentInfoResponse>.from(json['studentInfoDTOs'].map((item) {
        return StudentInfoResponse.fromJson(item);
      })),
      representativeName: json['representativeName'],
      requestComplain: json['requestComplain'] ?? '',
      isDesignated: json['isDesignated'] as bool,
      instructorId: json['instructorId'] as int,
    );
  }
}

extension ScheduleResponseToSchedule on ScheduleResponse {
  Schedule toSchedule() {
    if (lessonType == '1010000') {
      lessonType = "ski";
    } else if (lessonType == '1100000') {
      lessonType = "board";
    }
    return Schedule(
      resortId: resortId,
      studentCount: studentCount,
      lessonDate: lessonDate,
      startTime: startTime,
      duration: duration,
      lessonType: lessonType,
      lessonId: lessonId,
      teamId: teamId,
      teamName: teamName,
      resortName: resortName,
      studentInfos: List<StudentInfo>.from(studentInfos.map((item) {
        return item.toStudentInfo();
      })),
      representativeName: representativeName,
      requestComplain: requestComplain,
      isDesignated: isDesignated,
      instructorId: instructorId,
    );
  }
}
