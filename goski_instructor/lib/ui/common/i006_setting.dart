import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: goskiBackground,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SettingTitle(
                      title: tr('notification'),
                    ),
                    SettingContent(
                      content: tr('notificationSetting'),
                      onConfirm: () => logger.d("알림 설정"),
                    ),
                    SettingTitle(
                      title: tr('userInfo'),
                    ),
                    SettingContent(
                      content: tr('updateUserInfo'),
                      onConfirm: () => logger.d("개인 정보 수정"),
                    ),
                    buildDivider(),
                    SettingContent(
                      content: tr('logout'),
                      onConfirm: () => logger.d("록아웃"),
                    ),
                    SettingTitle(
                      title: tr('etc'),
                    ),
                    SettingContent(
                      content: tr('term'),
                      onConfirm: () => logger.d("약관"),
                    ),
                    buildDivider(),
                    SettingContent(
                      content: tr('guide'),
                      onConfirm: () => logger.d("도움말"),
                    ),
                    buildDivider(),
                    SettingContent(
                      content: tr('askTeamRegistration'),
                      onConfirm: () => logger.d("팀 등록 문의"),
                    ),
                    buildDivider(),
                    SettingContent(
                      content: tr('askAdvertisement'),
                      onConfirm: () => logger.d("광고 문의"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            decoration: const BoxDecoration(
              color: goskiWhite,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(
                      screenSizeController.getWidthByRatio(0.03)),
                  child: GoskiText(
                    text: tr('deleteUser'),
                    size: goskiFontMedium,
                    color: goskiDarkGray,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return const Divider(
      thickness: 1,
      height: 0,
    );
  }
}

class SettingContent extends StatelessWidget {
  final String content;
  final VoidCallback? onConfirm;
  const SettingContent({
    required this.content,
    required this.onConfirm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onConfirm,
      child: Container(
        decoration: const BoxDecoration(
          color: goskiWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.all(screenSizeController.getWidthByRatio(0.03)),
              child: GoskiText(
                text: tr(content),
                size: goskiFontMedium,
                color: goskiBlack,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingTitle extends StatelessWidget {
  final String title;
  const SettingTitle({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(screenSizeController.getWidthByRatio(0.03)),
          child: GoskiText(
            text: tr(title),
            size: goskiFontMedium,
            color: goskiDarkGray,
          ),
        )
      ],
    );
  }
}
