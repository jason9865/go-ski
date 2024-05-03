import 'package:get/get.dart';
import 'package:goski_instructor/const/enum/auth_status.dart';
import 'package:goski_instructor/data/data_source/auth_service.dart';
import 'package:goski_instructor/data/model/default_dto.dart';
import 'package:goski_instructor/data/model/instructor.dart';
import 'package:goski_instructor/data/model/owner.dart';

class AuthRepository {
  final AuthService authService = Get.find();

  Future<AuthStatus> login() async {
    return await authService.loginWithKakao();
  }

  Future<bool> instructorSignup(Instructor instructor) async {
    if (await authService.instructorSignUp(instructor)) {
      return true;
    }
    return false;
  }

  // Future<DefaultDTO> ownerSignIn(Owner owner) async {
  //   return await authService.ownerSignUp();
  // }
}
