import 'package:get/get.dart';
import 'package:goski_student/data/data_source/notification_service.dart';
import 'package:goski_student/data/model/notification.dart';
import 'package:goski_student/data/model/notification_setting.dart';

class NotificationRepository {
  final NotificationService notificationService = Get.find();

  Future<List<Noti>> getNotificationList() async {
    List<NotiResponse> responses =
        await notificationService.fetchNotificationList();
    List<Noti> notifications = responses.map((response) {
      return response.toNotification();
    }).toList();
    return notifications;
  }

  Future<bool> deleteNotification(int notificationId) async {
    return await notificationService.deleteNotification(notificationId);
  }

  Future<bool> readAllNoti() async {
    return await notificationService.readAllNoti();
  }

  Future<List<NotificationSetting>> getNotificationSetting() async {
    List<NotificationSettingDTO> responses =
        await notificationService.fetchNotificationSetting();
    List<NotificationSetting> notificationSettings = responses.map((response) {
      return response.toNotificationSetting();
    }).toList();

    return notificationSettings;
  }

  Future<bool> updateNotificationSetting(
      List<NotificationSetting> notificationSettings) async {
    List<NotificationSettingDTO> notificationSettingDTOs = notificationSettings
        .map((item) => item.toNotificationSettingDTO())
        .toList();
    return await notificationService
        .updateNotificationSetting(notificationSettingDTOs);
  }
}
