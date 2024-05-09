import 'dart:io';

import 'package:goski_instructor/const/enum/gender.dart';
import 'package:goski_instructor/const/enum/role.dart';
import 'package:goski_instructor/data/model/instructor.dart';
import 'package:goski_instructor/data/model/owner.dart';
import 'package:image_picker/image_picker.dart';

import 'certificate.dart';

class UserRequest {
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

  UserRequest({
    required this.domainUserKey,
    this.profileImage,
    required this.kakaoProfileUrl,
    required this.userName,
    required this.gender,
    DateTime? birthDate,
    required this.role,
    required this.phoneNumber,
    required this.certificates,
    required this.lessonType,
  }) : birthDate = birthDate ?? DateTime.now();
}

class User {
  int domainUserKey;
  XFile? profileImage;
  String kakaoProfileUrl;
  String userName;
  Gender gender;
  DateTime? birthDate;
  Role role = Role.INSTRUCTOR;
  String phoneNumber;
  List<Certificate> certificates;
  String lessonType;
  bool isOwner;

  User({
    this.domainUserKey = 0,
    this.profileImage,
    this.kakaoProfileUrl = '',
    this.userName = '',
    this.gender = Gender.MALE,
    DateTime? birthDate,
    this.role = Role.INSTRUCTOR,
    this.phoneNumber = '',
    required this.certificates,
    this.lessonType = '',
    this.isOwner = false,
  }) : birthDate = birthDate ?? DateTime.now();

  bool isValid() {
    if (isOwner) {
      return birthDate != null && userName.isNotEmpty && phoneNumber.isNotEmpty;
    } else {
      return birthDate != null &&
          userName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          certificates.isNotEmpty;
    }
  }

  @override
  String toString() {
    return 'User{domainUserKey: $domainUserKey, profileImage: $profileImage, kakaoProfileUrl: $kakaoProfileUrl, userName: $userName, gender: $gender, birthDate: $birthDate, role: $role, phoneNumber: $phoneNumber, certificates: $certificates, lessonType: $lessonType, isOwner: $isOwner}';
  }
}

extension UserToDTO on User {
  UserRequest toUserRequest() {
    return UserRequest(
      domainUserKey: domainUserKey,
      kakaoProfileUrl: kakaoProfileUrl,
      userName: userName,
      gender: gender,
      birthDate: birthDate,
      role: role,
      phoneNumber: phoneNumber,
      certificates: certificates,
      lessonType: lessonType,
    );
  }

  OwnerRequest toOwnerRequest() {
    return OwnerRequest(
      domainUserKey: domainUserKey,
      kakaoProfileUrl: kakaoProfileUrl,
      userName: userName,
      gender: gender,
      birthDate: birthDate,
      role: role,
      phoneNumber: phoneNumber,
    );
  }

  InstructorRequest toInstructorRequest() {
    return InstructorRequest(
      domainUserKey: domainUserKey,
      kakaoProfileUrl: kakaoProfileUrl,
      userName: userName,
      gender: gender,
      birthDate: birthDate,
      role: role,
      phoneNumber: phoneNumber,
      certificates: certificates,
      lessonType: lessonType,
    );
  }
}

extension UserRequestToUser on UserRequest {
  User toUser() {
    return User(
      domainUserKey: domainUserKey,
      kakaoProfileUrl: kakaoProfileUrl,
      userName: userName,
      gender: gender,
      birthDate: birthDate,
      role: role,
      phoneNumber: phoneNumber,
      certificates: certificates,
      lessonType: lessonType,
    );
  }
}
