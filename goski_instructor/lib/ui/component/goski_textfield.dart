import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';

import '../../const/util/screen_size_controller.dart';

/// width를 0으로 입력시 expanded된 textField 생성 가능
class GoskiTextField extends StatefulWidget {
  final double width;
  final bool canEdit;
  final String text, hintText;

  const GoskiTextField({
    super.key,
    required this.width,
    this.canEdit = true,
    this.text = '',
    this.hintText = '',
  });

  @override
  State<GoskiTextField> createState() => _GoskiTextFieldState();
}

class _GoskiTextFieldState extends State<GoskiTextField> {
  String inptText = '';
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final padding = screenSizeController.getWidthByRatio(0.02);

    if (!widget.canEdit) {
      _textEditingController.text = widget.text;
    }

    return Container(
      width: widget.width == 0 ? double.infinity : widget.width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: widget.canEdit ? goskiWhite : goskiLightGray,
          border: Border.all(width: 1, color: goskiDarkGray),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        readOnly: !widget.canEdit,
        controller: _textEditingController,
        onChanged: (text) {
          setState(() {
            inptText = text;
          });
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              color: goskiDarkGray, fontSize: 15, fontWeight: FontWeight.w400),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.all(5),
        ),
        style: const TextStyle(
            color: goskiBlack, fontSize: 15, fontWeight: FontWeight.w400),
        cursorColor: goskiBlack,
      ),
    );
  }
}
