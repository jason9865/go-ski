import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/common/d_i018_add_external_schedule.dart';
import 'package:goski_instructor/ui/component/goski_bottomsheet.dart';
import 'package:goski_instructor/ui/component/goski_build_interval.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_smallsize_button.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/ui/component/goski_textfield.dart';
import 'package:logger/logger.dart';

import '../component/goski_border_white_container.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class RegisterAccountScreen extends StatelessWidget {
  const RegisterAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GoskiContainer(
      buttonName: tr('register'),
      onConfirm: () => logger.d("계좌 등록"),
      child: Column(
        children: [
          SizedBox(
            height: screenSizeController.getHeightByRatio(0.2),
          ),
          GoskiCard(
            child: Padding(
              padding:
                  EdgeInsets.all(screenSizeController.getHeightByRatio(0.02)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical:
                              screenSizeController.getHeightByRatio(0.015),
                        ),
                        child: GoskiText(
                          text: tr('inputAccountInfo'),
                          size: goskiFontLarge,
                          isBold: true,
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: screenSizeController.getWidthByRatio(0.8),
                    child: GoskiBorderWhiteContainer(
                      child: TextWithIconRow(
                        text: tr('selectBank'),
                        icon: Icons.keyboard_arrow_down,
                        onClicked: () => showGoskiBottomSheet(
                          context: context,
                          child: const SizedBox(
                            height: 300,
                            child: Center(
                              child: Text('바텀시트'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const BuildInterval(),
                  GoskiTextField(
                    hintText: tr('enterAccountHolder'),
                    onTextChange: (text) => 0,
                  ),
                  const BuildInterval(),
                  GoskiTextField(
                    hintText: tr('enterAccountNumber'),
                    onTextChange: (text) => 0,
                  ),
                  const BuildInterval(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GoskiSmallsizeButton(
                        width: screenSizeController.getWidthByRatio(0.8),
                        text: tr('계좌 확인'),
                        onTap: () => showGoskiBottomSheet(
                          context: context,
                          child: const SizedBox(
                            height: 300,
                            child: Center(
                              child: Text('바텀시트'),
                            ),
                          ),
                        ),
                        textSize: goskiFontMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
