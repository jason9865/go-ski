import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class ReservationRequest {
  int resortId;
  String lessonType; // SKI or BOARD
  int studentCount;
  String lessonDate;
  String startTime;
  int duration;
  String level;

  ReservationRequest({
    this.resortId = 0,
    this.lessonType = 'SKI',
    this.studentCount = 0,
    this.lessonDate = '',
    this.startTime = '',
    this.duration = 0,
    this.level = '',
  });

  bool isValid() {
    return resortId != 0 &&
        studentCount != 0 &&
        lessonDate != '' &&
        startTime != '' &&
        duration != 0 &&
        level != '';
  }
}

class BeginnerResponse {
  int teamId;
  String teamName;
  String description;
  String teamProfileUrl;
  List<int> instructors;
  List<TeamImage> teamImages;
  double rating;
  int reviewCount;
  int cost;

  BeginnerResponse({
    this.teamId = 0,
    this.teamName = '',
    this.description = '',
    this.teamProfileUrl = '',
    this.instructors = const [],
    this.teamImages = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.cost = 0,
  });

  factory BeginnerResponse.fromJson(Map<String, dynamic> json) {
    var list = json['instructors'] as List;
    List<int> instructorsList = list.map((i) => i as int).toList();

    return BeginnerResponse(
      teamId: json['teamId'] as int,
      teamName: json['teamName'] as String,
      description: json['resortLocation'] as String,
      teamProfileUrl: json['resortLocation'] as String,
      instructors: instructorsList,
      teamImages: json['teamImages'] as List<TeamImage>,
      rating: json['rating'] as double,
      reviewCount: json['reviewCount'] as int,
      cost: json['cost'] as int,
    );
  }
}

class TeamImage {
  int teamImageId;
  String teamImageUrl;

  TeamImage({required this.teamImageId, required this.teamImageUrl});
}
