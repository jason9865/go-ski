import 'package:easy_localization/easy_localization.dart';

class ReviewResponse {
  int reviewId;
  int lessonId;
  DateTime lessonDate;
  String lessonTimeInfo;
  String representativeName;
  int rating;
  String content;
  DateTime createdAt;
  List<TagResponse> instructorTags;

  ReviewResponse({
    required this.reviewId,
    required this.lessonId,
    required this.lessonDate,
    required this.lessonTimeInfo,
    required this.representativeName,
    required this.rating,
    required this.content,
    required this.createdAt,
    required this.instructorTags,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> instructorTagList = json['instructorTags'] as List<dynamic>;
    List<TagResponse> instructorTags = instructorTagList
        .map<TagResponse>((response) => TagResponse.fromJson(response))
        .toList();

    return ReviewResponse(
      reviewId: json['reviewId'] as int,
      lessonId: json['lessonId'] as int,
      lessonDate: DateFormat("yyyy-MM-dd").parse(json['lessonDate'] as String),
      lessonTimeInfo: json['lessonTimeInfo'] as String,
      representativeName: json['representativeName'] as String,
      rating: json['rating'] as int,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      instructorTags: instructorTags,
    );
  }

  @override
  String toString() {
    return 'ReviewResponse{reviewId: $reviewId, lessonId: $lessonId, lessonDate: $lessonDate, lessonTimeInfo: $lessonTimeInfo, representativeName: $representativeName, rating: $rating, content: $content, createdAt: $createdAt, instructorTags: $instructorTags}';
  }
}

class TagResponse {
  int tagReviewId;
  String tagName;

  TagResponse({
    required this.tagReviewId,
    required this.tagName,
  });

  factory TagResponse.fromJson(Map<String, dynamic> json) {
    return TagResponse(
      tagReviewId: json['tagReviewId'] as int,
      tagName: json['tagName'] as String,
    );
  }

  @override
  String toString() {
    return 'TagResponse{tagReviewId: $tagReviewId, tagName: $tagName}';
  }
}

class Tag {
  int tagReviewId;
  String tagName;

  Tag({
    required this.tagReviewId,
    required this.tagName,
  });

  @override
  String toString() {
    return 'Tag{tagReviewId: $tagReviewId, tagName: $tagName}';
  }
}

extension TagResponseToTag on TagResponse {
  Tag toTag() {
    return Tag(
      tagReviewId: tagReviewId,
      tagName: tagName,
    );
  }
}
