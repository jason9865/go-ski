import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/main.dart';

class GoskiBorderWhiteContainer extends StatelessWidget {
  final Widget? child;

  const GoskiBorderWhiteContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final padding = screenSizeController.getWidthByRatio(0.02);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: goskiWhite,
        border: Border.all(width: 1, color: goskiDarkGray),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}