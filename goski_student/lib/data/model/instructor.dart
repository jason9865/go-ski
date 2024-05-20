import 'package:easy_localization/easy_localization.dart';

import 'certificate_info.dart';

class Instructor {
  int instructorId;
  String userName;
  int teamId;
  String teamName;
  String instructorUrl;
  String gender;
  int position;
  String lessonType;
  String description;
  double? rating;
  int? reviewCount;
  int cost;
  int basicFee;
  int designatedFee;
  int levelOptionFee;
  int peopleOptionFee;
  List<CertificateInfo> certificateList;
  List<LessonReview>? reviews;
  List<String> skiCertificate = [];
  List<String> boardCertificate = [];

  Instructor({
    required this.instructorId,
    required this.userName,
    required this.teamId,
    required this.teamName,
    required this.instructorUrl,
    required this.gender,
    required this.position,
    required this.lessonType,
    this.description = '',
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.cost,
    required this.basicFee,
    required this.designatedFee,
    required this.levelOptionFee,
    required this.peopleOptionFee,
    required this.certificateList,
    this.reviews,
    required this.skiCertificate,
    required this.boardCertificate,
  });

  static List<String> createSkiCertificateList(
      List<CertificateInfo> certificateList) {
    List<String> certList = [];
    for (CertificateInfo certificate in certificateList) {
      switch (certificate.certificateId) {
        case 1:
          certList.add(tr('level1'));
          break;
        case 2:
          certList.add(tr('level2'));
          break;
        case 3:
          certList.add(tr('level3'));
          break;
        case 4:
          certList.add(tr('teaching1'));
          break;
        case 5:
          certList.add(tr('teaching2'));
          break;
        case 6:
          certList.add(tr('teaching3'));
          break;
        case 7:
          certList.add(tr('demonstrator'));
          break;
        default:
          break;
      }
    }
    return certList;
  }

  static List<String> createBoardCertificateList(
      List<CertificateInfo> certificateList) {
    List<String> certList = [];
    for (CertificateInfo certificate in certificateList) {
      switch (certificate.certificateId) {
        case 8:
          certList.add(tr('level1'));
          break;
        case 9:
          certList.add(tr('level2'));
          break;
        case 10:
          certList.add(tr('level3'));
          break;
        case 11:
          certList.add(tr('teaching1'));
          break;
        case 12:
          certList.add(tr('teaching2'));
          break;
        case 13:
          certList.add(tr('teaching3'));
          break;
        case 14:
          certList.add(tr('demonstrator'));
          break;
        default:
          break;
      }
    }
    return certList;
  }

  factory Instructor.fromJson(Map<String, dynamic> json) {
    List<CertificateInfo> certList = (json['certificateInfoVOs'] as List)
        .map((item) => CertificateInfo.fromJson(item as Map<String, dynamic>))
        .toList();
    List<String> skiCert = createSkiCertificateList(certList);
    List<String> boardCert = createBoardCertificateList(certList);

    List<LessonReview> reviews = [];
    if (json['reviews'] != null) {
      reviews = (json['reviews'] as List)
          .map((item) => LessonReview.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return Instructor(
      instructorId: json['instructorId'] as int,
      userName: json['userName'] as String,
      teamId: json['teamId'] as int,
      teamName: json['teamName'] as String,
      instructorUrl: json['instructorUrl'] as String,
      gender: json['gender'] as String,
      position: json['position'] as int,
      lessonType: json['lessonType'] as String,
      description: json['description'] ?? '',
      rating: json['rating'] ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      cost: json['cost'] as int,
      basicFee: json['basicFee'] as int,
      designatedFee: json['designatedFee'] as int,
      levelOptionFee: json['levelOptionFee'] as int,
      peopleOptionFee: json['levelOptionFee'] as int,
      certificateList: certList,
      reviews: reviews,
      skiCertificate: skiCert,
      boardCertificate: boardCert,
    );
  }
}

class LessonReview {
  String reviewContent;
  int rating;

  LessonReview({
    required this.reviewContent,
    required this.rating,
  });

  factory LessonReview.fromJson(Map<String, dynamic> json) {
    return LessonReview(
      reviewContent: json['content'] as String,
      rating: json['rating'] as int,
    );
  }
}
