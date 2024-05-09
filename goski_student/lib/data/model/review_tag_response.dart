class ReviewTagResponse {
  int tagReviewId;
  String tagName;

  ReviewTagResponse({
    required this.tagReviewId,
    required this.tagName,
  });

  factory ReviewTagResponse.fromJson(Map<String, dynamic> json) {
    return ReviewTagResponse(
      tagReviewId: json['tagReviewId'] as int,
      tagName: json['tagName'] as String,
    );
  }

  @override
  String toString() {
    return 'ReviewTagResponse{tagReviewId: $tagReviewId, tagName: $tagName}';
  }
}

class ReviewTag {
  int tagReviewId;
  String tagName;

  ReviewTag({
    required this.tagReviewId,
    required this.tagName,
  });

  @override
  String toString() {
    return 'ReviewTag{tagReviewId: $tagReviewId, tagName: $tagName}';
  }
}

extension ReviewTagResponseToReviewTag on ReviewTagResponse {
  ReviewTag toReviewTag() {
    return ReviewTag(
      tagReviewId: tagReviewId,
      tagName: tagName,
    );
  }
}
