import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/util/custom_dio.dart';
import 'package:goski_student/data/model/notification.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class NotificationService extends GetxService {
  final FlutterSecureStorage secureStroage = const FlutterSecureStorage();
  final baseUrl = dotenv.env['BASE_URL'];

  Future<List<NotiResponse>> fetchNotificationList() async {
    try {
      dynamic response = await CustomDio.dio.get(
        '$baseUrl/notification',
      );
      logger.w("notificationList: $response");

      if (response.statusCode == 200) {
        var data = response.data['data'];
        List<NotiResponse> notifications = List<NotiResponse>.from(
            data.map((item) => NotiResponse.fromJson(item)));
        return notifications;
      } else {
        logger.e("Failed to fetch data: Status code ${response.statusCode}");
        return [];
      }
    } catch (e) {
      logger.e('Error fetching NotificationList from server: $e');
      return [];
    }
  }
}
