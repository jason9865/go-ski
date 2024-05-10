import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_badge.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class GoskiInstructorCard extends StatelessWidget {
  final String position;
  final Color badgeColor;
  final String name;
  final String description;
  final String imagePath;
  final double badgeFont;

  const GoskiInstructorCard({
    super.key,
    this.imagePath = 'assets/images/penguin.png',
    required this.position,
    required this.badgeColor,
    required this.name,
    required this.description,
    this.badgeFont = goskiFontSmall,
  });

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
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: Image.network(
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
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GoskiText(
                                text: tr('position'),
                                size: goskiFontMedium,
                              ),
                            ],
                          )),
                      GoskiBadge(
                        text: tr(position),
                        backgroundColor: badgeColor,
                        font: badgeFont,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GoskiText(
                              text: tr('name'),
                              size: goskiFontMedium,
                            ),
                          ],
                        ),
                      ),
                      GoskiText(text: tr(name), size: goskiFontMedium),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 80,
                        child: GoskiText(
                          text: tr('selfIntroduction'),
                          size: goskiFontMedium,
                        ),
                      ),
                      Expanded(
                          child: GoskiText(
                              text: tr(description), size: goskiFontMedium)),
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
