import 'package:get/get.dart';
import 'package:goski_student/const/enum/role.dart';
import 'package:goski_student/data/model/user.dart';
import 'package:goski_student/data/repository/auth_repository.dart';

class SignupViewModel extends GetxController {
  final AuthRepository authRepository = Get.find();
  RxBool isBoss = false.obs;
  var user = User().obs;

  Future<bool> ownerSignup(User user) async {
    user.role = Role.OWNER;
    return await authRepository.userSignup(user.toUserRequest());
  }
}
