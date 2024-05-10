import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/util/custom_dio.dart';
import 'package:goski_student/data/model/default_dto.dart';
import 'package:goski_student/data/model/review_request.dart';
import 'package:goski_student/data/model/review_tag_response.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class ReviewService extends GetxService {
  final baseUrl = dotenv.env['BASE_URL'];

  Future<DefaultDTO?> writeReview(ReviewRequest reviewRequest) async {
    try {
      dynamic response = await CustomDio.dio.post(
        '$baseUrl/lesson/review/create',
        data: reviewRequest,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      if (response.data['status'] == 'success') {
        logger.d('ReviewService - writeReview - 응답 성공');
        DefaultDTO defaultDTO = DefaultDTO.fromJson(response.data as Map<String, dynamic>);
        return defaultDTO;
      } else {
        logger.e('ReviewService - writeReview - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('ReviewService - writeReview - 응답 실패 $e');
    }

    return null;
  }

  Future<List<ReviewTagResponse>> getReviewTagList() async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/lesson/review/tags',
      );

      if (response.data['status'] == 'success' &&
          response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        List<ReviewTagResponse> data = (response.data['data'] as List)
            .map<ReviewTagResponse>((json) =>
            ReviewTagResponse.fromJson(json as Map<String, dynamic>))
            .toList();
        logger.d('ReviewService - getReviewTagList - 응답 성공 $data');

        return data;
      } else {
        logger.e('ReviewService - getReviewTagList - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('ReviewService - getReviewTagList - 응답 실패 $e');
    }

    return [];
  }
}