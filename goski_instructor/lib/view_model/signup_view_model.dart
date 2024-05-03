import 'dart:io';

import 'package:get/get.dart';
import 'package:goski_instructor/const/enum/gender.dart';
import 'package:goski_instructor/const/enum/role.dart';
import 'package:goski_instructor/data/model/certificate.dart';
import 'package:goski_instructor/data/model/instructor.dart';
import 'package:goski_instructor/data/model/owner.dart';
import 'package:goski_instructor/data/repository/auth_repository.dart';

class SignupViewModel extends GetxController {
  final AuthRepository authRepository = Get.find();
  RxBool isBoss = false.obs;
  var instructor = Instructor(
    domainUserKey: 1,
    kakaoProfileUrl: '',
    userName: '',
    gender: Gender.MALE,
    birthDate: DateTime.now(),
    role: Role.INSTRUCTOR,
    phoneNumber: '',
    certificates: [],
    lessonType: '',
  ).obs;

  var owner = Owner(
    domainUserKey: 1,
    kakaoProfileUrl: '',
    userName: '',
    gender: Gender.MALE,
    birthDate: DateTime.now(),
    role: Role.OWNER,
    phoneNumber: '',
  ).obs;

  Future<bool> instructorSignup(Instructor instructor) async {
    return await authRepository.instructorSignup(instructor);
  }

  Future<bool> ownerSignup(Owner owner) async {
    return await authRepository.ownerSignup(owner);
  }

  void addCertificate(Certificate certificate) {
    var currentCerts = instructor.value.certificates;
    currentCerts.add(certificate);
    instructor.update((val) {
      val?.certificates = currentCerts;
    });
  }

  void removeCertificate(int index) {
    var currentCerts = instructor.value.certificates;
    if (index >= 0 && index < currentCerts.length) {
      currentCerts.removeAt(index);
      instructor.update((val) {
        val?.certificates = currentCerts;
      });
    }
  }
}
