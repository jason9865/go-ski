import 'package:flutter/material.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

class GoskiBadge extends StatelessWidget {
  final String text;
  final Color color;

  const GoskiBadge({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: GoskiText(
        text : text,
        size: 12,
        color: goskiWhite,
      ),
    );
  }
}
