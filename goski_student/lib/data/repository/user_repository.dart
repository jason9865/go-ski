import 'package:get/get.dart';
import 'package:goski_student/data/data_source/user_service.dart';
import 'package:goski_student/data/model/default_dto.dart';

class UserRepository {
  final UserService userService = Get.find();

  Future<DefaultDTO?> requestResign() async {
    return userService.requestResign();
  }
}