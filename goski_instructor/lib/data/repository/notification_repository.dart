import 'package:get/get.dart';
import 'package:goski_instructor/data/data_source/notification_service.dart';
import 'package:goski_instructor/data/model/notification.dart';

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
}
