import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class GoskiDifficultySwitch extends StatefulWidget {
  final Function(String) onSelected;

  const GoskiDifficultySwitch({
    super.key,
    required this.onSelected,
  });

  @override
  _DifficultySwitchState createState() => _DifficultySwitchState();
}

class _DifficultySwitchState extends State<GoskiDifficultySwitch> {
  final List<String> difficulties = ['beginner', 'intermediate', 'advanced'];
  final List<String> difficultiesDescription = [
    'beginnerDescription',
    'intermediateDescription',
    'advancedDescription'
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(difficulties.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ChoiceChip(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                labelPadding: EdgeInsets.zero,
                backgroundColor:
                    selectedIndex == index ? goskiButtonBlack : goskiWhite,
                label: Container(
                  width: double.infinity,
                  height: 60,
                  alignment: AlignmentDirectional.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GoskiText(
                        text: tr(difficulties[index]),
                        size: goskiFontLarge,
                        color: selectedIndex == index ? goskiWhite : goskiBlack,
                      ),
                      GoskiText(
                        text: tr(difficultiesDescription[index]),
                        size: goskiFontMedium,
                        color:
                            selectedIndex == index ? goskiWhite : goskiDarkGray,
                      )
                    ],
                  ),
                ),
                selected: selectedIndex == index,
                onSelected: (bool selected) {
                  setState(() {
                    selectedIndex = selected ? index : selectedIndex;
                    widget.onSelected(difficulties[selectedIndex]);
                  });
                },
                selectedColor: goskiButtonBlack,
                showCheckmark: false,
                // 선택시 체크 표시 비활성화
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                )),
          );
        }));
  }
}
