import 'package:get/get.dart';
import 'package:goski_student/data/model/lesson_list_response.dart';

import '../data/repository/lesson_list_repository.dart';

class LessonListViewModel extends GetxController {
  final LessonListRepository lessonListRepository = Get.find();
  RxList<LessonListItem> lessonList = <LessonListItem>[].obs;

  void getUserInfo() async {
    List<LessonListItem> response =
        await lessonListRepository.getLessonList();

    lessonList.value = response;
  }
}
