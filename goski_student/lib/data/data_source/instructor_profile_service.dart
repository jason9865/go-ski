import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:goski_student/data/model/instructor_profile_response.dart';
import 'package:goski_student/data/model/review_response.dart';
import 'package:logger/logger.dart';

import '../../const/util/custom_dio.dart';

var logger = Logger();

class InstructorProfileService extends GetxService {
  final baseUrl = dotenv.env['BASE_URL'];

  Future<InstructorProfileResponse?> getInstructorProfile(int instructorId) async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/user/profile/inst/$instructorId',
      );

      logger.d(response.data);

      if (response.data['status'] == 'success' &&
          response.data is Map<String, dynamic>) {
        InstructorProfileResponse data = InstructorProfileResponse.fromJson(response.data['data'] as Map<String, dynamic>);

        logger.d('InstructorProfileService - getInstructorProfile - 응답 성공 $data');

        return data;
      } else {
        logger.e('InstructorProfileService - getInstructorProfile - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('InstructorProfileService - getInstructorProfile - 응답 실패 ${e}');
    }

    return null;
  }

  Future<List<ReviewResponse>> getInstructorReview(int instructorId) async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/lesson/review/list/$instructorId',
      );

      logger.d(response.data['data']);

      if (response.data['status'] == 'success' &&
          response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        List<ReviewResponse> data = (response.data['data'] as List)
            .map<ReviewResponse>((json) =>
            ReviewResponse.fromJson(json as Map<String, dynamic>))
            .toList();
        logger.d('InstructorProfileService - getInstructorReview - 응답 성공 ${data}');

        return data;
      } else {
        logger.e('InstructorProfileService - getInstructorReview - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('InstructorProfileService - getInstructorReview - 응답 실패 ${e}');
    }

    return [];
  }
}