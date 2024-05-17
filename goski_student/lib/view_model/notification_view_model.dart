import 'package:get/get.dart';
import 'package:goski_student/data/model/notification.dart';
import 'package:goski_student/data/model/notification_setting.dart';
import 'package:goski_student/data/repository/notification_repository.dart';

class NotificationViewModel extends GetxController {
  final NotificationRepository notificationRepository = Get.find();
  RxList<Noti> notificationList = <Noti>[].obs;
  RxList<NotificationSetting> notificationSettings =
      <NotificationSetting>[].obs;
  RxBool hasUnread = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    initFetchNotificationList();
  }

  Future<void> initFetchNotificationList() async {
    List<Noti> fetchedNotifications =
        await notificationRepository.getNotificationList();
    updateUnreadStatus(fetchedNotifications);
  }

  Future<void> getNotificationList() async {
    notificationList.clear();
    isLoading.value = true;
    List<Noti> fetchedNotifications =
        await notificationRepository.getNotificationList();

    isLoading.value = false;
    if (fetchedNotifications.isNotEmpty) {
      notificationList.assignAll(fetchedNotifications);
    } else {
      notificationList.clear();
      hasUnread.value = false;
    }
  }

  // TODO: 삭제 성공 or 실패에 대한 UI&UX 제공 추가
  Future<bool> deleteNotification(int notificationId) async {
    return await notificationRepository.deleteNotification(notificationId);
  }

  Future<void> readAllNoti() async {
    if (await notificationRepository.readAllNoti()) {
      hasUnread.value = false;
    }
  }

  void updateUnreadStatus(List<Noti> list) {
    bool foundUnread = list.any((noti) => noti.isRead == 0);
    hasUnread.value = foundUnread;
  }

  Future<void> getNotificationSetting() async {
    List<NotificationSetting> fetchedNotificationSettings =
        await notificationRepository.getNotificationSetting();
    notificationSettings.clear();
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
