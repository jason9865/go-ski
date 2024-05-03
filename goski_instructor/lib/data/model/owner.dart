import 'package:goski_instructor/data/model/user.dart';

class Owner extends User {
  Owner({
    required super.domainUserKey,
    super.profileImage,
    required super.kakaoProfileUrl,
    required super.userName,
    required super.gender,
    required super.birthDate,
    required super.role,
    required super.phoneNumber,
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
