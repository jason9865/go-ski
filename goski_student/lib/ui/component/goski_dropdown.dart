import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/main.dart';
import 'package:goski_student/ui/component/goski_border_white_container.dart';
import 'package:goski_student/ui/component/goski_text.dart';

import '../../const/font_size.dart';

class GoskiDropdown extends StatefulWidget {
  final String hint;
  final String? selected;
  final List<String> list;
  final void Function(int) onSelected;

  const GoskiDropdown({
    super.key,
    required this.hint,
    required this.list,
    this.selected,
    required this.onSelected,
  });

  @override
  State<GoskiDropdown> createState() => _GoskiDropdownState();
}

class _GoskiDropdownState extends State<GoskiDropdown> {
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _link = LayerLink();
  double? _buttonWidth;

  @override
  Widget build(BuildContext context) {
    const animationDuration = 200;

    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _tooltipController,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            link: _link,
            targetAnchor: Alignment.bottomLeft,
            child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                  width: _buttonWidth,
                  constraints: BoxConstraints(
                    maxHeight: screenSizeController.getHeightByRatio(0.3),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 5,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(
                          screenSizeController.getWidthByRatio(0.02)),
                      decoration: BoxDecoration(
                        color: goskiWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: widget.list.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                widget.onSelected(index);
                                _tooltipController.toggle();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenSizeController
                                      .getHeightByRatio(0.01)),
                              child: GoskiText(
                                text: widget.list[index],
                                size: goskiFontMedium,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height:
                                screenSizeController.getHeightByRatio(0.005),
                          );
                        },
                      ),
                    ),
                  ),
                )),
          );
        },
        child: GoskiBorderWhiteContainer(
          child: GestureDetector(
            onTap: onShowDropdownButtonClicked,
            child: Row(
              children: [
                Expanded(
                  child: GoskiText(
                    text: widget.selected!.isEmpty
                        ? widget.hint
                        : widget.selected!,
                    size: goskiFontMedium,
                    color:
                        widget.selected!.isEmpty ? goskiDarkGray : goskiBlack,
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: animationDuration),
                  turns: _tooltipController.isShowing ? 0.5 : 0,
                  child: Icon(
                      size: screenSizeController.getWidthByRatio(0.06),
                      Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onShowDropdownButtonClicked() {
    setState(() {
      _buttonWidth = context.size?.width;
      _tooltipController.toggle();
    });
  }
}
