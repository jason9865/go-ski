import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

import '../../const/util/screen_size_controller.dart';

class CertificateBottomSheet extends StatelessWidget {
  final GestureTapCallback? onClicked;

  const CertificateBottomSheet({super.key, this.onClicked});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final padding = screenSizeController.getWidthByRatio(0.01);
    List<String> certificateList = [
      tr('level1'),
      tr('level2'),
      tr('level3'),
      tr('teaching1'),
      tr('teaching2'),
      tr('teaching3'),
      tr('demonstrator')
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GoskiSwitch(
          items: [tr('ski'), tr('board')],
          width: screenSizeController.getWidthByRatio(0.7),
        ),
        SizedBox(
          height: screenSizeController.getHeightByRatio(0.02),
        ),
        GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: padding,
                crossAxisSpacing: padding,
                childAspectRatio: 1.0),
            itemCount: certificateList.length,
            itemBuilder: (context, index) {
              return GoskiCard(
                child: InkWell(
                  onTap: onClicked,
                  child: Container(
                    alignment: Alignment.center,
                    child: GoskiText(
                      text: certificateList[index],
                      size: 15,
                      isBold: true,
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
