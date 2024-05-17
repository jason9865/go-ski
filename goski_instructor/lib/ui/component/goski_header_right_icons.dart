import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/ui/common/i005_notification.dart';
import 'package:goski_instructor/ui/common/i006_setting.dart';

// 헤더 오른쪽 아이콘들
Widget headerRightIcons(BuildContext context) {
  // final NotificationViewModel viewModel = Get.find<NotificationViewModel>();
  return Padding(
    padding: const EdgeInsets.only(right: 10.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                Get.to(() => const NotificationScreen());
              },
            ),
            // Obx(() => viewModel.hasUnread.value
            //     ? const Positioned(
            //         top: 10,
            //         right: 10,
            //         child: Icon(
            //           Icons.circle,
            //           color: goskiRed,
            //           size: 10,
            //         ),
            //       )
            //     : const SizedBox.shrink())
          ],
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Get.to(() => const SettingScreen());
          },
        ),
      ],
    ),
  );
}
