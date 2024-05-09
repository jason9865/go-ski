import 'package:get/get.dart';
import 'package:goski_student/data/model/cancel_lesson_response.dart';
import 'package:goski_student/data/model/default_dto.dart';
import 'package:goski_student/data/repository/cancel_lesson_repository.dart';

class CancelLessonViewModel extends GetxController {
  final CancelLessonRepository cancelLessonRepository = Get.find();
  RxInt lessonCost = 0.obs;
  RxInt paybackRate = 0.obs;

  Future<void> getLessonCost(int lessonId) async {
    lessonCost.value = 0;
    paybackRate.value = 0;

    CancelLesson? response =
        await cancelLessonRepository.getLessonCost(lessonId);

    if (response != null) {
      lessonCost.value = response.cost;
      paybackRate.value = response.paybackRate;
    }
  }

  Future<bool> cancelLesson(int lessonId) async {
    DefaultDTO? response = await cancelLessonRepository.cancelLesson(lessonId);

    if (response != null && response.status == 'success') {
      return true;
    }

    return false;
  }
}
