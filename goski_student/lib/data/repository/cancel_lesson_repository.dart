import 'package:get/get.dart';
import 'package:goski_student/data/data_source/cancel_lesson_service.dart';
import 'package:goski_student/data/model/cancel_lesson_response.dart';
import 'package:goski_student/data/model/default_dto.dart';

class CancelLessonRepository {
  final CancelLessonService cancelLessonService = Get.find();

  Future<CancelLesson?> getLessonCost(int lessonId) async {
    CancelLessonResponse? cancelLessonResponse = await cancelLessonService.getLessonCost(lessonId);

    return cancelLessonResponse?.toCancelLesson();
  }

  Future<DefaultDTO?> cancelLesson(int lessonId) async {
    return cancelLessonService.cancelLesson(lessonId);
  }
}