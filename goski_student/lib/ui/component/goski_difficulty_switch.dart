import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_basic_info_container.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class GoskiDifficultySwitch extends StatefulWidget {
  final Function(String) onSelected;

  const GoskiDifficultySwitch({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  _DifficultySwitchState createState() => _DifficultySwitchState();
}

class _DifficultySwitchState extends State<GoskiDifficultySwitch> {
  final List<String> difficulties = [
    tr('beginner'),
    tr('intermediate'),
    tr('advanced')
  ];
  final List<String> difficultiesDescription = [
    tr('beginnerDescription'),
    tr('intermediateDescription'),
    tr('advancedDescription')
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(difficulties.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ChoiceChip(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                labelPadding: EdgeInsets.zero,
                backgroundColor:
                    selectedIndex == index ? goskiButtonBlack : goskiWhite,
                label: Container(
                  width: double.infinity,
                  height: 60,
                  alignment: AlignmentDirectional.center,
                  child: Column(
                    children: [
                      GoskiText(
                        text: tr(difficulties[index]),
                        size: goskiFontMedium,
                        color:
                        selectedIndex == index ? goskiWhite : goskiBlack,
                      ),
                      GoskiText(
                        text: tr(difficultiesDescription[index]),
                        size: goskiFontSmall,
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
