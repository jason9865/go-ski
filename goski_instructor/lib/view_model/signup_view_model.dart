import 'dart:io';

import 'package:get/get.dart';
import 'package:goski_instructor/data/model/instructor.dart';
import 'package:goski_instructor/data/repository/auth_repository.dart';

class SignupViewModel extends GetxController {
  final AuthRepository authRepository = Get.find();
  Instructor? instructor;

  Future<bool> instructorSignup(Instructor instructor) async {
    return await authRepository.instructorSignup(instructor);
  }
}
