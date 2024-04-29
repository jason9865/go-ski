import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/datetime_util.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_smallsize_button.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GoskiContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InviteNotification(),
        ],
      ),
    );
  }
}

class InviteNotification extends StatelessWidget {
  const InviteNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final horizontalPadding = screenSizeController.getWidthByRatio(0.03);
    final titlePadding = screenSizeController.getHeightByRatio(0.010);

    return GoskiCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: horizontalPadding,
                left: horizontalPadding,
                right: horizontalPadding),
            child: Row(
              children: [
                GoskiText(
                  // text: '2024/04/25 (목) 16:43',
                  text: DateTimeUtil.getDateTime(),
                  size: goskiFontMedium,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            height: screenSizeController.getHeightByRatio(0.02),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: horizontalPadding,
                left: horizontalPadding,
                right: horizontalPadding),
            child: Column(
              children: [
                SizedBox(height: titlePadding),
                Row(
                  children: [
                    GoskiText(
                      text: '고승민 스키교실에서 팀 초대 요청이 왔습니다',
                      size: goskiFontMedium,
                      isBold: true,
                    ),
                  ],
                ),
                SizedBox(height: titlePadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GoskiSmallsizeButton(
                      width: screenSizeController.getWidthByRatio(1),
                      height: screenSizeController.getHeightByRatio(0.04),
                      text: tr('reject'),
                      backgroundColor: goskiDarkPink,
                      onTap: () {

                      },
                    ),
                    GoskiSmallsizeButton(
                      width: screenSizeController.getWidthByRatio(1),
                      height: screenSizeController.getHeightByRatio(0.04),
                      text: tr('accept'),
                      backgroundColor: goskiGreen,
                      onTap: () {

                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum Notification {
  INVITE,
  LESSON_ADD,
  LESSON_CANCEL,
  LESSON_CHANGE,
  LESSON_PRE_ALARM,
  SETTLEMENT,
  MESSAGE,
}
