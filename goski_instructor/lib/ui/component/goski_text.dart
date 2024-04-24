import 'package:flutter/material.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:easy_localization/easy_localization.dart';

class GoskiText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final bool isBold, isExpanded;

  const GoskiText({
    super.key,
    required this.text,
    required this.size,
    this.color = goskiBlack,
    this.isBold = false,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return SizedBox(
        width: double.infinity,
        child:
            GoskiTextBody(color: color, size: size, isBold: isBold, text: text),
      );
    } else {
      return GoskiTextBody(
          color: color, size: size, isBold: isBold, text: text);
    }
  }
}

class GoskiTextBody extends StatelessWidget {
  const GoskiTextBody({
    super.key,
    required this.color,
    required this.size,
    required this.isBold,
    required this.text,
  });

  final Color color;
  final double size;
  final bool isBold;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: isBold ? FontWeight.w400 : FontWeight.w700),
      text,
    );
  }
}
