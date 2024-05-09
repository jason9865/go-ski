class CancelLessonResponse {
  int cost;
  int paybackRate;

  CancelLessonResponse({
    required this.cost,
    required this.paybackRate,
  });

  factory CancelLessonResponse.fromJson(Map<String, dynamic> json) {
    return CancelLessonResponse(
      cost: json['cost'] as int,
      paybackRate: json['paybackRate'] as int,
    );
  }

  @override
  String toString() {
    return 'CancelLessonResponse{cost: $cost, paybackRate: $paybackRate}';
  }
}

class CancelLesson {
  int cost;
  int paybackRate;

  CancelLesson({
    required this.cost,
    required this.paybackRate,
  });

  @override
  String toString() {
    return 'CancelLesson{cost: $cost, paybackRate: $paybackRate}';
  }
}

extension CancelLessonResponseToCancelLesson on CancelLessonResponse {
  CancelLesson toCancelLesson() {
    return CancelLesson(
      cost: cost,
      paybackRate: paybackRate,
    );
  }
}
