import 'package:get/get.dart';
import 'package:goski_student/data/data_source/main_service.dart';
import 'package:goski_student/data/model/main_response.dart';

class MainRepository {
  final MainService mainService = Get.find();

  Future<Main?> getUserInfo() async {
    MainResponse? mainResponse = await mainService.getUserInfo();
    return mainResponse?.toMain();
  }
}
