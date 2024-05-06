import 'package:get/get.dart';
import 'package:goski_student/data/model/ski_resort.dart';
import 'package:goski_student/data/repository/ski_resort_repository.dart';

class SkiResortViewModel extends GetxController {
  final SkiResortRepository _skiResortRepository = SkiResortRepository();
  var skiResorts = <SkiResort>[].obs;

  SkiResortViewModel() {
    _getSkiResortList();
  }

  Future<void> _getSkiResortList() async {
    skiResorts.value = await _skiResortRepository.getSkiResortList();
  }

  List<String> get skiResortNames =>
      skiResorts.map((resort) => resort.resortName).toList();
}
