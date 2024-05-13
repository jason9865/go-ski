import 'package:flutter/material.dart';
import 'package:goski_instructor/const/color.dart';

class GoskiText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final bool isBold, isExpanded;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final int? maxLine;
  final TextOverflow? overflow;

  const GoskiText({
    super.key,
    required this.text,
    required this.size,
    this.color = goskiBlack,
    this.isBold = false,
    this.isExpanded = false,
    this.textAlign = TextAlign.start,
    this.textDecoration = TextDecoration.none,
    this.maxLine,
    this.overflow,
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
        maxLine: maxLine,
        overflow: overflow,
      ));
    } else {
      return GoskiTextBody(
        color: color,
        size: size,
        isBold: isBold,
        text: text,
        textAlign: textAlign,
        textDecoration: textDecoration,
        maxLine: maxLine,
        overflow: overflow,
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
  final int? maxLine;
  final TextOverflow? overflow;

  const GoskiTextBody({
    super.key,
    required this.color,
    required this.size,
    required this.isBold,
    required this.text,
    required this.textAlign,
    required this.textDecoration,
    this.maxLine,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      textScaleFactor: 1.0,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
        decoration: textDecoration,
      ),
      text,
      maxLines: maxLine,
      overflow: overflow,
    );
  }
}
