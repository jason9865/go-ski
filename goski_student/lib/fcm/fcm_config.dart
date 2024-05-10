import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:goski_student/data/data_source/user_service.dart';
import 'package:goski_student/firebase_options.dart';
import 'package:goski_student/view_model/notification_view_model.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
);
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final UserService userService = Get.find();
final NotificationViewModel notificationViewModel = Get.find();

Future<void> setFCM() async {
  // Handling background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Settings
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  androidNotiSet();

  logger.d('User granted permission: ${settings.authorizationStatus}');

  // Handling Foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    logger.d("알림 도착 ${message.data["title"]} ${message.data["content"]}");
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'high_importance_channel', 'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    if (Get.currentRoute == "/NotificationScreen") {
      notificationViewModel.getNotificationList();
    } else {
      notificationViewModel.hasUnread.value = true;
    }
    await flutterLocalNotificationsPlugin.show(0, '${message.data["title"]}',
        '${message.data["content"]}', notificationDetails,
        payload: 'item x');
  });

  // Send FCMToken to server
  String token = await FirebaseMessaging.instance.getToken() ?? '';
  logger.d("fcmToken : $token");
  userService.sendFCMTokenToServer(token);
}

Future<void> androidNotiSet() async {
  if (Platform.isAndroid) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
          'high_importance_channel', 'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  notificationViewModel.hasUnread.value = true;
  await flutterLocalNotificationsPlugin.show(0, '${message.data["title"]}',
      '${message.data["content"]}', notificationDetails,
      payload: 'item x');
  logger.d("Handling a background message: ${message.messageId}");
}
