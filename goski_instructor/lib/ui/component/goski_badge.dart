import 'package:flutter/material.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

class GoskiBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const GoskiBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.textColor = goskiWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: GoskiText(
        text: text,
        size: 12,
        color: textColor,
      ),
      padding:
          const EdgeInsets.all(0),
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      backgroundColor: backgroundColor,
      side: BorderSide.none,
    );
  }
}
