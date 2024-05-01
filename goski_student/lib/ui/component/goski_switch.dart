import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';

class GoskiSwitch extends StatefulWidget {
  final List<String> items;
  final double width;
  final Function(int)? onChanged;
  final double size;

  const GoskiSwitch({
    super.key,
    required this.items,
    required this.width,
    this.onChanged,
    this.size = goskiFontMedium,
  });

  @override
  _GoskiSwitchState createState() => _GoskiSwitchState();
}

class _GoskiSwitchState extends State<GoskiSwitch> {
  int selectedIndex = 0;

  void _handleSelection(int index) {
    if (selectedIndex != index) {
      setState(() {
        selectedIndex = index;
      });
      // Only call the callback if it is not null
      widget.onChanged?.call(index);
    }
  }

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
            backgroundColor: selectedIndex == index ? goskiBlack : goskiWhite,
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
            onSelected: (_) => _handleSelection(index),
            selectedColor: goskiBlack,
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(index == 0 ? 8 : 0),
                right:
                    Radius.circular(index == widget.items.length - 1 ? 8 : 0),
              ),
            ),
          );
        }),
      ),
    );
  }
}
