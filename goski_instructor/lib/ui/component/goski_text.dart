import 'package:flutter/material.dart';
import 'package:goski_instructor/const/color.dart';

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
      return Expanded(
        child: Text(
            style: TextStyle(
                color: color,
                fontSize: size,
                fontWeight: isBold ? FontWeight.w400 : FontWeight.w700
            ),
            text
        ),
      );
    } else {
      return Text(
          style: TextStyle(
              color: color,
              fontSize: size,
              fontWeight: isBold ? FontWeight.w400 : FontWeight.w700
          ),
          text
      );
    }
  }
}
