import 'package:flutter/material.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/ui/component/custom_modal.dart';
import 'package:goski_instructor/ui/component/goski_bottomsheet.dart';

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
              // 버튼 눌렀을 때 동작할 함수 추가 필요
              onConfirm: () => Navigator.of(context).pop(),
              buttonName: "저장",
              child: Container(
                decoration: const BoxDecoration(
                  color: goskiBlue,
                ),
                height: 500,
                child: const Center(
                    child: Text(
                  "컨텐츠",
                  style: TextStyle(fontSize: 50),
                )),
              ),
            ),
          );
        },
      ),
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          showGoskiBottomSheet(
            context: context,
            child: Container(
              decoration: const BoxDecoration(
                color: goskiDarkPink,
              ),
              height: 500,
              child: const Center(
                  child: Text(
                "컨텐츠",
                style: TextStyle(fontSize: 50),
              )),
            ),
          );
        },
      ),
    ],
  );
}
