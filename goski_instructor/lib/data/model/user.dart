import 'dart:io';

import 'package:goski_instructor/const/enum/gender.dart';
import 'package:goski_instructor/const/enum/role.dart';

class User {
  int domainUserKey;
  File? profileImage;
  String kakaoProfileUrl;
  String userName;
  Gender gender;
  DateTime birthDate;
  Role role;
  String phoneNumber;

  User({
    required this.domainUserKey,
    this.profileImage,
    required this.kakaoProfileUrl,
    required this.userName,
    required this.gender,
    required this.birthDate,
    required this.role,
    required this.phoneNumber,
  });

  // factory User.fromJson(Map<String, dynamic> json) {
  //   DateTime formattedBirthDate =
  //       DateFormat('yyyy-MM-dd').parse(json['birthDate']);

  //   return User(
  //     profileUrl: json['profileUrl'],
  //     userName: json['userName'],
  //     gender: json['gender'],
  //     birthDate: formattedBirthDate,
  //     role: json['role'],
  //     phoneNumber: json['phoneNumber'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'profileUrl': profileUrl,
  //     'userName': userName,
  //     'gender': gender.toString().split('.').last,
  //     'birthDate': birthDate.toIso8601String(),
  //     'role': role.toString().split('.').last,
  //     'phoneNumber': phoneNumber,
  //   };
  // }
}
