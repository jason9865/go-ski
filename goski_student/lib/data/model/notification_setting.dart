/* 
notificationType  Type
      1           강습 완료 정산 알림
      2           강습 예약 알림
      3           강습 취소 알림
      4           강습 변경 알림
      5           팀 초대 알림
      6           강습 1시간 전 알림
      7           강습 예약 완료 알림
      8           피드백 수신 알림
      9           쪽지 수신 알림
*/

class NotificationSetting {
  int notificationType;
  bool status;

  NotificationSetting({
    required this.notificationType,
    required this.status,
  });
}

class NotificationSettingDTO {
  int notificationType;
  bool status;

  NotificationSettingDTO({
    required this.notificationType,
    required this.status,
  });

  factory NotificationSettingDTO.fromJson(Map<String, dynamic> json) {
    return NotificationSettingDTO(
      notificationType: json['notificationType'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationType': notificationType,
      'status': status,
    };
  }
}

extension NotificationSettingDTOToNotificationSetting
    on NotificationSettingDTO {
  NotificationSetting toNotificationSetting() {
    return NotificationSetting(
      notificationType: notificationType,
      status: status,
    );
  }
}

extension NotificationSettingToNotificationSettingDTO on NotificationSetting {
  NotificationSettingDTO toNotificationSettingDTO() {
    return NotificationSettingDTO(
      notificationType: notificationType,
      status: status,
    );
  }
}
