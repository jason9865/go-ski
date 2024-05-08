import 'package:get/get.dart';
import 'package:goski_student/data/model/main_response.dart';
import 'package:goski_student/data/repository/main_repository.dart';

class MainViewModel extends GetxController {
  final MainRepository mainRepository = Get.find();
  Rx<Main> userInfo = Main().obs;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  void getUserInfo() async {
    Main? response = await mainRepository.getUserInfo();
    
    if (response != null) {
      userInfo.value = response;
    }
  }
}
