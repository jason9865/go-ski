import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/view_model/notification_view_model.dart';

import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../const/util/screen_size_controller.dart';
import '../component/goski_smallsize_button.dart';
import '../component/goski_text.dart';

class NotificationSettingDialog extends StatefulWidget {
  const NotificationSettingDialog({
    super.key,
  });

  @override
  State<NotificationSettingDialog> createState() =>
      _NotificationSettingDialogState();
}

class _NotificationSettingDialogState extends State<NotificationSettingDialog> {
  final NotificationViewModel notificationViewModel =
      Get.find<NotificationViewModel>();
  final screenSizeController = Get.find<ScreenSizeController>();

  @override
  void initState() {
    super.initState();
    notificationViewModel.getNotificationSetting();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (notificationViewModel.notificationSettings.isEmpty) {
        return Container(
          color: goskiBackground,
          child: const Center(
            child: CircularProgressIndicator(
              color: goskiBlack,
            ),
          ),
        );
      }
      return Column(
        children: [
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: notificationViewModel.notificationSettings.length,
            itemBuilder: (context, index) {
              return NotificationSettingRow(
                  title: notificationTypeToString(notificationViewModel
                      .notificationSettings[index].notificationType),
                  isChecked:
                      notificationViewModel.notificationSettings[index].status,
                  onClicked: (value) {
                    setState(() {
                      notificationViewModel.notificationSettings[index].status =
                          value;
                    });
                  });
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: screenSizeController.getHeightByRatio(0.02),
              );
            },
          ),
          SizedBox(
            height: screenSizeController.getHeightByRatio(0.05),
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
                  notificationViewModel.updateNotificationSetting();
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
      );
    });
  }

  String notificationTypeToString(int notificationType) {
    return notificationType == 7
        ? tr('lessonReservationNotification')
        : notificationType == 8
            ? tr('feedbackNotification')
            : tr('messageNotification');
  }
}

class NotificationSettingRow extends StatelessWidget {
  final String title;
  final bool isChecked;
  final void Function(bool) onClicked;

  const NotificationSettingRow({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GoskiText(
            text: title,
            size: goskiFontLarge,
            isBold: true,
          ),
        ),
        SizedBox(
          width: screenSizeController.getHeightByRatio(0.06),
          height: screenSizeController.getHeightByRatio(0.045),
          child: FittedBox(
            fit: BoxFit.fill,
            child: Switch(
              value: isChecked,
              onChanged: (bool value) {
                onClicked(value);
              },
              activeTrackColor: goskiGreen,
            ),
          ),
        )
      ],
    );
  }
}
