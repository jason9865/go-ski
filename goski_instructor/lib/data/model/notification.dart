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

import 'package:goski_instructor/main.dart';

class Noti {
  int notificationId;
  int? senderId;
  String? senderName;
  int notificationType;
  String title;
  String content;
  String? imageUrl;
  int isRead;
  DateTime? createdAt;
  bool isExpanded;

  Noti({
    this.notificationId = 0,
    this.senderId,
    this.senderName,
    this.notificationType = 0,
    this.title = '',
    this.content = '',
    this.imageUrl,
    this.isRead = -1,
    this.createdAt,
    this.isExpanded = false,
  });
}

class NotiResponse {
  int notificationId;
  int? senderId;
  String? senderName;
  int notificationType;
  String title;
  String content;
  String? imageUrl;
  int isRead;
  DateTime? createdAt;

  NotiResponse({
    required this.notificationId,
    this.senderId,
    this.senderName,
    required this.notificationType,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.isRead,
    this.createdAt,
  });

  factory NotiResponse.fromJson(Map<String, dynamic> json) {
    NotiResponse ret = NotiResponse(
      notificationId: json['notificationId'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      notificationType: json['notificationType'],
      title: json['title'],
      content: json['content'] ?? "", // null이면 빈 문자열로 처리
      imageUrl: json['imageUrl'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
    );
    return ret;
    // return NotiResponse(
    //   notificationId: json['notificationId'],
    //   senderId: json['senderId'],
    //   senderName: json['senderName'],
    //   notificationType: json['notificationType'],
    //   title: json['title'],
    //   content: json['content'] ?? "", // null이면 빈 문자열로 처리
    //   imageUrl: json['imageUrl'],
    //   isRead: json['isRead'],
    //   createdAt: DateTime.parse(json['createdAt']),
    // );
  }
}

extension NotificationToNotificationResponse on Noti {
  NotiResponse toNotificationResponse() {
    return NotiResponse(
      notificationId: notificationId,
      senderId: senderId,
      senderName: senderName,
      notificationType: notificationType,
      title: title,
      content: content,
      imageUrl: imageUrl,
      isRead: isRead,
      createdAt: createdAt,
    );
  }
}

extension NotificationResponseToNotification on NotiResponse {
  Noti toNotification() {
    return Noti(
      notificationId: notificationId,
      senderId: senderId,
      senderName: senderName,
      notificationType: notificationType,
      title: title,
      content: content,
      imageUrl: imageUrl,
      isRead: isRead,
      createdAt: createdAt,
    );
  }
}
