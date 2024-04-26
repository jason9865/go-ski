import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/ui/component/goski_textfield.dart';

import '../../const/util/screen_size_controller.dart';
import '../component/goski_smallsize_button.dart';
import '../component/goski_text.dart';
import 'd_i033_edit_team_member_info.dart';

class SetPricePeopleDialog extends StatelessWidget {
  const SetPricePeopleDialog({super.key});

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
            TitleAlignCenterWithInputRow(
              title: tr('one_one_price'),
              titleRatio: titleRatio,
              fontSize: titleFontSize,
              child: GoskiTextField(
                hintText: tr('enterPrice'),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: padding,
            ),
            TitleAlignCenterWithInputRow(
              title: tr('one_two_price'),
              titleRatio: titleRatio,
              fontSize: titleFontSize,
              child: GoskiTextField(
                hintText: tr('enterPrice'),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: padding,
            ),
            TitleAlignCenterWithInputRow(
              title: tr('one_three_price'),
              titleRatio: titleRatio,
              fontSize: titleFontSize,
              child: GoskiTextField(
                hintText: tr('enterPrice'),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: padding,
            ),
            TitleAlignCenterWithInputRow(
              title: tr('one_four_price'),
              titleRatio: titleRatio,
              fontSize: titleFontSize,
              child: GoskiTextField(
                hintText: tr('enterPrice'),
                textAlign: TextAlign.center,
              ),
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
                            text: tr('one_n_price'),
                            size: titleFontSize,
                            isBold: true,
                          ),
                          GoskiText(
                            text: tr('(${tr('price_per_people')})'),
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
