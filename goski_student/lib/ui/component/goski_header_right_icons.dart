import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/ui/component/goski_modal.dart';
import 'package:goski_student/ui/component/goski_bottomsheet.dart';
import 'package:goski_student/ui/main/u004_notification.dart';
import 'package:goski_student/ui/main/u005_setting.dart';

// 헤더 오른쪽 아이콘들
Widget headerRightIcons(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () {
          Get.to(() => const NotificationScreen());
        },
      ),
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          Get.to(() => SettingScreen());
        },
      ),
    ],
  );
}
