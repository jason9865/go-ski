import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';

class GoskiSwitch extends StatefulWidget {
  final List<String> items;
  final double width;
  final double size;
  final Function(int)? onToggle;

  const GoskiSwitch({
    super.key,
    required this.items,
    required this.width,
    this.size = goskiFontMedium,
    this.onToggle,
  });

  @override
  _GoskiSwitchState createState() => _GoskiSwitchState();
}

class _GoskiSwitchState extends State<GoskiSwitch> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double chipWidth = widget.width / widget.items.length - 2;

    return SizedBox(
      width: widget.width,
      height: 40,
      child: Row(
        children: List.generate(widget.items.length, (index) {
          return ChoiceChip(
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            backgroundColor:
                selectedIndex == index ? goskiButtonBlack : goskiWhite,
            label: Container(
              width: chipWidth,
              alignment: Alignment.center,
              child: Text(
                widget.items[index],
                style: TextStyle(
                    fontSize: widget.size,
                    color: selectedIndex == index ? goskiWhite : goskiBlack),
              ),
            ),
            selected: selectedIndex == index,
            onSelected: (bool selected) {
              setState(() {
                selectedIndex = selected ? index : selectedIndex;
                if (widget.onToggle != null) {
                  widget.onToggle!(selectedIndex);
                }
              });
            },
            selectedColor: goskiButtonBlack,
            showCheckmark: false,
            // 선택시 체크 표시 비활성화
            shape: index == 0
                ? const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  )
                : index == widget.items.length - 1
                    ? const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      )
                    : const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
          );
        }),
      ),
    );
  }
}
