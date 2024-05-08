import '../../const/enum/gender.dart';
import '../../const/enum/role.dart';

class MainResponse {
  String? profileUrl;
  String userName;
  Gender gender;
  DateTime birthDate;
  Role role;
  String phoneNumber;

  MainResponse({
    this.profileUrl,
    required this.userName,
    required this.gender,
    required this.birthDate,
    required this.role,
    required this.phoneNumber,
  });

  factory MainResponse.fromJson(Map<String, dynamic> json) {
    return MainResponse(
      profileUrl: json['profileUrl'] as String?,
      userName: json['userName'] as String,
      gender: json['gender'] == 'MALE' ? Gender.MALE : Gender.FEMALE,
      birthDate: DateTime.parse(json['birthDate']),
      role: json['role'] == 'STUDENT' ? Role.STUDENT : json['role'] == 'INSTRUCTOR' ? Role.INSTRUCTOR : Role.OWNER,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  @override
  String toString() {
    return 'MainResponse{profileUrl: $profileUrl, userName: $userName, gender: $gender, birthDate: $birthDate, role: $role, phoneNumber: $phoneNumber}';
  }
}

class Main {
  String? profileUrl;
  String userName;
  Gender gender;
  DateTime birthDate;
  Role role;
  String phoneNumber;

  Main({
    this.profileUrl,
    this.userName = '',
    this.gender = Gender.MALE,
    DateTime? birthDate,
    this.role = Role.STUDENT,
    this.phoneNumber = '',
  }): birthDate = birthDate ?? DateTime.now();
}

extension MainResponseToMain on MainResponse {
  Main toMain() {
    return Main(
      userName: userName,
      gender: gender,
      birthDate: birthDate,
      role: role,
      phoneNumber: phoneNumber,
    );
  }
}