import 'certificate_info.dart';

class Instructor {
  int instructorId;
  String userName;
  String instructorUrl;
  String gender;
  int position;
  String description;
  double? rating;
  int? reviewCount;
  int cost;
  int designatedFee;
  int levelOptionFee;
  List<CertificateInfo> certificateList;
  List<LessonReview>? reviews;

  Instructor({
    required this.instructorId,
    required this.userName,
    required this.instructorUrl,
    required this.gender,
    required this.position,
    required this.description,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.cost,
    required this.designatedFee,
    required this.levelOptionFee,
    required this.certificateList,
    this.reviews,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    List<CertificateInfo> certList = [];
    List<LessonReview> reviews = [];
    if (json['certificateInfoVOs'] != null) {
      certList = (json['certificateInfoVOs'] as List)
          .map((item) => CertificateInfo.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    if (json['reviews'] != null) {
      reviews = (json['reviews'] as List)
          .map((item) => LessonReview.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return Instructor(
      instructorId: json['instructorId'] as int,
      userName: json['userName'] as String,
      instructorUrl: json['instructorUrl'] as String,
      gender: json['gender'] as String,
      position: json['position'] as int,
      description: json['description'] as String,
      rating: json['rating'] ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      cost: json['cost'] as int,
      designatedFee: json['designatedFee'] as int,
      levelOptionFee: json['levelOptionFee'] as int,
      certificateList: certList,
      reviews: reviews,
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
