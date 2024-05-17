import 'package:get/get.dart';
import 'package:goski_instructor/data/data_source/user_service.dart';
import 'package:goski_instructor/data/model/certificate.dart';
import 'package:goski_instructor/data/model/instructor.dart';

class UserRespository {
  final UserService userService = Get.find();

  Future<List<CertificateChoice>> getCertificateChoiceList() async {
    List<CertificateChoiceResponse> response =
        await userService.fetchCertificateChoiceList();
    List<CertificateChoice> certificateChoiceList =
        List<CertificateChoice>.from(response.map((item) {
      return item.toCertificateChoice();
    }));
    return certificateChoiceList;
  }

  Future<Instructor?> getInstructorInfo() async {
    var response = await userService.fetchInstructorInfo();
    if (response != null) {
      Instructor instructor = response.toInstructor();
      return instructor;
    }
    return null;
  }
}
