import 'dart:io';

import 'package:goski_instructor/data/model/certificate.dart';

import '../../const/enum/gender.dart';
import '../../const/enum/role.dart';

class InstructorRequest {
  int domainUserKey;
  File? profileImage;
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
