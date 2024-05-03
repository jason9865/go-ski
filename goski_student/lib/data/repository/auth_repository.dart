import 'package:get/get.dart';
import 'package:goski_student/const/enum/auth_status.dart';
import 'package:goski_student/data/data_source/auth_service.dart';
import 'package:goski_student/data/model/user.dart';

class AuthRepository {
  final AuthService authService = Get.find();

  Future<AuthStatus> login() async {
    return await authService.loginWithKakao();
  }

  Future<bool> studentSignup(UserRequest user) async {
    if (await authService.userSignUp(user)) {
      return true;
    }
    return false;
  }

  // Future<DefaultDTO> ownerSignIn(Owner owner) async {
  //   return await authService.ownerSignUp();
  // }
}
