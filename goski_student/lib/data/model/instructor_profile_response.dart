import 'package:goski_student/const/enum/gender.dart';
import 'package:goski_student/const/enum/role.dart';

class InstructorProfileResponse {
  String userName;
  DateTime birthDate;
  String phoneNumber;
  String? profileUrl;
  Gender gender;
  Role role;
  String description;
  int dayoff;
  String available;
  List<CertificateResponse> certificates;

  InstructorProfileResponse({
    required this.userName,
    required this.birthDate,
    required this.phoneNumber,
    this.profileUrl,
    required this.gender,
    required this.role,
    required this.description,
    required this.dayoff,
    required this.available,
    required this.certificates,
  });

  factory InstructorProfileResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> certificateList = json['certificates'] as List<dynamic>;
    List<CertificateResponse> certificates = certificateList
        .map((json) => CertificateResponse.fromJson(json))
        .toList();

    return InstructorProfileResponse(
      userName: json['userName'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      profileUrl: json['profileUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      gender: json['gender'] == 'MALE' ? Gender.MALE : Gender.FEMALE,
      role: Role.INSTRUCTOR,
      description: json['description'] as String,
      dayoff: json['dayoff'] as int,
      available: json['available'] as String,
      certificates: certificates,
    );
  }

  @override
  String toString() {
    return 'InstructorProfileResponse{userName: $userName, birthDate: $birthDate, phoneNumber: $phoneNumber, profileUrl: $profileUrl, gender: $gender, role: $role, description: $description, dayoff: $dayoff, available: $available, certificates: $certificates}';
  }
}

class InstructorProfile {
  String userName;
  DateTime birthDate;
  String phoneNumber;
  String? profileUrl;
  Gender gender;
  Role role;
  String description;
  int dayoff;
  String available;
  List<Certificate> certificates;

  InstructorProfile({
    required this.userName,
    required this.birthDate,
    required this.phoneNumber,
    this.profileUrl,
    required this.gender,
    required this.role,
    required this.description,
    required this.dayoff,
    required this.available,
    required this.certificates,
  });

  @override
  String toString() {
    return 'InstructorProfile{userName: $userName, birthDate: $birthDate, phoneNumber: $phoneNumber, profileUrl: $profileUrl, gender: $gender, role: $role, description: $description, dayoff: $dayoff, available: $available, certificates: $certificates}';
  }
}

extension InstructorProfileResponseToInstructorProfile
    on InstructorProfileResponse {
  InstructorProfile toInstructorProfile() {
    return InstructorProfile(
      userName: userName,
      birthDate: birthDate,
      profileUrl: profileUrl,
      phoneNumber: phoneNumber,
      gender: gender,
      role: role,
      description: description,
      dayoff: dayoff,
      available: available,
      certificates: certificates.map<Certificate>((response) => response.toCertificate()).toList(),
    );
  }
}

class CertificateResponse {
  int certificateId;
  String certificateImageUrl;

  CertificateResponse({
    required this.certificateId,
    required this.certificateImageUrl,
  });

  factory CertificateResponse.fromJson(Map<String, dynamic> json) {
    return CertificateResponse(
      certificateId: json['certificateId'] as int,
      certificateImageUrl: json['certificateImageUrl'] as String,
    );
  }

  @override
  String toString() {
    return 'CertificateResponse{certificateId: $certificateId, certificateImageUrl: $certificateImageUrl}';
  }
}

class Certificate {
  int certificateId;
  String certificateImageUrl;

  Certificate({
    required this.certificateId,
    required this.certificateImageUrl,
  });

  @override
  String toString() {
    return 'Certificate{certificateId: $certificateId, certificateImageUrl: $certificateImageUrl}';
  }
}

extension CertificateResponseToCertificate on CertificateResponse {
  Certificate toCertificate() {
    return Certificate(
      certificateId: certificateId,
      certificateImageUrl: certificateImageUrl,
    );
  }
}
