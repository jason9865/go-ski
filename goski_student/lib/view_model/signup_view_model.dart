import 'package:get/get.dart';
import 'package:goski_student/const/enum/role.dart';
import 'package:goski_student/data/model/user.dart';
import 'package:goski_student/data/repository/auth_repository.dart';

class SignupViewModel extends GetxController {
  final AuthRepository authRepository = Get.find();
  var user = User().obs;

  Future<bool> userSignup(User user) async {
    user.role = Role.STUDENT;
    return await authRepository.userSignup(user.toUserRequest());
  }
}
