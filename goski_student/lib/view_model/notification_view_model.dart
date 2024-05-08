import 'package:get/get.dart';
import 'package:goski_student/const/util/dio_interceptor.dart';
import 'package:goski_student/data/model/notification.dart';
import 'package:goski_student/data/model/notification_setting.dart';
import 'package:goski_student/data/repository/notification_repository.dart';

class NotificationViewModel extends GetxController {
  final NotificationRepository notificationRepository = Get.find();
  RxList<Noti> notificationList = <Noti>[].obs;
  RxList<NotificationSetting> notificationSettings =
      <NotificationSetting>[].obs;

  Future<void> getNotificationList() async {
    List<Noti> fetchedNotifications =
        await notificationRepository.getNotificationList();
    if (fetchedNotifications.isNotEmpty) {
      notificationList.assignAll(fetchedNotifications);
    } else {
      notificationList.clear();
    }
  }

  // TODO: 삭제 성공 or 실패에 대한 UI&UX 제공 추가
  Future<bool> deleteNotification(int notificationId) async {
    return await notificationRepository.deleteNotification(notificationId);
  }

  Future<void> getNotificationSetting() async {
    List<NotificationSetting> fetchedNotificationSettings =
        await notificationRepository.getNotificationSetting();
    if (fetchedNotificationSettings.isNotEmpty) {
      notificationSettings.assignAll(fetchedNotificationSettings);
    } else {
      notificationSettings.clear();
    }
  }

  Future<bool> updateNotificationSetting() async {
    return await notificationRepository
        .updateNotificationSetting(notificationSettings);
  }
}
