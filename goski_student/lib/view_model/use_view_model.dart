import 'package:get/get.dart';
import 'package:goski_student/data/model/default_dto.dart';
import 'package:goski_student/data/repository/user_repository.dart';

class UserViewModel extends GetxController {
  final UserRepository userRepository = Get.find();

  Future<bool> requestResign() async {
    DefaultDTO? response = await userRepository.requestResign();

    if (response != null && response.status == 'success') {
        return true;
    }

    return false;
  }
}