import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_bigsize_button.dart';
import 'package:logger/logger.dart';

/*
  ## 사용법
  ### content는 필수 parameter
  ### onConfirm && buttonName은 필수x, 근데 쓸거면 같이 써줘야 버튼 제대로 렌더링됨
  ### 버튼은 추후 customButton으로 수정
return CustomContainer(
      content: 컨테이너에 들어갈 컨텐츠(위젯)
      onConfirm: () => 버튼 눌렀을 때 동작할 함수,
      buttonName: "버튼 이름",
    );
*/

Logger logger = Logger();

class GoskiContainer extends StatelessWidget {
  // 내용들
  final Widget child;
  // 버튼 눌렀을 때 동작할 메서드, 있을 수도 있고 없을 수도 있음
  final VoidCallback? onConfirm;
  // 버튼 이름
  final String? buttonName;

  const GoskiContainer({
    super.key,
    required this.child,
    this.onConfirm,
    this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();

    // 기능 함수와 버튼 이름이 들어오면 버튼 렌더링, 아니면 버튼 대신 공백 렌더링
    return onConfirm != null && buttonName != null
        ? Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenSizeController.getWidthByRatio(0.05),
            ),
            width: screenSizeController.getWidthByRatio(1),
            height: screenSizeController.getHeightByRatio(1),
            decoration: const BoxDecoration(color: goskiBackground),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        child,
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSizeController.getHeightByRatio(0.01),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: screenSizeController.getHeightByRatio(0.02)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GoskiBigsizeButton(
                          width: screenSizeController.getWidthByRatio(0.9),
                          text: tr("signup"),
                          onTap: () => 0),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenSizeController.getWidthByRatio(0.05),
            ),
            decoration: const BoxDecoration(color: goskiBackground),
            width: screenSizeController.getWidthByRatio(1),
            height: screenSizeController.getHeightByRatio(1),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  child,
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
