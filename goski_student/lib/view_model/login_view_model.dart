import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  final AuthRepository authRepository = Get.find();
  final RxBool isLoggedIn = false.obs;

  Future<AuthStatus> loginWithKakao() async {
    return await authRepository.login();
  }
}
