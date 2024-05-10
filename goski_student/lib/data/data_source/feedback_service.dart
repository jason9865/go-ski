import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/util/custom_dio.dart';
import 'package:goski_student/data/model/feedback_response.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class FeedbackService extends GetxService {
  final baseUrl = dotenv.env['BASE_URL'];

  Future<FeedbackResponse?> getFeedback(int lessonId) async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/lesson/feedback/$lessonId',
      );

      logger.w(response.data['data']);

      if (response.data['status'] == 'success' &&
          response.data is Map<String, dynamic>) {
        FeedbackResponse data = FeedbackResponse.fromJson(response.data['data'] as Map<String, dynamic>);

        logger.d('FeedbackService - getFeedback - 응답 성공 $data');

        return data;
      } else {
        logger.e('FeedbackService - getFeedback - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('FeedbackService - getFeedback - 응답 실패 $e');
    }

    return null;
  }
}