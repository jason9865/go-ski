import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:goski_student/const/util/custom_dio.dart';
import 'package:goski_student/data/model/cancel_lesson_response.dart';
import 'package:goski_student/data/model/default_dto.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class CancelLessonService extends GetxService {
  final baseUrl = dotenv.env['BASE_URL'];

  Future<CancelLessonResponse?> getLessonCost(int lessonId) async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/payment/lesson/$lessonId',
      );

      if (response.data['status'] == 'success' &&
          response.data is Map<String, dynamic>) {
        CancelLessonResponse data = CancelLessonResponse.fromJson(response.data['data'] as Map<String, dynamic>);

        logger.d('CancelLessonService - getLessonCost - 응답 성공 $data');

        return data;
      } else {
        logger.e('CancelLessonService - getLessonCost - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('CancelLessonService - getLessonCost - 응답 실패 $e');
    }

    return null;
  }

  Future<DefaultDTO?> cancelLesson(int lessonId) async {
    try {
      dynamic response = await CustomDio.dio.post(
        '$baseUrl/payment/reserve/cancel',
        data: { 'lessonId': lessonId },
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      logger.w(response.data);

      if (response.data['status'] == 'success') {
        logger.d('CancelLessonService - cancelLesson - 응답 성공');
        DefaultDTO defaultDTO = DefaultDTO.fromJson(response.data as Map<String, dynamic>);
        return defaultDTO;
      } else {
        logger.e('CancelLessonService - cancelLesson - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('CancelLessonService - cancelLesson - 응답 실패 $e');
    }

    return null;
  }
}