import 'package:flutter/material.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/main.dart';

import 'goski_text.dart';

// TODO. 라운드만 가지도록 변경
class GoskiTag extends StatelessWidget {
  final String text;
  final Color textColor,
      backgroundColor,
      borderColor,
      selectedTextColor,
      selectedBackgroundColor;
  final bool hasBorder;
  final bool isSelected;
  final void Function(bool)? onClicked;

  const GoskiTag({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    this.borderColor = Colors.transparent,
    required this.selectedTextColor,
    required this.selectedBackgroundColor,
    required this.isSelected,
    required this.hasBorder,
    this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = screenSizeController.getWidthByRatio(0.02);

    return ChoiceChip(
      label: GoskiText(
        text: text,
        size: goskiFontSmall,
        color: isSelected ? selectedTextColor : textColor,
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (onClicked != null) {
            onClicked!(selected);
        }
      },
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(500)),
      ),
      backgroundColor: backgroundColor,
      selectedColor: selectedBackgroundColor,
      side: BorderSide(
        color: isSelected ? Colors.transparent : borderColor,
        width: 1,
      ),
      showCheckmark: false,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
