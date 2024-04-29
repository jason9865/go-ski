import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';

class GoskiText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final bool isBold, isExpanded;
  final TextAlign textAlign;
  final TextDecoration textDecoration;

  const GoskiText({
    super.key,
    required this.text,
    required this.size,
    this.color = goskiBlack,
    this.isBold = false,
    this.isExpanded = false,
    this.textAlign = TextAlign.start,
    this.textDecoration = TextDecoration.none,
  });

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return Expanded(
          child: GoskiTextBody(
        color: color,
        size: size,
        isBold: isBold,
        text: text,
        textAlign: textAlign,
        textDecoration: textDecoration,
      ));
    } else {
      return GoskiTextBody(
        color: color,
        size: size,
        isBold: isBold,
        text: text,
        textAlign: textAlign,
        textDecoration: textDecoration,
      );
    }
  }
}

class GoskiTextBody extends StatelessWidget {
  final Color color;
  final double size;
  final bool isBold;
  final String text;
  final TextAlign textAlign;
  final TextDecoration textDecoration;

  const GoskiTextBody({
    super.key,
    required this.color,
    required this.size,
    required this.isBold,
    required this.text,
    required this.textAlign,
    required this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
        decoration: textDecoration,
      ),
      text,
    );
  }
}
