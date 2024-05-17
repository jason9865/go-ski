import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/font_size.dart';

import '../../const/util/screen_size_controller.dart';
import '../component/goski_smallsize_button.dart';
import '../component/goski_text.dart';
import '../component/goski_textfield.dart';

class SetPriceStepDialog extends StatelessWidget {
  const SetPriceStepDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final padding = screenSizeController.getHeightByRatio(0.015);
    const titleRatio = 4;
    const double titleFontSize = goskiFontLarge;

    return Flexible(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: titleRatio,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          GoskiText(
                            text: tr('intermediate'),
                            size: titleFontSize,
                            isBold: true,
                          ),
                          GoskiText(
                            text: tr('level2'),
                            size: goskiFontMedium,
                            isBold: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 10 - titleRatio,
                  child: GoskiTextField(
                    hintText: tr('enterAdditionalPrice'),
                    textAlign: TextAlign.center,
                    isDigitOnly: true,
                    onTextChange: (text) => 0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: padding,
            ),
            Row(
              children: [
                Expanded(
                  flex: titleRatio,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          GoskiText(
                            text: tr('advanced'),
                            size: titleFontSize,
                            isBold: true,
                          ),
                          GoskiText(
                            text: tr('level3'),
                            size: goskiFontMedium,
                            isBold: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 10 - titleRatio,
                  child: GoskiTextField(
                    hintText: tr('enterAdditionalPrice'),
                    textAlign: TextAlign.center,
                    isDigitOnly: true,
                    onTextChange: (text) => 0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: padding * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GoskiSmallsizeButton(
                  width: screenSizeController.getWidthByRatio(1),
                  text: tr('cancel'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                GoskiSmallsizeButton(
                  width: screenSizeController.getWidthByRatio(1),
                  text: tr('save'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
