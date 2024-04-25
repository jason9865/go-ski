import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_badge.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

class GoskiInstructorCard extends StatelessWidget {
  final String position;
  final Color badgeColor;
  final String name;
  final String phoneNumber;
  final String imagePath;

  const GoskiInstructorCard(
      {super.key,
      this.imagePath = 'assets/images/penguin.png',
      required this.position,
      required this.badgeColor,
      required this.name,
      required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();

    return GoskiCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Image.asset(
                imagePath,
                width: 90,
                height: 90,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: screenSizeController.getWidthByRatio(0.03),
            ),
            Flexible(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GoskiText(
                                  text: tr('position'),
                                  size: bodyMedium,
                                  isBold: true),
                            ],
                          )),
                      GoskiBadge(
                          text: tr(position), backgroundColor: badgeColor),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoskiText(
                              text: tr('name'),
                              size: bodyMedium,
                              isBold: true,
                            ),
                          ],
                        ),
                      ),
                      GoskiText(text: tr(name), size: bodyMedium),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: GoskiText(
                          text: tr('phoneNumber'),
                          size: bodyMedium,
                          isBold: true,
                        ),
                      ),
                      GoskiText(text: tr(phoneNumber), size: bodyMedium),
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
