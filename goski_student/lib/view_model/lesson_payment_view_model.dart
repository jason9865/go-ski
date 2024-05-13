import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/util/url_launch_util.dart';
import 'package:goski_student/data/model/instructor.dart';
import 'package:goski_student/data/model/kakao_pay.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/data/model/student_info.dart';
import 'package:goski_student/data/repository/lesson_payment_repository.dart';
import 'package:goski_student/ui/reservation/u025_reservation_complete.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LessonPaymentViewModel {
  final lessonPaymentRepository = Get.find<LessonPaymentRepository>();
  var pgToken = '';

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(goskiBackground)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('http://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://flutter.dev'));

  Future<void> teamLessonPayment(
      ReservationRequest reservationRequest,
      BeginnerResponse beginnerResponse,
      List<StudentInfo> studentInfo,
      String requestComplain) async {
    try {
      KakaoPayPrepareResponse kakaoPayPrepareResponse =
          await lessonPaymentRepository.teamLessonPayment(reservationRequest,
              beginnerResponse, studentInfo, requestComplain);
      if (kakaoPayPrepareResponse.next_redirect_pc_url.isNotEmpty) {
        _showWebView(kakaoPayPrepareResponse,
            beginnerResponse: beginnerResponse);
      } else {
        Get.snackbar('Payment Error', 'Failed to initiate payment');
      }
    } catch (e) {
      Get.snackbar(
          'Payment Error', 'An error occurred during payment initiation: $e');
    }
  }

  Future<void> instLessonPayment(
      ReservationRequest reservationRequest,
      BeginnerResponse beginnerResponse,
      Instructor instructor,
      List<StudentInfo> studentInfo,
      String requestComplain) async {
    try {
      KakaoPayPrepareResponse kakaoPayPrepareResponse =
          await lessonPaymentRepository.instLessonPayment(reservationRequest,
              beginnerResponse, instructor, studentInfo, requestComplain);
      if (kakaoPayPrepareResponse.next_redirect_pc_url.isNotEmpty) {
        _showWebView(kakaoPayPrepareResponse,
            beginnerResponse: beginnerResponse, instructor: instructor);
      } else {
        Get.snackbar('Payment Error', 'Failed to initiate payment');
      }
    } catch (e) {
      Get.snackbar(
          'Payment Error', 'An error occurred during payment initiation: $e');
    }
  }

  Future<void> advancedLessonPayment(
      ReservationRequest reservationRequest,
      Instructor instructor,
      List<StudentInfo> studentInfo,
      String requestComplain) async {
    try {
      KakaoPayPrepareResponse kakaoPayPrepareResponse =
          await lessonPaymentRepository.advancedLessonPayment(
              reservationRequest, instructor, studentInfo, requestComplain);
      if (kakaoPayPrepareResponse.next_redirect_pc_url.isNotEmpty) {
        _showWebView(kakaoPayPrepareResponse, instructor: instructor);
      } else {
        Get.snackbar('Payment Error', 'Failed to initiate payment');
      }
    } catch (e) {
      Get.snackbar(
          'Payment Error', 'An error occurred during payment initiation: $e');
    }
  }

  void _showWebView(KakaoPayPrepareResponse response,
      {BeginnerResponse? beginnerResponse, Instructor? instructor}) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(response.next_redirect_pc_url))
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          return NavigationDecision.navigate;
        },
        onUrlChange: (UrlChange change) {
          debugPrint('url change to ${change.url}');
        },
        onPageFinished: (String url) async {
          debugPrint('page finished loading: $url');
          if (url.startsWith('https://developers.kakao.com/success')) {
            Uri uri = Uri.parse(url);
            String? pgToken = uri.queryParameters['pg_token'];
            logger.d(pgToken);
            if (pgToken != null) {
              Get.back(); // Close the WebView dialog
              if (await _approvePayment(response.tid, pgToken)) {
                if (instructor == null) {
                  Get.to(() => ReservationCompleteScreen(
                      teamInformation: beginnerResponse));
                } else if (beginnerResponse == null) {
                  Get.to(
                      () => ReservationCompleteScreen(instructor: instructor));
                } else {
                  Get.to(() => ReservationCompleteScreen(
                        teamInformation: beginnerResponse,
                        instructor: instructor,
                      ));
                }
              }
            }
          }
        },
      ));
    Get.dialog(
      WebViewWidget(
        controller: controller,
      ),
    );
  }

  Future<bool> _approvePayment(String tid, String pgToken) async {
    try {
      bool result = await lessonPaymentRepository.approvePayment(tid, pgToken);
      if (result) {
        Get.snackbar('결제 성공', '정상적으로 결제가 완료되었습니다.');
        return true;
      } else {
        Get.snackbar('결제 실패', '결제에 실패하였습니다.\n다시 시도해주세요.');
      }
    } catch (e) {
      Get.snackbar('결제 실패', '결제에 실패하였습니다.\n다시 시도해주세요.\n$e');
    }
    return false;
  }
}
