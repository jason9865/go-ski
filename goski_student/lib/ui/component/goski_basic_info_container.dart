import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/main.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/component/goski_textfield.dart';

class BasicInfoContainer extends StatelessWidget {
  final String text;
  final String textField;
  final void Function(String) onTextChange;

  const BasicInfoContainer({
    super.key,
    required this.text,
    required this.textField,
    required this.onTextChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GoskiText(
          text: tr(text),
          size: goskiFontLarge,
          isExpanded: true,
        ),
        GoskiTextField(
          width: screenSizeController.getWidthByRatio(0.6),
          hintText: tr(textField),
          onTextChange: onTextChange,
        ),
      ],
    );
  }
}
