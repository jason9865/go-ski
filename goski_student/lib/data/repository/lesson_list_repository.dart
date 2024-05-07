import 'package:get/get.dart';
import 'package:goski_student/data/data_source/lesson_list_service.dart';
import 'package:goski_student/data/model/lesson_list_response.dart';

class LessonListRepository {
  final LessonListService lessonListService = Get.find();

  Future<List<LessonListItem>> getLessonList() async {
    List<LessonListItemResponse> lessonListResponse =
        await lessonListService.getLessonList();

    return lessonListResponse
        .map<LessonListItem>((response) => response.toLessonListItem())
        .toList();
  }
}
