import 'package:get/get.dart';
import 'package:goski_instructor/const/enum/auth_status.dart';
import 'package:goski_instructor/data/repository/auth_repository.dart';

class LoginViewModel extends GetxController {
  final AuthRepository authRepository = Get.find();
  final RxBool isLoggedIn = false.obs;

  Future<AuthStatus> loginWithKakao() async {
    return await authRepository.login();
  }
}
