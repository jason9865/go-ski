import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/util/custom_dio.dart';
import 'package:goski_student/data/model/default_dto.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class UserService extends GetxService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final baseUrl = dotenv.env['BASE_URL'];

  Future<void> sendFCMTokenToServer(String fcmToken) async {
    try {
      dynamic response = await CustomDio.dio.post(
        '$baseUrl/notification/token',
        data: jsonEncode(<String, String>{
          'token': fcmToken,
          'tokenType': "MOBILE",
        }),
      );
      if (response.data['status'] == "success") {
        logger.d('FCMToken successfully sent to the server');
        logger.d("response: ${response.data}");
      } else {
        logger.e('Failed to send FCMToken to the server: ${response.data}');
      }
    } catch (e) {
      logger.e('Error sending FCMToken to the server: $e');
    }
  }

  Future<DefaultDTO?> requestResign() async {
    try {
      dynamic response = await CustomDio.dio.delete(
          '$baseUrl/user/resign',
      );

      if (response.data['status'] == "success") {
        logger.d('UserService - requestResign - 응답 성공');
        DefaultDTO defaultDTO =
        DefaultDTO.fromJson(response.data as Map<String, dynamic>);
        return defaultDTO;
      } else {
        logger.e('UserService - requestResign - 응답 실패 ${response.body}');
      }
    } catch (e) {
      logger.e('UserService - requestResign - 응답 실패 $e');
    }

    return null;
  }
}
