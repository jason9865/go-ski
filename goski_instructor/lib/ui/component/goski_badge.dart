import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';

class GoskiBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor, textColor;

  const GoskiBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.textColor = goskiWhite,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final horizontalPadding = screenSizeController.getWidthByRatio(0.01);

    return Chip(
      label: GoskiText(
        text: text,
        size: goskiFontSmall,
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
