class ReviewRequest {
  int lessonId;
  int rating;
  String content;
  List<int> reviewTags;

  ReviewRequest({
    required this.lessonId,
    required this.rating,
    required this.content,
    required this.reviewTags,
  });

  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'rating': rating,
      'content': content,
      'reviewTags': reviewTags,
    };
  }

  @override
  String toString() {
    return 'ReviewRequest{lessonId: $lessonId, rating: $rating, content: $content, reviewTags: $reviewTags}';
  }
}

class Review {
  int lessonId;
  int rating;
  String content;
  List<int> reviewTags;

  Review({
    required this.lessonId,
    required this.rating,
    required this.content,
    required this.reviewTags,
  });

  @override
  String toString() {
    return 'Review{lessonId: $lessonId, rating: $rating, content: $content, reviewTags: $reviewTags}';
  }
}

extension ReviewToReviewRequest on Review {
  ReviewRequest toReviewRequest() {
    return ReviewRequest(
      lessonId: lessonId,
      rating: rating,
      content: content,
      reviewTags: reviewTags,
    );
  }
}
