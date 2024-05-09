import 'package:get/get.dart';
import 'package:goski_student/data/model/default_dto.dart';
import 'package:goski_student/data/model/lesson_list_response.dart';
import 'package:goski_student/data/model/sned_message_request.dart';
import 'package:logger/logger.dart';

import '../data/repository/lesson_list_repository.dart';

var logger = Logger();

class LessonListViewModel extends GetxController {
  final LessonListRepository lessonListRepository = Get.find();
  RxList<LessonListItem> lessonList = <LessonListItem>[].obs;
  Rx<SendMessage> message = SendMessage(receiverId: 0, title: '').obs;
  Rx<LessonListItem> selectedLesson = LessonListItem(
    lessonId: 0,
    teamId: 0,
    teamName: '',
    instructorId: 0,
    instructorName: '',
    profileUrl: '',
    resortName: '',
    lessonDate: DateTime.now(),
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    duration: 0,
    lessonStatus: '',
    hasReview: false,
    studentCount: 0,
  ).obs;
  RxBool isLoadingLessonList = true.obs;

  void initMessage(LessonListItem lesson) {
    message.value.receiverId = 34;
    // lesson.instructorId == null ? 0 : lesson.instructorId!;
    message.value.title = '';
    message.value.content = '';
    message.value.image = null;
    message.value.hasImage = false;
  }

  bool isValidMessage() {
    return message.value.receiverId != 0 && message.value.title.isNotEmpty;
  }

  Future<void> getLessonList() async {
    isLoadingLessonList.value = true;
    List<LessonListItem> response = await lessonListRepository.getLessonList();

    lessonList.value = response;
    isLoadingLessonList.value = false;
  }

  Future<bool> sendMessage() async {
    if (isValidMessage()) {
      DefaultDTO? response =
          await lessonListRepository.sendMessage(message.value);

      if (response != null && response.status == 'success') {
        return true;
      }
    }

    return false;
  }
}
