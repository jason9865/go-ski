import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class CustomContainer extends StatelessWidget {
  // 내용들
  final Widget content;
  // 버튼 눌렀을 때 동작할 메서드, 있을 수도 있고 없을 수도 있음
  final VoidCallback? onConfirm;
  // 버튼 이름
  final String? buttonName;

  const CustomContainer({
    super.key,
    required this.content,
    this.onConfirm,
    this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();

    // 기능 함수와 버튼 이름이 들어오면 버튼 렌더링, 아니면 버튼 대신 공백 렌더링
    return onConfirm != null && buttonName != null
        ? SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: screenSizeController.getHeightByRatio(0.01),
              horizontal: screenSizeController.getWidthByRatio(0.03),
            ),
            child: Column(
              children: [
                content,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 버튼
                    TextButton(
                      onPressed: onConfirm,
                      child: Text("$buttonName"),
                    ),
                  ],
                ),
              ],
            ),
          )
        : SizedBox(
            width: screenSizeController.getWidthByRatio(1),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: screenSizeController.getHeightByRatio(0.01),
                horizontal: screenSizeController.getWidthByRatio(0.03),
              ),
              child: Column(
                children: [
                  content,
                  // 버튼이 없는 경우 공백 추가
                  SizedBox(
                    height: screenSizeController.getHeightByRatio(0.02),
                  )
                ],
              ),
            ),
          );
  }
}
