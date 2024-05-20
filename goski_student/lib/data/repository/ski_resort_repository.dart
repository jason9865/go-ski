import 'package:get/get.dart';
import 'package:goski_student/data/data_source/ski_resort_service.dart';
import 'package:goski_student/data/model/ski_resort.dart';

class SkiResortRepository {
  final SkiResortService skiResortService = Get.find();

  Future<List<SkiResort>> getSkiResortList() async {
    return await skiResortService.getSkiResorts();
  }
}
