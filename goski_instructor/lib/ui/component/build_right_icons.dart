import 'package:flutter/material.dart';

Widget buildRightIcons() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () {
          // 알림 로직
        },
      ),
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          // 설정 페이지로 이동
        },
      ),
    ],
  );
}
