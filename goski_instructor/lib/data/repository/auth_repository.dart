import 'package:get/get.dart';
import 'package:goski_instructor/const/enum/auth_status.dart';
import 'package:goski_instructor/data/data_source/auth_service.dart';
import 'package:goski_instructor/data/model/instructor.dart';
import 'package:goski_instructor/data/model/owner.dart';

class AuthRepository {
  final AuthService authService = Get.find();

  Future<AuthStatus> login() async {
    return await authService.loginWithKakao();
  }

  Future<bool> instructorSignup(InstructorRequest instructor) async {
    if (await authService.instructorSignUp(instructor)) {
      return true;
    }
    return false;
  }

  Future<bool> ownerSignup(OwnerRequest owner) async {
    if (await authService.ownerSignUp(owner)) {
      return true;
    }
    return false;
  }
}
