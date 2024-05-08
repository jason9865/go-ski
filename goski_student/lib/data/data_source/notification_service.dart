import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/util/custom_dio.dart';
import 'package:goski_student/data/model/notification.dart';
import 'package:goski_student/data/model/notification_setting.dart';
import 'package:goski_student/main.dart';

class NotificationService extends GetxService {
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

  Future<bool> deleteNotification(int notificationId) async {
    try {
      dynamic response = await CustomDio.dio.delete(
        '$baseUrl/notification/delete/$notificationId',
      );
      if (response.data['status'] == "success") {
        return true;
      }
    } catch (e) {
      logger.e("Failed to delete notification : $e");
    }
    return false;
  }

  Future<bool> readAllNoti() async {
    try {
      dynamic response =
          await CustomDio.dio.patch('$baseUrl/notification/read-all');
      if (response.data['status'] == "success") {
        return true;
      }
    } catch (e) {
      logger.e("Failed to request readAllNoti : $e");
    }
    return false;
  }

  Future<List<NotificationSettingDTO>> fetchNotificationSetting() async {
    try {
      dynamic response =
          await CustomDio.dio.get('$baseUrl/notification/setting');
      logger.d(response.data);
      if (response.data['status'] == "success") {
        var data = response.data['data'];
        List<NotificationSettingDTO> notificationSettings =
            List<NotificationSettingDTO>.from(
                data.map((item) => NotificationSettingDTO.fromJson(item)));
        return notificationSettings;
      }
    } catch (e) {
      logger.d("Failed to fetch notification setting : $e");
    }
    return [];
  }

  Future<bool> updateNotificationSetting(
      List<NotificationSettingDTO> notificationDTOs) async {
    List<Map<String, dynamic>> jsonList =
        notificationDTOs.map((dto) => dto.toJson()).toList();
    try {
      dynamic response = await CustomDio.dio.patch(
        '$baseUrl/notification/setting',
        data: {
          'notificationTypes': jsonList,
        },
      );
      if (response.data['status'] == "success") {
        return true;
      }
    } catch (e) {
      logger.e("Failed to update notification setting: $e");
    }

    return false;
  }
}
