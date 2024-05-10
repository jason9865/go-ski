import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/util/custom_dio.dart';
import 'package:goski_student/data/model/coupon_response.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class CouponService extends GetxService {
  final baseUrl = dotenv.env['BASE_URL'];

  Future<List<CouponResponse>> getCouponList() async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/lesson/review/tags',
      );

      if (response.data['status'] == 'success' &&
          response.data is Map<String, dynamic> &&
          response.data['data'] is List) {
        List<CouponResponse> data = (response.data['data'] as List)
            .map<CouponResponse>((json) =>
            CouponResponse.fromJson(json as Map<String, dynamic>))
            .toList();
        logger.d('CouponService - getCouponList - 응답 성공 $data');

        return data;
      } else {
        logger.e('CouponService - getCouponList - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('CouponService - getCouponList - 응답 실패 $e');
    }

    return [];
  }
}