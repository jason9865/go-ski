import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:goski_student/data/model/ski_resort.dart';
import 'package:goski_student/data/repository/ski_resort_repository.dart';

class SkiResortViewModel extends GetxController {
  final SkiResortRepository _skiResortRepository = SkiResortRepository();
  var skiResorts = <SkiResort>[].obs;

  // 선택된 리조트 idx 값
  Rx<int> selectedResortIndex = 0.obs;

  // 선택된 리조트 명
  RxString skiResortSelected = ''.obs;

  // 선택된 리조트에 해당하는 Lesson Time List
  RxList<int> selectedResortLessonTimes = <int>[].obs;
  Rx<int> selectedLessonTimeIndex = 0.obs;

  SkiResortViewModel() {
    getSkiResortList();
    ever(selectedResortIndex, handleResortChange);
  }

  Future<void> getSkiResortList() async {
    skiResorts.value = await _skiResortRepository.getSkiResortList();
  }

  void setResort(int idx) {
    skiResortSelected.value = skiResortNames[idx];
    selectedResortIndex.value = idx;
    selectedResortLessonTimes.value = skiResorts[idx].lessonTimeList;
  }

  void handleResortChange(int idx) {
    if (skiResorts.isNotEmpty) {
      selectedResortLessonTimes.value = skiResorts[idx].lessonTimeList;
    }
  }

  List<String> get skiResortNames =>
      skiResorts.map((resort) => resort.resortName).toList();

  List<String> get lessonTimeStrings => selectedResortLessonTimes
      .map((time) => tr('timeUnit',
          args: [time.toString()])) // Converting to a readable format
      .toList();
}
