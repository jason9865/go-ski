import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final screenSizeController = Get.find<ScreenSizeController>();
  final List<DummyNotification> list = [
    DummyNotification(title: tr('lessonReservationNotification'), isChecked: true),
    DummyNotification(title: tr('feedbackNotification'), isChecked: true),
    DummyNotification(title: tr('messageNotification'), isChecked: false),
  ];
  final List isCheckedList = [false, true, true];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return NotificationSettingRow(
                title: list[index].title,
                isChecked: list[index].isChecked,
                onClicked: (value) {
                  setState(() {
                    list[index].isChecked = value;
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
                Navigator.pop(context);
              },
            )
          ],
        )
      ],
    );
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

class DummyNotification {
  final String title;
  bool isChecked;

  DummyNotification({
    required this.title,
    required this.isChecked,
  });
}