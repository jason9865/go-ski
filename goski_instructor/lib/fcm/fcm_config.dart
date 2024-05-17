import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/data/data_source/user_service.dart';
import 'package:goski_instructor/firebase_options.dart';
import 'package:goski_instructor/main.dart';
import 'package:goski_instructor/view_model/instructor_main_view_model.dart';
import 'package:goski_instructor/view_model/notification_view_model.dart';

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
final InstructorMainViewModel instructorMainViewModel = Get.find();

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

    late String title = '';
    if (message.data['notificationType'] == "2") {
      title = tr('lessonAdded');
      instructorMainViewModel.getScheduleList();
    } else if (message.data['notificationType'] == "3") {
      instructorMainViewModel.getScheduleList();
    }
    await flutterLocalNotificationsPlugin.show(
        0, title, '${message.data["title"]}', notificationDetails,
        payload: 'item x');
  });

  // Send FCMToken to server
  sendFCMTokenToServer();
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

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onNotificationTap,
    onDidReceiveBackgroundNotificationResponse: onNotificationTap,
  );
}

Future<void> sendFCMTokenToServer() async {
  String token = await FirebaseMessaging.instance.getToken() ?? '';
  logger.d("fcmToken : $token");
  userService.sendFCMTokenToServer(token);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // TODO: background일 때 localization 추가
  // const locales = [Locale('en'), Locale('ko')];
  // const localizationPath = 'assets/translations';
  // final currentLocale = await Devicelocale.currentLocale;

  // await EasyLocalization.ensureInitialized();
  // final controller = EasyLocalizationController(
  //   saveLocale: false,
  //   supportedLocales: locales,
  //   useOnlyLangCode: true,
  //   fallbackLocale: locales[0],
  //   useFallbackTranslations: true,
  //   path: localizationPath,
  //   onLoadError: (FlutterError e) {},
  //   assetLoader: const RootBundleAssetLoader(),
  // );

  // if (currentLocale != null) {
  //   await controller.setLocale(Locale(currentLocale.substring(0, 2)));
  // }

  // await controller.loadTranslations();
  // Localization.load(
  //   controller.locale,
  //   translations: controller.translations,
  //   fallbackTranslations: controller.fallbackTranslations,
  // );

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

  late String title = '';
  if (message.data['notificationType'] == "2") {
    title = tr('lessonAdded');
  }
  await flutterLocalNotificationsPlugin.show(
      0, title, '${message.data["title"]}', notificationDetails,
      payload: 'item x');

  logger.d("Handling a background message: ${message.messageId}");
}

void onNotificationTap(NotificationResponse notificationResponse) {
  Get.toNamed("/NotificationScreen");
}
