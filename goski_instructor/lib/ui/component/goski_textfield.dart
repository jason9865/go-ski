import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';

import '../../const/util/screen_size_controller.dart';

class GoskiTextfield extends StatefulWidget {
  final double width;
  final bool canEdit;
  final String text, hintText;

  const GoskiTextfield({
    super.key,
    required this.width,
    this.canEdit = true,
    this.text = '',
    this.hintText = '',
  });

  @override
  State<GoskiTextfield> createState() => _GoskiTextfieldState();
}

class _GoskiTextfieldState extends State<GoskiTextfield> {
  String inptText = '';
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final padding = screenSizeController.getWidthByRatio(0.02);

    if (!widget.canEdit) {
      _textEditingController.text = widget.text;
    }

    return Container(
      width: widget.width,
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
          hintStyle:  const TextStyle(
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
