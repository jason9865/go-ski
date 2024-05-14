import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/util/custom_dio.dart';
import 'package:goski_student/data/data_source/main_service.dart';
import 'package:goski_student/data/model/kakao_pay.dart';
import 'package:goski_student/main.dart';

class LessonPaymentService extends GetxService {

  Future<KakaoPayPrepareResponse> teamLessonPayment(
      Map<String, dynamic> teamLessonPaymentRequest) async {
    try {
      dynamic response = await CustomDio.dio.post(
        '$baseUrl/payment/reserve/prepare',
        data: teamLessonPaymentRequest,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      logger.d(response.data['data']);
      if (response.data['status'] == 'success') {
        logger.d('LessonPaymentService - teamLessonPayment - 응답 성공');
        KakaoPayPrepareResponse kakaoPayPrepareResponse =
            KakaoPayPrepareResponse.fromJson(
                response.data['data'] as Map<String, dynamic>);
        return kakaoPayPrepareResponse;
      } else {
        logger.e(
            'LessonPaymentService - teamLessonPayment - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('LessonPaymentService - teamLessonPayment - 응답 실패 ${e}');
    }

    return KakaoPayPrepareResponse(
        tid: '',
        next_redirect_app_url: '',
        next_redirect_mobile_url: '',
        next_redirect_pc_url: '',
        android_app_scheme: '',
        ios_app_scheme: '',
        created_at: '');
  }

  Future<KakaoPayPrepareResponse> instLessonPayment(
      Map<String, dynamic> instLessonPaymentRequest) async {
    try {
      dynamic response = await CustomDio.dio.post(
        '$baseUrl/payment/reserve/prepare',
        data: instLessonPaymentRequest,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      logger.d(response.data['data']);
      if (response.data['status'] == 'success') {
        logger.d('LessonPaymentService - instLessonPayment - 응답 성공');
        KakaoPayPrepareResponse kakaoPayPrepareResponse =
            KakaoPayPrepareResponse.fromJson(
                response.data['data'] as Map<String, dynamic>);
        return kakaoPayPrepareResponse;
      } else {
        logger.e(
            'LessonPaymentService - instLessonPayment - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('LessonPaymentService - instLessonPayment - 응답 실패 ${e}');
    }

    return KakaoPayPrepareResponse(
        tid: '',
        next_redirect_app_url: '',
        next_redirect_mobile_url: '',
        next_redirect_pc_url: '',
        android_app_scheme: '',
        ios_app_scheme: '',
        created_at: '');
  }

  Future<bool> approvePayment(
      Map<String, dynamic> approvePaymentRequest) async {
    logger.d(approvePaymentRequest);
    try {
      dynamic response = await CustomDio.dio.post(
        '$baseUrl/payment/reserve/approve',
        data: approvePaymentRequest,
      );

      logger.d(response.data['data']);
      if (response.data['status'] == 'success') {
        logger.d('LessonPaymentService - approvePayment - 응답 성공');
        return true;
      } else {
        logger.e(
            'LessonPaymentService - approvePayment - 응답 실패 ${response.data}');
      }
    } catch (e) {
      logger.e('LessonPaymentService - approvePayment - 응답 실패 ${e}');
    }

    return false;
  }
}
