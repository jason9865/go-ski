import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_bigsize_button.dart';
import 'package:easy_localization/easy_localization.dart';

class GoskiContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onConfirm;
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
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenSizeController.getWidthByRatio(0.05),
      ),
      width: screenSizeController.getWidthByRatio(1),
      height: screenSizeController.getHeightByRatio(1), // 높이를 전체로 설정
      decoration: const BoxDecoration(color: goskiBackground),
      child: Column(
        children: [
          Expanded(child: child),
          SizedBox(
            height: screenSizeController.getHeightByRatio(0.01),
          ),
          onConfirm != null && buttonName != null
              ? Padding(
                  padding: EdgeInsets.only(
                    bottom: screenSizeController.getHeightByRatio(0.02),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GoskiBigsizeButton(
                        width: screenSizeController.getWidthByRatio(1),
                        text: tr("$buttonName"),
                        onTap: onConfirm!, // 콜백 함수 실행
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: screenSizeController.getHeightByRatio(0.02),
                ),
        ],
      ),
    );
  }
}
