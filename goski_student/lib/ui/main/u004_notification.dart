import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/datetime_util.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_smallsize_button.dart';
import 'package:goski_student/ui/component/goski_text.dart';

import '../component/goski_modal.dart';
import 'd_u027_delete_notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<_DummyNotification> list = [
    _DummyNotification(
      type: Notification.INVITE,
      dateTime: DateTime.now(),
      teamName: '고승민 스키교실',
    ),
    _DummyNotification(
      type: Notification.LESSON_ADD,
      dateTime: DateTime.now(),
      title: '4월 25일 (목) 15:00 ~ 17:00\n강습이 예약되었습니다',
      content:
          '스키 1:2\n송준석 외 1명\n수강 종목 : 스키\n수강생 정보\n송준석, 170~179cm, 70~79kg\n최지찬, 170~179cm, 60~69kg',
    ),
    _DummyNotification(
      type: Notification.LESSON_CANCEL,
      dateTime: DateTime.now(),
      title: '4월 25일 (목) 15:00 ~ 17:00\n강습이 취소되었습니다',
      content:
          '스키 1:2\n송준석 외 1명\n수강 종목 : 스키\n수강생 정보\n송준석, 170~179cm, 70~79kg\n최지찬, 170~179cm, 60~69kg',
    ),
    _DummyNotification(
      type: Notification.MESSAGE,
      dateTime: DateTime.now(),
      title: 'OOO님에세 쪽지가 왔습니다',
      content: '안녕하세요!\n쪽지 내용입니다',
      imageUrl:
          'https://i.namu.wiki/i/YdF0mzBNYXPmpP7XhQ-gEo5I80Xtpwq6zu_L0phHbAjioCCyzj9OgmwER-5Fxjo73P7C9AyAtK6L2u4XQxc9fw.webp',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GoskiContainer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                _DummyNotification item = list[index];

                switch (item.type) {
                  case Notification.INVITE:
                    return InviteNotificationCard(
                      dateTime: DateTime.now(),
                      teamName: item.teamName,
                    );
                  case Notification.MESSAGE:
                    return MessageNotificationCard(
                      dateTime: DateTime.now(),
                      title: item.title,
                      content: item.content,
                      imageUrl: item.imageUrl,
                      isExpanded: item.isExpanded,
                      onExpandBtnClicked: () {
                        setState(() {
                          item.isExpanded = !item.isExpanded;
                        });
                      },
                      onItemDeleteClicked: () {
                        setState(() {
                          list.removeAt(index);
                        });
                      },
                    );
                  default:
                    return LessonNotificationCard(
                      dateTime: DateTime.now(),
                      title: item.title,
                      content: item.content,
                      isExpanded: item.isExpanded,
                      onExpandBtnClicked: () {
                        setState(() {
                          item.isExpanded = !item.isExpanded;
                        });
                      },
                      onItemDeleteClicked: () {
                        setState(() {
                          list.removeAt(index);
                        });
                      },
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 알림 카드 위젯
class NotificationCard extends StatelessWidget {
  final DateTime dateTime;
  final Widget? child;

  const NotificationCard({
    super.key,
    required this.dateTime,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final horizontalPadding = screenSizeController.getWidthByRatio(0.03);

    return GoskiCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: horizontalPadding,
              left: horizontalPadding,
              right: horizontalPadding,
            ),
            child: Row(
              children: [
                GoskiText(
                  text: DateTimeUtil.getDateTime(dateTime),
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
              right: horizontalPadding,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

/// 팀 초대 알림
class InviteNotificationCard extends StatelessWidget {
  final DateTime dateTime;
  final String teamName;

  const InviteNotificationCard({
    super.key,
    required this.dateTime,
    required this.teamName,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final titlePadding = screenSizeController.getHeightByRatio(0.010);

    return NotificationCard(
      dateTime: dateTime,
      child: Column(
        children: [
          SizedBox(height: titlePadding),
          Row(
            children: [
              GoskiText(
                text: '$teamName에서 팀 초대 요청이 왔습니다',
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
                onTap: () {},
              ),
              GoskiSmallsizeButton(
                width: screenSizeController.getWidthByRatio(1),
                height: screenSizeController.getHeightByRatio(0.04),
                text: tr('accept'),
                backgroundColor: goskiGreen,
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

/// 알림 확장 카드 위젯
class NotificationExpansionCard extends StatelessWidget {
  final DateTime dateTime;
  final bool isExpanded;
  final VoidCallback onExpandBtnClicked;
  final String title, content;
  final Widget? child;

  const NotificationExpansionCard({
    super.key,
    required this.dateTime,
    required this.isExpanded,
    required this.onExpandBtnClicked,
    required this.title,
    required this.content,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final horizontalPadding = screenSizeController.getWidthByRatio(0.03);
    const animationDuration = 200;

    return InkWell(
      onTap: onExpandBtnClicked,
      child: GoskiCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: horizontalPadding,
                left: horizontalPadding,
                right: horizontalPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GoskiText(
                    text: DateTimeUtil.getDateTime(dateTime),
                    size: goskiFontMedium,
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: animationDuration),
                    turns: isExpanded ? 0.5 : 0,
                    child: Icon(
                        size: screenSizeController.getWidthByRatio(0.06),
                        Icons.keyboard_arrow_down),
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
                right: horizontalPadding,
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

/// 강습 추가, 삭제, 변경, 30분 전 알림
class LessonNotificationCard extends StatelessWidget {
  final DateTime dateTime;
  final bool isExpanded;
  final VoidCallback onExpandBtnClicked, onItemDeleteClicked;
  final String title, content;

  const LessonNotificationCard({
    super.key,
    required this.dateTime,
    required this.isExpanded,
    required this.onExpandBtnClicked,
    required this.onItemDeleteClicked,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final titlePadding = screenSizeController.getHeightByRatio(0.010);
    const animationDuration = 200;

    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return GoskiModal(
              title: tr('deleteNotification'),
              child: DeleteNotificationDialog(
                onCancel: () => Navigator.pop(context),
                onConfirm: () {
                  onItemDeleteClicked();
                  Navigator.pop(context);
                },
              ),
            );
          },
        );
      },
      child: NotificationExpansionCard(
        dateTime: dateTime,
        isExpanded: isExpanded,
        onExpandBtnClicked: onExpandBtnClicked,
        title: title,
        content: content,
        child: Column(
          children: [
            SizedBox(height: titlePadding),
            Row(
              children: [
                GoskiText(
                  text: title,
                  size: goskiFontMedium,
                  isBold: true,
                ),
              ],
            ),
            SizedBox(height: titlePadding),
            AnimatedSize(
              duration: const Duration(milliseconds: animationDuration),
              child: Visibility(
                visible: isExpanded,
                replacement: SizedBox(
                  width: screenSizeController.getWidthByRatio(1),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GoskiText(
                          text: content,
                          size: goskiFontMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: titlePadding),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// 쪽지 알림
class MessageNotificationCard extends StatelessWidget {
  final DateTime dateTime;
  final bool isExpanded;
  final VoidCallback onExpandBtnClicked, onItemDeleteClicked;
  final String title, content;
  final String? imageUrl;

  const MessageNotificationCard({
    super.key,
    required this.dateTime,
    required this.isExpanded,
    required this.onExpandBtnClicked,
    required this.onItemDeleteClicked,
    required this.title,
    required this.content,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final titlePadding = screenSizeController.getHeightByRatio(0.010);
    const animationDuration = 200;
    final imageSize = screenSizeController.getHeightByRatio(0.2);

    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return GoskiModal(
              title: tr('deleteNotification'),
              child: DeleteNotificationDialog(
                onCancel: () => Navigator.pop(context),
                onConfirm: () {
                  onItemDeleteClicked();
                  Navigator.pop(context);
                },
              ),
            );
          },
        );
      },
      child: NotificationExpansionCard(
        dateTime: dateTime,
        isExpanded: isExpanded,
        onExpandBtnClicked: onExpandBtnClicked,
        title: title,
        content: content,
        child: Column(
          children: [
            SizedBox(height: titlePadding),
            Row(
              children: [
                GoskiText(
                  text: title,
                  size: goskiFontMedium,
                  isBold: true,
                ),
              ],
            ),
            SizedBox(height: titlePadding),
            AnimatedSize(
              duration: const Duration(milliseconds: animationDuration),
              child: Visibility(
                visible: isExpanded,
                replacement: SizedBox(
                  width: screenSizeController.getWidthByRatio(1),
                ),
                child: Column(
                  children: [
                    Visibility(
                      visible: imageUrl != null,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return GoskiModal(
                                title: tr('feedbackImage'),
                                child: Column(
                                  children: [
                                    Image.network(
                                        width: double.infinity, imageUrl!),
                                    SizedBox(
                                      height: screenSizeController
                                          .getHeightByRatio(0.025),
                                    ),
                                    GoskiSmallsizeButton(
                                      width: screenSizeController
                                          .getWidthByRatio(3),
                                      text: tr('confirm'),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Image.network(
                          width: imageSize,
                          height: imageSize,
                          fit: BoxFit.contain,
                          imageUrl != null ? imageUrl! : '',
                        ),
                      ),
                    ),
                    SizedBox(height: titlePadding),
                    Row(
                      children: [
                        GoskiText(
                          text: content,
                          size: goskiFontMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: titlePadding),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// TODO. 수강생 앱에 맞게 항목 변경 필요
enum Notification {
  INVITE,
  LESSON_ADD,
  LESSON_CANCEL,
  LESSON_CHANGE,
  LESSON_PRE_ALARM,
  SETTLEMENT,
  MESSAGE,
}

class _DummyNotification {
  final Notification type;
  final DateTime dateTime;
  final String teamName, title, content;
  final String? imageUrl;
  bool isExpanded = false;

  _DummyNotification({
    required this.type,
    required this.dateTime,
    this.teamName = '',
    this.title = '',
    this.content = '',
    this.imageUrl,
  });
}
