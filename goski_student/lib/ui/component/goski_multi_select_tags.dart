import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';

class GoskiMultiSelectTags extends StatefulWidget {
  final List<String> tags;
  final List<bool> isSelected;

  const GoskiMultiSelectTags({
    super.key,
    required this.tags,
    required this.isSelected,
  });

  @override
  _MultiSelectTagsState createState() => _MultiSelectTagsState();
}

class _MultiSelectTagsState extends State<GoskiMultiSelectTags> {
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
          selected: widget.isSelected[index],
          onSelected: (bool selected) {
            setState(() {
              widget.isSelected[index] = selected;
            });
          },
          selectedColor: goskiButtonBlack,
          backgroundColor: widget.isSelected[index] ? goskiButtonBlack : goskiWhite,
          labelStyle: widget.isSelected[index]
              ? const TextStyle(color: goskiWhite)
              : const TextStyle(color: goskiBlack),
        );
      }),
    );
  }
}
