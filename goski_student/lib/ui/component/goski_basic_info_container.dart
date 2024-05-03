import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/component/goski_textfield.dart';

final screenSizeController = Get.find<ScreenSizeController>();

class BasicInfoContainer extends StatelessWidget {
  final String text;
  final String textField;

  const BasicInfoContainer({
    required this.text,
    required this.textField,
    super.key,
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
          onTextChange: (text) {
              // TODO: 로직 추가 필요
          },
        ),
      ],
    );
  }
}
