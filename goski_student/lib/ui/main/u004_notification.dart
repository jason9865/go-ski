import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/datetime_util.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/data/model/notification.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_smallsize_button.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/lesson/u009_lesson_list.dart';
import 'package:goski_student/view_model/notification_view_model.dart';

import '../component/goski_modal.dart';
import 'd_u027_delete_notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationViewModel notificationViewModel =
      Get.find<NotificationViewModel>();

  @override
  void initState() {
    super.initState();
    notificationViewModel.getNotificationList();
    notificationViewModel.readAllNoti();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoskiSubHeader(title: tr('notification')),
      body: Obx(() {
        if (notificationViewModel.isLoading.value) {
          return Container(
            color: goskiBackground,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (notificationViewModel.notificationList.isEmpty) {
          return Container(
            color: goskiBackground,
            child: Center(
              child: GoskiText(
                text: tr('noNotificationIndicator'),
                size: goskiFontXLarge,
              ),
            ),
          );
        }
        return GoskiContainer(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: notificationViewModel.notificationList.length,
                    itemBuilder: (context, index) {
                      Noti item = notificationViewModel.notificationList[index];

                      switch (item.notificationType) {
                        case 8:
                          return FeedbackNotificationCard(
                              dateTime: item.createdAt,
                              title: item.title,
                              onItemDeleteClicked: () {
                                notificationViewModel
                                    .deleteNotification(item.notificationId);
                                setState(() {
                                  notificationViewModel.notificationList
                                      .removeAt(index);
                                });
                              });
                        case 9:
                          return MessageNotificationCard(
                            dateTime: item.createdAt,
                            title: item.senderName!,
                            subtitle: item.title,
                            content: item.content,
                            imageUrl: item.imageUrl,
                            isExpanded: item.isExpanded,
                            onExpandBtnClicked: () {
                              setState(() {
                                item.isExpanded = !item.isExpanded;
                              });
                            },
                            onItemDeleteClicked: () {
                              notificationViewModel
                                  .deleteNotification(item.notificationId);
                              setState(() {
                                notificationViewModel.notificationList
                                    .removeAt(index);
                              });
                            },
                          );
                        default:
                          return LessonNotificationCard(
                            dateTime: item.createdAt,
                            title: item.title,
                            content: item.content,
                            isExpanded: item.isExpanded,
                            onExpandBtnClicked: () {
                              setState(() {
                                item.isExpanded = !item.isExpanded;
                              });
                            },
                            onItemDeleteClicked: () {
                              notificationViewModel
                                  .deleteNotification(item.notificationId);
                              setState(() {
                                notificationViewModel.notificationList
                                    .removeAt(index);
                              });
                            },
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
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

/// 피드백 수신 알림
class FeedbackNotificationCard extends StatelessWidget {
  final DateTime dateTime;
  final String title;
  final VoidCallback onItemDeleteClicked;

  const FeedbackNotificationCard({
    super.key,
    required this.dateTime,
    required this.title,
    required this.onItemDeleteClicked,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final titlePadding = screenSizeController.getHeightByRatio(0.010);

    return GestureDetector(
      onTap: () => Get.off(() => const LessonListScreen()),
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
      child: NotificationCard(
        dateTime: dateTime,
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
          ],
        ),
      ),
    );
  }
}

/// 알림 확장 카드 위젯
class NotificationExpansionCard extends StatelessWidget {
  final DateTime dateTime;
  final bool isExpanded;
  final VoidCallback onExpandBtnClicked;
  final Widget? child;

  const NotificationExpansionCard({
    super.key,
    required this.dateTime,
    required this.isExpanded,
    required this.onExpandBtnClicked,
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

/// 강습 예약 완료 알림
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
                          text: parsingReservationNoti(content),
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

  String parsingReservationNoti(dynamic content) {
    Map<String, dynamic> data = jsonDecode(content);

    String inputLessonDate = data["lessonDate"];
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime dateTime = inputFormat.parse(inputLessonDate);
    DateFormat outputFormat = DateFormat('M월 d일', 'ko_KR');

    String lessonDate = outputFormat.format(dateTime);
    String lessonTime =
        "${data["lessonTime"].substring(0, 2)}시 ${data["lessonTime"].substring(3, 5)}분";
    String resortName = data["resortName"];
    String studentCount = data["studentCount"];
    String lessonType = data["lessonType"];

    return "$lessonDate $lessonTime $resortName\n1:$studentCount $lessonType 강습이 예약되었습니다.";
  }
}

/// 쪽지 알림
class MessageNotificationCard extends StatelessWidget {
  final DateTime dateTime;
  final bool isExpanded;
  final VoidCallback onExpandBtnClicked, onItemDeleteClicked;
  final String title, subtitle, content;
  final String? imageUrl;

  const MessageNotificationCard({
    super.key,
    required this.dateTime,
    required this.isExpanded,
    required this.onExpandBtnClicked,
    required this.onItemDeleteClicked,
    required this.title,
    required this.subtitle,
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
        child: Column(
          children: [
            SizedBox(height: titlePadding),
            Row(
              children: [
                GoskiText(
                  text: "$title 님으로부터 쪽지가 도착하였습니다.\n$subtitle",
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
