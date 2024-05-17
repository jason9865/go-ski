import 'package:get/get.dart';
import 'package:goski_instructor/const/util/custom_dio.dart';
import 'package:goski_instructor/data/data_source/main_service.dart';
import 'package:goski_instructor/data/model/review_response.dart';

import '../../main.dart';

class ReviewService extends GetxService {
  Future<List<ReviewResponse>> getReviewList() async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/lesson/review/list',
      );

      if (response.data['status'] == 'success' &&
          response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        List<ReviewResponse> data = (response.data['data'] as List)
            .map<ReviewResponse>(
                (json) => ReviewResponse.fromJson(json as Map<String, dynamic>))
            .toList();
        logger.d('ReviewService - getReviewList - 응답 성공 $data');

        return data;
      } else {
        logger.e('ReviewService - getReviewList - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('ReviewService - getReviewList - 응답 실패 $e');
    }

    return [];
  }
}
