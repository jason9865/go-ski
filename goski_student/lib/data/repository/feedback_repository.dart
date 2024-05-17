import 'package:get/get.dart';
import 'package:goski_student/data/data_source/feedback_service.dart';
import 'package:goski_student/data/model/feedback_response.dart';

class FeedbackRepository {
  final FeedbackService feedbackService = Get.find();

  Future<Feedback?> getFeedback(int lessonId) async {
    FeedbackResponse? feedbackResponse =
        await feedbackService.getFeedback(lessonId);

    return feedbackResponse?.toFeedback();
  }
}
