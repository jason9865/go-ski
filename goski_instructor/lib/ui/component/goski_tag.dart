import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';

import 'goski_text.dart';

class GoskiTag extends StatefulWidget {
  final String text;
  final Color textColor,
      backgroundColor,
      borderColor,
      selectedTextColor,
      selectedBackgroundColor;
  final bool isRound, hasBorder;
  final bool isSelected;
  final void Function(bool)? onClicked;

  GoskiTag({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    this.borderColor = Colors.transparent,
    required this.selectedTextColor,
    required this.selectedBackgroundColor,
    this.isRound = true,
    required this.isSelected,
    required this.hasBorder,
    this.onClicked
  });

  @override
  State<GoskiTag> createState() => _GoskiTagState();
}

class _GoskiTagState extends State<GoskiTag> {
  bool isSelected = false; // TODO. 추후에 삭제 필요, 대신 onClicked 사용

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final horizontalPadding = screenSizeController.getWidthByRatio(0.02);

    return ChoiceChip(
      label: GoskiText(
        text: widget.text,
        size: 12,
        color: isSelected ? widget.selectedTextColor : widget.textColor,
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          isSelected = selected;
        });

        if (widget.onClicked != null) {
          setState(() {
            widget.onClicked!(selected);
          });
        }
      },
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(widget.isRound ? 500 : 8))),
      backgroundColor: widget.backgroundColor,
      selectedColor: widget.selectedBackgroundColor,
      side: BorderSide(
        color: isSelected ? Colors.transparent : widget.borderColor,
        width: 1,
      ),
      showCheckmark: false,
    );
  }
}
