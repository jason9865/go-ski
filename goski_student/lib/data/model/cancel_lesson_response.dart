class CancelLessonResponse {
  int cost;

  CancelLessonResponse({
    required this.cost,
  });

  factory CancelLessonResponse.fromJson(Map<String, dynamic> json) {
    return CancelLessonResponse(
      cost: json['cost'] as int,
    );
  }

  @override
  String toString() {
    return 'CancelLessonResponse{cost: $cost}';
  }
}

class CancelLesson {
  int cost;

  CancelLesson({
    required this.cost,
  });

  @override
  String toString() {
    return 'CancelLesson{cost: $cost}';
  }
}

extension CancelLessonResponseToCancelLesson on CancelLessonResponse {
  CancelLesson toCancelLesson() {
    return CancelLesson(
      cost: cost,
    );
  }
}
