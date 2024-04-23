import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';

class GoskiSwitch extends StatefulWidget {
  final List<String> items;
  final double width;

  const GoskiSwitch({Key? key, required this.items, required this.width})
      : super(key: key);

  @override
  _GoskiSwitchState createState() => _GoskiSwitchState();
}

class _GoskiSwitchState extends State<GoskiSwitch> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double chipWidth = widget.width / widget.items.length - 1;

    return Container(
      width: widget.width,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: List.generate(widget.items.length, (index) {
          return ChoiceChip(
              backgroundColor: selectedIndex == index ? buttonBlack : goskiWhite,
              label: Text(
                widget.items[index],
                style: selectedIndex == index ?
                Theme.of(context).textTheme.bodyLarge!.copyWith(color: goskiWhite) : Theme.of(context).textTheme.bodyLarge,
              ),
              selected: selectedIndex == index,
              onSelected: (bool selected) {
                setState(() {
                  selectedIndex = selected ? index : selectedIndex;
                });
              },
              selectedColor: buttonBlack,
              showCheckmark: false, // 선택시 체크 표시 비활성화
              shape: index == 0
                  ? RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              )
                  : index == widget.items.length - 1
                  ? RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              )
                  : RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            );
        }),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: GoskiSwitch(
          items: ['스키', '보드', '휴무'],
          width: 300,
          // width: 니가만든거(0.5, 0.5) -> 400, 400(Size객체),
        ),
      ),
    ),
  ));
}
