import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

import '../../const/font_size.dart';
import '../../const/util/screen_size_controller.dart';
import 'goski_border_white_container.dart';

class GoskiDropdown extends StatefulWidget {
  final String hint;
  final List<String> list;
  final ValueChanged<dynamic>? onChanged;

  const GoskiDropdown({
    super.key,
    required this.hint,
    required this.list,
    this.onChanged,
  });

  @override
  State<GoskiDropdown> createState() => _GoskiDropdownState();
}

class _GoskiDropdownState extends State<GoskiDropdown> {
  final screenSizeController = Get.find<ScreenSizeController>();
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _link = LayerLink();
  double? _buttonWidth;
  String? _selected;

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
                                _selected = widget.list[index];
                                _tooltipController.toggle();
                                widget.onChanged?.call(index);
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
        child: GestureDetector(
          onTap: onShowDropdownButtonClicked,
          child: GoskiBorderWhiteContainer(
            child: Row(
              children: [
                Expanded(
                  child: GoskiText(
                    text: _selected == null ? widget.hint : _selected!,
                    size: goskiFontMedium,
                    color: _selected == null ? goskiDarkGray : goskiBlack,
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: animationDuration),
                  turns: _tooltipController.isShowing ? 0.5 : 0,
                  child: Icon(
                      size: screenSizeController.getWidthByRatio(0.06),
                      Icons.keyboard_arrow_down
                  ),
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
