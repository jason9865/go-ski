import 'package:get/get.dart';
import 'package:goski_instructor/data/data_source/lesson_list_service.dart';
import 'package:goski_instructor/data/model/lesson_list_response.dart';

class LessonListRepository {
  final LessonListService lessonListService = Get.find<LessonListService>();

  Future<List<LessonList>> getLessonList() async {
    List<LessonListResponse> lessonListResponse =
        await lessonListService.getLessonList();

    return lessonListResponse
        .map<LessonList>((response) => response.toLessonList())
        .toList();
  }

// Future<DefaultDTO?> sendMessage(SendMessage message) async {
//   return lessonListService.sendMessage(message.toSendMessageRequest());
// }
}
