import 'package:get/get.dart';
import 'package:goski_student/data/data_source/notification_service.dart';
import 'package:goski_student/data/model/notification.dart';

class NotificationRepository {
  final NotificationService notificationService = Get.find();

  Future<List<Noti>> getNotificationList() async {
    try {
      List<NotiResponse> responses =
          await notificationService.fetchNotificationList();
      List<Noti> notifications = responses.map((response) {
        return Noti(
          notificationId: response.notificationId,
          senderId: response.senderId,
          senderName: response.senderName,
          notificationType: response.notificationType,
          title: response.title,
          content: response.content,
          imageUrl: response.imageUrl,
          isRead: response.isRead,
          createdAt: response.createdAt,
        );
      }).toList();
      return notifications;
    } catch (e) {
      logger.e('Error while fetching notifications: $e');
      return [];
    }
  }
}
