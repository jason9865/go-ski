import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/main.dart';

import '../../const/font_size.dart';
import '../component/goski_smallsize_button.dart';
import '../component/goski_text.dart';

class DeleteNotificationDialog extends StatelessWidget {
  final VoidCallback onCancel, onConfirm;

  const DeleteNotificationDialog({
    super.key,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
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
              text: tr('deleteNotificationConfirm'),
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
                  text: tr('delete'),
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
