import 'package:get/get.dart';
import 'package:goski_student/data/data_source/instructor_profile_service.dart';
import 'package:goski_student/data/model/instructor_profile_response.dart';
import 'package:goski_student/data/model/review_response.dart';

class InstructorProfileRepository {
  final InstructorProfileService instructorProfileService = Get.find();

  Future<InstructorProfile?> getInstructorProfile(int instructorId) async {
    InstructorProfileResponse? instructorProfileResponse = await instructorProfileService
        .getInstructorProfile(instructorId);

    return instructorProfileResponse?.toInstructorProfile();
  }

  Future<List<ReviewResponse>> getInstructorReview(int instructorId) async {
    return await instructorProfileService.getInstructorReview(instructorId);
  }
}