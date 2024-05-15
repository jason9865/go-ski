import 'dart:io';

import 'package:goski_instructor/data/model/certificate.dart';
import 'package:image_picker/image_picker.dart';

import '../../const/enum/gender.dart';
import '../../const/enum/role.dart';

class Instructor {
  String userName;
  String birthDate;
  String phoneNumber;
  String profileUrl;
  String gender;
  String role;
  String description;
  int dayoff;
  String available;

  Instructor({
    this.userName = '',
    this.birthDate = '',
    this.phoneNumber = '',
    this.profileUrl = '',
    this.gender = '',
    this.role = '',
    this.description = '',
    this.dayoff = 0,
    this.available = '',
  });
}

class InstructorResponse {
  String userName;
  String birthDate;
  String phoneNumber;
  String profileUrl;
  String gender;
  String role;
  String? description;
  int dayoff;
  String available;

  InstructorResponse({
    required this.userName,
    required this.birthDate,
    required this.phoneNumber,
    required this.profileUrl,
    required this.gender,
    required this.role,
    required this.description,
    required this.dayoff,
    required this.available,
  });

  factory InstructorResponse.fromJson(Map<String, dynamic> json) {
    return InstructorResponse(
      userName: json['userName'],
      birthDate: json['birthDate'],
      phoneNumber: json['phoneNumber'],
      profileUrl: json['profileUrl'],
      gender: json['gender'],
      role: json['role'],
      description: json['description'],
      dayoff: (json['dayoff']),
      available: json['available'],
    );
  }
}

class InstructorRequest {
  int domainUserKey;
  XFile? profileImage;
  String kakaoProfileUrl;
  String userName;
  Gender gender;
  DateTime? birthDate;
  Role role;
  String phoneNumber;
  List<Certificate> certificates;
  String lessonType;

  InstructorRequest({
    required this.domainUserKey,
    this.profileImage,
    required this.kakaoProfileUrl,
    required this.userName,
    required this.gender,
    required this.birthDate,
    required this.role,
    required this.phoneNumber,
    required this.certificates,
    required this.lessonType,
  });
}

extension InstructorResponseToInstructor on InstructorResponse {
  Instructor toInstructor() {
    return Instructor(
      userName: userName,
      birthDate: birthDate,
      phoneNumber: phoneNumber,
      profileUrl: profileUrl,
      gender: gender,
      role: role,
      description: description ?? '',
      dayoff: dayoff,
      available: available,
    );
  }
}
