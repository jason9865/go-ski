import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:goski_student/data/model/main_response.dart';
import 'package:logger/logger.dart';

import '../../const/util/custom_dio.dart';

var logger = Logger();

class MainService extends GetxService {
  final baseUrl = dotenv.env['BASE_URL'];

  Future<MainResponse?> getUserInfo() async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/user/profile/user',
      );

      if (response.data['status'] == 'success') {
          MainResponse data = MainResponse.fromJson(response.data['data'] as Map<String, dynamic>);
          logger.d('UserService - getUserInfo - 응답 성공 $data');

          return data;
      } else {
        logger.e('UserService - getUserInfo - 응답 실패 ${response.data}');
      }

    } catch (e) {
      logger.e('UserService - getUserInfo - 응답 실패 $e');
    }

    return null;
  }
}
