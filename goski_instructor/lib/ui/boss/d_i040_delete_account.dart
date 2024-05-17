import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

import '../../const/util/screen_size_controller.dart';
import '../component/goski_smallsize_button.dart';
import 'b_i021_send_my_account.dart';

class DeleteAccountDialog extends StatelessWidget {
  final Account dummyAccount; // TODO. 진짜 계좌 정보로 변경 필요

  const DeleteAccountDialog({
    super.key,
    required this.dummyAccount,
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
              text: tr('deleteAccountContent', args: [dummyAccount.bankName, dummyAccount.accountNumber]),
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
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                GoskiSmallsizeButton(
                  width: screenSizeController.getWidthByRatio(1),
                  text: tr('delete'),
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