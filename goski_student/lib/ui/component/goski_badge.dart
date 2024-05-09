import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';

class GoskiBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor, textColor;
  final double font;

  const GoskiBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.textColor = goskiWhite,
    this.font = goskiFontSmall,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final horizontalPadding = screenSizeController.getWidthByRatio(0.01);

    return Chip(
      label: GoskiText(
        text: text,
        size: font,
        color: textColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      backgroundColor: backgroundColor,
      side: BorderSide.none,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
