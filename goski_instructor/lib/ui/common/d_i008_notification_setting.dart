import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/ui/component/goski_smallsize_button.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

import '../../const/util/screen_size_controller.dart';

class NotificationSettingDialog extends StatefulWidget {
  final int role; // 1은 강사, 2는 사장으로 가정

  const NotificationSettingDialog({
    super.key,
    required this.role,
  });

  @override
  State<NotificationSettingDialog> createState() =>
      _NotificationSettingDialogState();
}

class _NotificationSettingDialogState extends State<NotificationSettingDialog> {
  final screenSizeController = Get.find<ScreenSizeController>();
  final List instructorList = [
    tr('inviteTeamNotification'),
    tr('lessonReservationNotification'),
    tr('lessonCancelNotification'),
    tr('lessonChangeNotification'),
    tr('lessonBeforeHourNotification'),
    tr('lessonBeforeHalfAnHourNotification'),
  ];
  final List instructorIsCheckedList = [false, true, true, false, false, true];
  final List bossList = [
    tr('lessonReservationNotification'),
    tr('lessonCancelNotification'),
    tr('lessonChangeNotification'),
    tr('lessonCompleteNotification'),
  ];
  final List bossIsCheckedList = [false, true, true, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: widget.role == 1 ? instructorList.length : bossList.length,
          itemBuilder: (context, index) {
            return NotificationSettingRow(
                title:
                    widget.role == 1 ? instructorList[index] : bossList[index],
                isChecked: widget.role == 1
                    ? instructorIsCheckedList[index]
                    : bossIsCheckedList[index],
                onClicked: (value) {
                  setState(() {
                    widget.role == 1
                        ? instructorIsCheckedList[index] = value
                        : bossIsCheckedList[index] = value;
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
            size: 20,
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
