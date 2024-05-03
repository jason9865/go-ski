import 'dart:io';

import 'package:goski_student/const/enum/gender.dart';
import 'package:goski_student/const/enum/role.dart';

class UserRequest {
  int domainUserKey;
  File? profileImage;
  String kakaoProfileUrl;
  String userName;
  Gender gender;
  DateTime? birthDate;
  Role role;
  String phoneNumber;

  UserRequest({
    required this.domainUserKey,
    this.profileImage,
    required this.kakaoProfileUrl,
    required this.userName,
    required this.gender,
    DateTime? birthDate,
    required this.role,
    required this.phoneNumber,
  }) : birthDate = birthDate ?? DateTime.now();
}

class User {
  int domainUserKey;
  File? profileImage;
  String kakaoProfileUrl;
  String userName;
  Gender gender;
  DateTime? birthDate;
  Role role = Role.INSTRUCTOR;
  String phoneNumber;

  User({
    this.domainUserKey = 0,
    this.profileImage,
    this.kakaoProfileUrl = '',
    this.userName = '',
    this.gender = Gender.MALE,
    DateTime? birthDate,
    this.role = Role.INSTRUCTOR,
    this.phoneNumber = '',
  }) : birthDate = birthDate ?? DateTime.now();

  bool isValid() {
    return birthDate != null && userName.isNotEmpty && phoneNumber.isNotEmpty;
  }

  @override
  String toString() {
    return 'User{domainUserKey: $domainUserKey, profileImage: $profileImage, kakaoProfileUrl: $kakaoProfileUrl, userName: $userName, gender: $gender, birthDate: $birthDate, role: $role, phoneNumber: $phoneNumber,}';
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
    );
  }
}

extension UserRequestToUser on UserRequest {
  User toUserRequest() {
    return User(
      domainUserKey: domainUserKey,
      kakaoProfileUrl: kakaoProfileUrl,
      userName: userName,
      gender: gender,
      birthDate: birthDate,
      role: role,
      phoneNumber: phoneNumber,
    );
  }
}
