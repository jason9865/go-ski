import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';

class GoskiSwitch extends StatefulWidget {
  final List<String> items;
  final double width;
  final Function(int)? onToggle;

  const GoskiSwitch({
    super.key,
    required this.items,
    required this.width,
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
      // decoration: BoxDecoration(
      //     border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: List.generate(widget.items.length, (index) {
          return ChoiceChip(
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            backgroundColor:
                selectedIndex == index ? goskiButtonBlack : goskiWhite,
            label: Container(
              width: chipWidth,
              height: 40,
              alignment: AlignmentDirectional.center,
              child: Text(
                widget.items[index],
                style: selectedIndex == index
                    ? Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: goskiWhite)
                    : Theme.of(context).textTheme.bodyLarge,
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
            showCheckmark: false, // 선택시 체크 표시 비활성화
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
