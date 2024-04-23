import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class CustomModal extends StatelessWidget {
  // 헤더에 들어갈 모달 제목
  final String title;
  // 내용들
  final Widget content;
  // 버튼 눌렀을 때 동작할 메서드, 있을 수도 있고 없을 수도 있음
  final VoidCallback? onConfirm;

  const CustomModal({
    super.key,
    required this.title,
    required this.content,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      // contentPadding: const EdgeInsets.all(5.0),
      insetPadding:
          EdgeInsets.all(screenSizeController.getHeightByRatio(0.023)),
      titlePadding: EdgeInsets.symmetric(
          vertical: screenSizeController.getHeightByRatio(0.01)),
      actionsPadding: EdgeInsets.symmetric(
          vertical: screenSizeController.getHeightByRatio(0.01)),
      backgroundColor: goskiBackground,
      title: SizedBox(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: screenSizeController.getHeightByRatio(0.01)),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(
              color: goskiDarkGray,
              thickness: 2,
            ),
          ],
        ),
      ),
      // titlePadding: const EdgeInsets.all(20),
      content: SizedBox(
        width: screenSizeController.getWidthByRatio(1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            content,
          ],
        ),
      ),
      actions: onConfirm != null
          ? <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 뒤로 가기
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('취소'),
                  ),
                  TextButton(
                    onPressed: onConfirm,
                    child: const Text('저장'),
                  ),
                ],
              ),
            ]
          : null,
    );
  }
}
