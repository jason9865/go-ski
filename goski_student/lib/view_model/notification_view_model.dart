import 'package:get/get.dart';
import 'package:goski_student/const/util/dio_interceptor.dart';
import 'package:goski_student/data/model/notification.dart';
import 'package:goski_student/data/repository/notification_repository.dart';

class NotificationViewModel extends GetxController {
  final NotificationRepository notificationRepository = Get.find();
  RxList<Noti> notificationList = <Noti>[].obs;

  Future<void> getNotificationList() async {
    try {
      List<Noti> fetchedNotifications =
          await notificationRepository.getNotificationList();
      if (fetchedNotifications.isNotEmpty) {
        notificationList.assignAll(fetchedNotifications);
      } else {
        notificationList.clear();
      }
    } catch (e) {
      logger.e('Error fetching notifications: $e');
      notificationList.clear();
    }
  }
}
