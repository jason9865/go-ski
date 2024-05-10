import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/font_size.dart';
import '../../const/util/screen_size_controller.dart';
import '../component/goski_smallsize_button.dart';
import '../component/goski_text.dart';

class ResignConfirmDialog extends StatelessWidget {
  final VoidCallback onCancel, onConfirm;

  const ResignConfirmDialog({
    super.key,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final padding = screenSizeController.getHeightByRatio(0.015);

    return Flexible(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: padding * 2,
            ),
            GoskiText(
              text: tr('deleteUserHint'),
              size: goskiFontLarge,
              isBold: true,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: padding * 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GoskiSmallsizeButton(
                  width: screenSizeController.getWidthByRatio(1),
                  text: tr('cancel'),
                  onTap: onCancel,
                ),
                GoskiSmallsizeButton(
                  width: screenSizeController.getWidthByRatio(1),
                  text: tr('resign'),
                  onTap: onConfirm,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
