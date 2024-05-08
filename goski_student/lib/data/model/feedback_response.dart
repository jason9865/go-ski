class FeedbackResponse {
  int feedbackId;
  String content;
  List<MediaResponse> images;
  List<MediaResponse> videos;

  FeedbackResponse({
    required this.feedbackId,
    required this.content,
    required this.images,
    required this.videos,
  });

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> imageList = json['images'] as List<dynamic>;
    List<MediaResponse> images =
        imageList.map((json) => MediaResponse.fromJson(json)).toList();

    List<dynamic> videoList = json['videos'] as List<dynamic>;
    List<MediaResponse> videos =
        videoList.map((json) => MediaResponse.fromJson(json)).toList();

    return FeedbackResponse(
      feedbackId: json['feedbackId'] as int,
      content: json['content'] as String,
      images: images,
      videos: videos,
    );
  }

  @override
  String toString() {
    return 'FeedbackResponse{feedbackId: $feedbackId, content: $content, images: $images, videos: $videos}';
  }
}

class MediaResponse {
  int mediaId;
  String mediaUrl;

  MediaResponse({
    required this.mediaId,
    required this.mediaUrl,
  });

  factory MediaResponse.fromJson(Map<String, dynamic> json) {
    return MediaResponse(
      mediaId: json['mediaId'] as int,
      mediaUrl: json['mediaUrl'] as String,
    );
  }

  @override
  String toString() {
    return 'MediaResponse{mediaId: $mediaId, mediaUrl: $mediaUrl}';
  }
}

class Feedback {
  int feedbackId;
  String content;
  List<MediaData> images;
  List<MediaData> videos;

  Feedback({
    required this.feedbackId,
    required this.content,
    required this.images,
    required this.videos,
  });

  @override
  String toString() {
    return 'Feedback{feedbackId: $feedbackId, content: $content, images: $images, videos: $videos}';
  }
}

extension FeedbackResponseToFeedback on FeedbackResponse {
  Feedback toFeedback() {
    return Feedback(
      feedbackId: feedbackId,
      content: content,
      images: images.map<MediaData>((response) => response.toMediaData()).toList(),
      videos: videos.map<MediaData>((response) => response.toMediaData()).toList(),
    );
  }
}

class MediaData {
  int mediaId;
  String mediaUrl;

  MediaData({
    required this.mediaId,
    required this.mediaUrl,
  });

  @override
  String toString() {
    return 'MediaData{mediaId: $mediaId, mediaUrl: $mediaUrl}';
  }
}

extension MediaResponseToMediaData on MediaResponse {
  MediaData toMediaData() {
    return MediaData(
      mediaId: mediaId,
      mediaUrl: mediaUrl,
    );
  }
}
