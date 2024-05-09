import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/enum/gender.dart';
import 'package:goski_student/const/enum/role.dart';
import 'package:goski_student/data/model/instructor_profile_response.dart';
import 'package:goski_student/data/model/review_response.dart';
import 'package:goski_student/data/repository/instructor_profile_repository.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class InstructorProfileViewModel extends GetxController {
  final InstructorProfileRepository instructorProfileRepository = Get.find();
  Rx<InstructorProfile> instructorProfile = InstructorProfile(
    userName: '',
    birthDate: DateTime.now(),
    phoneNumber: '',
    gender: Gender.MALE,
    role: Role.STUDENT,
    description: '',
    dayoff: 0,
    available: '',
    certificates: [],
  ).obs;

  RxList<String> skiCertificate = <String>[].obs;
  RxList<String> boardCertificate = <String>[].obs;

  RxList<ReviewResponse> reviewList = <ReviewResponse>[].obs;

  void initInstructorProfile() {
    instructorProfile.value = InstructorProfile(
      userName: '',
      birthDate: DateTime.now(),
      phoneNumber: '',
      gender: Gender.MALE,
      role: Role.STUDENT,
      description: '',
      dayoff: 0,
      available: '',
      certificates: [],
    );
    skiCertificate.clear();
    boardCertificate.clear();
  }

  void createCertificateList(InstructorProfile instructorProfile) {
    for (Certificate certificate in instructorProfile.certificates) {
      switch (certificate.certificateId) {
        case 1:
          skiCertificate.add(tr('level1'));
          break;
        case 2:
          skiCertificate.add(tr('level2'));
          break;
        case 3:
          skiCertificate.add(tr('level3'));
          break;
        case 4:
          skiCertificate.add(tr('teaching1'));
          break;
        case 5:
          skiCertificate.add(tr('teaching2'));
          break;
        case 6:
          skiCertificate.add(tr('teaching3'));
          break;
        case 7:
          skiCertificate.add(tr('demonstrator'));
          break;
        case 8:
          boardCertificate.add(tr('level1'));
          break;
        case 9:
          boardCertificate.add(tr('level2'));
          break;
        case 10:
          boardCertificate.add(tr('level3'));
          break;
        case 11:
          boardCertificate.add(tr('teaching1'));
          break;
        case 12:
          boardCertificate.add(tr('teaching2'));
          break;
        case 13:
          boardCertificate.add(tr('teaching3'));
          break;
        case 14:
          boardCertificate.add(tr('demonstrator'));
          break;
        default:
          break;
      }
    }
  }

  String getAvgRate() {
    double sum = 0;

    for (ReviewResponse review in reviewList) {
      sum += review.rating;
    }

    return (sum / reviewList.length).toStringAsFixed(1);
  }

  Future<void> getInstructorProfile(int instructorId) async {
    initInstructorProfile();

    InstructorProfile? response =
    await instructorProfileRepository.getInstructorProfile(instructorId);

    if (response != null) {
      createCertificateList(response);
      instructorProfile.value = response;
    }
  }

  Future<void> getInstructorReview(int instructorId) async {
    reviewList.clear();

    List<ReviewResponse> response = await instructorProfileRepository.getInstructorReview(instructorId);

    reviewList.addAll(response);
  }
}
