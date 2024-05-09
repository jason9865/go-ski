import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:goski_instructor/const/enum/role.dart';
import 'package:goski_instructor/data/model/certificate.dart';
import 'package:goski_instructor/data/model/user.dart';
import 'package:goski_instructor/data/repository/auth_repository.dart';
import 'package:goski_instructor/data/repository/user_repository.dart';

class SignupViewModel extends GetxController {
  final AuthRepository authRepository = Get.find();
  final UserRespository userRepository = Get.find();
  RxBool isBoss = false.obs;
  RxBool isSki = true.obs;
  RxBool hasProfileImage = false.obs;
  Rx user = User(certificates: []).obs;
  List<CertificateChoice> skiCertificateChoiceList = <CertificateChoice>[];
  List<CertificateChoice> boardCertificateChoiceList = <CertificateChoice>[];
  RxList<CertificateChoice> certificateChoiceList = <CertificateChoice>[].obs;

  Future<bool> instructorSignup(User user) async {
    user.role = Role.INSTRUCTOR;
    return await authRepository.instructorSignup(user.toInstructorRequest());
  }

  Future<bool> ownerSignup(User user) async {
    user.role = Role.OWNER;
    return await authRepository.ownerSignup(user.toOwnerRequest());
  }

  void addCertificate(Certificate certificate) {
    var currentCerts = user.value.certificates;
    currentCerts.add(certificate);
    user.update((val) {
      val?.certificates = currentCerts;
    });
  }

  void removeCertificate(int index) {
    var currentCerts = user.value.certificates;
    if (index >= 0 && index < currentCerts.length) {
      currentCerts.removeAt(index);
      user.update((val) {
        val?.certificates = currentCerts;
      });
    }
  }

  Future<void> getCertificateList() async {
    List<CertificateChoice> response =
        await userRepository.getCertificateChoiceList();
    skiCertificateChoiceList.assignAll(
        response.where((item) => item.certificateType == 'SKI').toList());
    boardCertificateChoiceList.assignAll(
        response.where((item) => item.certificateType == 'BOARD').toList());
    certificateChoiceList.assignAll(skiCertificateChoiceList);
  }

  void switchCertificateChoiceList(int index) {
    if (index == 0) {
      certificateChoiceList.assignAll(skiCertificateChoiceList);
    } else {
      certificateChoiceList.assignAll(boardCertificateChoiceList);
    }
  }
}
