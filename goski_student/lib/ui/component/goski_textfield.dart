import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';

import '../../const/font_size.dart';
import '../../const/util/screen_size_controller.dart';
import '../../const/util/text_formatter.dart';

/// width를 0으로 입력시 expanded된 textField 생성 가능
/// textEditingController에는 TextEditingController() 사용하면 됨
class GoskiTextField extends StatelessWidget {
  final double width;
  final bool canEdit, hasInnerPadding, isDigitOnly;
  final int? maxLines, minLines;
  final String text, hintText;
  final TextAlign textAlign;
  final void Function(String) onTextChange;
  final TextEditingController textEditingController = TextEditingController();

  GoskiTextField({
    super.key,
    this.width = 0,
    this.canEdit = true,
    this.maxLines = 1,
    this.minLines,
    this.text = '',
    required this.hintText,
    this.hasInnerPadding = true,
    this.isDigitOnly = false,
    this.textAlign = TextAlign.start,
    required this.onTextChange,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final padding = screenSizeController.getWidthByRatio(0.02);

    return Container(
      width: width == 0 ? double.infinity : width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: canEdit ? goskiWhite : goskiLightGray,
          border: Border.all(width: 1, color: goskiDarkGray),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        textAlign: textAlign,
        readOnly: !canEdit,
        controller: textEditingController,
        onChanged: onTextChange,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              color: goskiDarkGray,
              fontSize: goskiFontMedium,
              fontWeight: FontWeight.w400),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.all(hasInnerPadding ? 5 : 0),
        ),
        style: const TextStyle(
            color: goskiBlack,
            fontSize: goskiFontMedium,
            fontWeight: FontWeight.w400),
        cursorColor: goskiBlack,
        maxLines: maxLines,
        inputFormatters: isDigitOnly ? [
          FilteringTextInputFormatter.digitsOnly,
          TextFormatter(),
        ] : [],
        keyboardType: isDigitOnly ? TextInputType.number : TextInputType.text,
        minLines: minLines,
      ),
    );
  }
}