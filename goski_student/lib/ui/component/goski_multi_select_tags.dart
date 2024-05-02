import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';

class GoskiMultiSelectTags extends StatefulWidget {
  final List<String> tags;

  GoskiMultiSelectTags({required this.tags});

  @override
  _MultiSelectTagsState createState() => _MultiSelectTagsState();
}

class _MultiSelectTagsState extends State<GoskiMultiSelectTags> {
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = List<bool>.filled(widget.tags.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0, // gap between lines
      children: List<Widget>.generate(widget.tags.length, (int index) {
        return ChoiceChip(
          showCheckmark: false,
          padding: EdgeInsets.zero,
          label: Text(widget.tags[index]),
          selected: isSelected[index],
          onSelected: (bool selected) {
            setState(() {
              isSelected[index] = selected;
            });
          },
          selectedColor: goskiButtonBlack,
          backgroundColor: isSelected[index] ? goskiButtonBlack : goskiWhite,
          labelStyle: isSelected[index]
              ? TextStyle(color: goskiWhite)
              : TextStyle(color: goskiBlack),
        );
      }),
    );
  }
}
