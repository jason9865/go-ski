import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

import '../../const/util/screen_size_controller.dart';
import '../component/goski_border_white_container.dart';

class LessonDetailDialog extends StatelessWidget {
  final LessonDetailData data;

  const LessonDetailDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final titlePadding = screenSizeController.getHeightByRatio(0.005);
    final contentPadding = screenSizeController.getHeightByRatio(0.015);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GoskiText(
          text: tr('date'),
          size: goskiFontLarge,
          isBold: true,
        ),
        SizedBox(height: titlePadding),
        GoskiBorderWhiteContainer(
          child: GoskiText(
            text: data.date,
            size: goskiFontMedium,
          ),
        ),
        SizedBox(height: contentPadding),
        GoskiText(
          text: tr('location'),
          size: goskiFontLarge,
          isBold: true,
        ),
        SizedBox(height: titlePadding),
        GoskiBorderWhiteContainer(
          child: GoskiText(
            text: data.location,
            size: goskiFontMedium,
          ),
        ),
        SizedBox(height: contentPadding),
        GoskiText(
          text: tr('reservationPerson'),
          size: goskiFontLarge,
          isBold: true,
        ),
        SizedBox(height: titlePadding),
        GoskiBorderWhiteContainer(
          child: GoskiText(
            text: data.reservationPerson,
            size: goskiFontMedium,
          ),
        ),
        SizedBox(height: contentPadding),
        GoskiText(
          text: tr('studentInfo'),
          size: goskiFontLarge,
          isBold: true,
        ),
        SizedBox(height: titlePadding),
        GoskiBorderWhiteContainer(
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: screenSizeController.getHeightByRatio(0.25),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: data.studentInfo.length,
                  itemBuilder: (context, index) {
                    return BackgroundContainer(
                      title: GoskiText(
                        text: data.studentInfo[index][0],
                        size: goskiFontMedium,
                      ),
                      children: [
                        GoskiText(
                          text: data.studentInfo[index][1],
                          size: goskiFontMedium,
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: screenSizeController.getHeightByRatio(0.01),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: contentPadding),
        GoskiText(
          text: tr('requestMessage'),
          size: goskiFontLarge,
          isBold: true,
        ),
        SizedBox(height: titlePadding),
        GoskiBorderWhiteContainer(
          child: GoskiText(
            text: data.requestMessage,
            size: goskiFontMedium,
          ),
        ),
        SizedBox(height: contentPadding),
      ],
    );
  }
}

// 수강생 정보 카드 안 파란 배경 영역
class BackgroundContainer extends StatelessWidget {
  final Widget title;
  final List<Widget> children;

  const BackgroundContainer(
      {super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final padding = screenSizeController.getWidthByRatio(0.02);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding),
      decoration: BoxDecoration(
          color: goskiBackground, borderRadius: BorderRadius.circular(5)),
      child: ListTileTheme(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        minLeadingWidth: 0,
        dense: true,
        child: ExpansionTile(
          childrenPadding: EdgeInsets.only(
              bottom: screenSizeController.getWidthByRatio(0.03)),
          visualDensity: VisualDensity.compact,
          iconColor: goskiBlack,
          collapsedIconColor: goskiBlack,
          shape: const Border(),
          collapsedShape: const Border(),
          expandedAlignment: Alignment.centerLeft,
          title: title,
          children: children,
        ),
      ),
    );
  }
}

// TODO. 추후 삭제 필요 더미 DTO
class LessonDetailData {
  final String date, location, reservationPerson, requestMessage;
  final List studentInfo;

  LessonDetailData(
      {required this.date,
      required this.location,
      required this.reservationPerson,
      required this.requestMessage,
      required this.studentInfo});
}
