import 'package:flutter/material.dart';
import 'package:goski_instructor/ui/component/custom_modal.dart';

// 헤더 오른쪽 아이콘들
Widget headerRightIcons(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: const Icon(Icons.notifications),
        // onPressed: () {
        //   // 알림 로직
        // },
        onPressed: () {
          // 설정 페이지로 이동하는 대신 모달을 표시
          showDialog(
            context: context,
            builder: (BuildContext context) => CustomModal(
              title: "외부 일정 등록",
              content: const Text("---컨텐츠 위젯---"),
              // 버튼 눌렀을 때 동작할 함수 추가 필요
              onConfirm: () => Navigator.of(context).pop(),
            ),
          );
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
