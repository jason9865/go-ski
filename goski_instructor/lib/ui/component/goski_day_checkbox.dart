import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

class DayCheckbox extends StatefulWidget {
  final String day;

  const DayCheckbox({
    super.key,
    required this.day,
  });

  @override
  State<DayCheckbox> createState() => _DayCheckboxState();
}

class _DayCheckboxState extends State<DayCheckbox> {
  bool isChecked = false; // 기본값은 false

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GoskiText(
          text: tr(widget.day),
          size: goskiFontMedium,
          isBold: true,
        ),
        Transform.translate(
          offset: const Offset(
              0.0, -10.0), // Checkbox가 기본적으로 차지하고 있는 padding이 있어서 수동으로 위치 조정
          child: Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value ?? isChecked;
              });
            },
            activeColor: goskiBlack,
          ),
        ),
      ],
    );
  }
}
