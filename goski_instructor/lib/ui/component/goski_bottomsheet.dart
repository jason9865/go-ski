import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';

import '../../const/util/screen_size_controller.dart';

/// 사용방법
/// 1. showGoskiBottomSheet을 원하는 곳에서 호출
/// 2. context 인자 전달
/// 3. child 인자에 내부 위젯을 전달.
void showGoskiBottomSheet({required BuildContext context, Widget? child}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return GoskiBottomSheet(child: child);
    },
    backgroundColor: goskiBackground,
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
    isDismissible: true,
    isScrollControlled: true,
    useSafeArea: true
  );
}

class GoskiBottomSheet extends StatelessWidget {
  final Widget? child;

  const GoskiBottomSheet({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final padding = screenSizeController.getWidthByRatio(0.03);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: padding, right: padding, top: padding),
      child: child,
    );
  }
}
