import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:logger/logger.dart';

/*
  ## 사용법
  ### title && content는 필수 parameter
  ### onConfirm && buttonName은 필수x, 근데 쓸거면 같이 써줘야 버튼 제대로 렌더링됨
  ### 버튼은 추후 customButton으로 수정
onPressed: () {
  showDialog(
    context = context,
    builder = (BuildContext context) => CustomModal(
      title: 모달 이름,
      content: 모달에 들어갈 컨텐츠(위젯)
      onConfirm: () => 함수 정의,
      buttonName: "버튼이름",
    ),
  );
};
*/

Logger logger = Logger();

class GoskiModal extends StatelessWidget {
  // 헤더에 들어갈 모달 제목
  final String title;
  // 내용들
  final Widget child;
  // 버튼 눌렀을 때 동작할 메서드, 있을 수도 있고 없을 수도 있음
  final VoidCallback? onConfirm;
  final String? buttonName;

  const GoskiModal({
    super.key,
    required this.title,
    required this.child,
    this.onConfirm,
    this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final double horizontalPadding = screenSizeController.getWidthByRatio(0.05);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      insetPadding:
          EdgeInsets.all(screenSizeController.getHeightByRatio(0.023)),
      titlePadding: EdgeInsets.symmetric(
          vertical: screenSizeController.getHeightByRatio(0.01)),
      actionsPadding: EdgeInsets.symmetric(
        vertical: screenSizeController.getHeightByRatio(0.02),
        horizontal: horizontalPadding,
      ),
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
            child,
          ],
        ),
      ),
      actions: onConfirm != null && buttonName != null
          ? <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 뒤로 가기
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('취소'),
                  ),
                ],
              ),
            ]
          : <Widget>[
              SizedBox(
                height: screenSizeController.getHeightByRatio(0.02),
              )
            ],
    );
  }
}
