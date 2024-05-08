import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_multi_select_tags.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/component/goski_textfield.dart';
import 'package:goski_student/ui/lesson/u014_feedback.dart';

class ReviewScreen extends StatefulWidget {
  final String resortName;
  final String teamName;
  final String instructorName;
  final DateTime startTime;
  final DateTime endTime;

  const ReviewScreen({
    super.key,
    required this.resortName,
    required this.teamName,
    required this.instructorName,
    required this.startTime,
    required this.endTime,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _rating = 0;
  final imageWidth = screenSizeController.getWidthByRatio(0.5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GoskiSubHeader(
          title: tr('review'),
        ),
        body: GoskiContainer(
          buttonName: _rating > 0 ? tr('completed') : null,
          onConfirm: _rating > 0
              ? () {
                  Get.to(() => FeedbackScreen());
                }
              : null,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/penguin.png",
                  width: imageWidth,
                  height: imageWidth,
                  fit: BoxFit.fitHeight,
                ),
                infoCard(context),
                StarRating(
                  onChanged: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                  value: _rating,
                ),
                if (_rating > 0) ...[
                  GoskiCard(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GoskiText(
                            text: tr("lessonReview"),
                            size: goskiFontMedium,
                            isBold: true,
                          ),
                          GoskiTextField(
                            hintText: tr("리뷰 내용을 입력하세요."),
                            maxLines: 2,
                            onTextChange: (text) {
                              // TODO: 로직 추가 필요
                            },
                          ),
                          BuildInterval(),
                          GoskiText(
                            text: tr("instructorReview"),
                            size: goskiFontMedium,
                            isBold: true,
                          ),
                          GoskiMultiSelectTags(tags: [
                            tr("잘생김"),
                            tr("잘생김"),
                            tr("잘생김"),
                            tr("잘생김"),
                            tr("잘생김"),
                            tr("잘생김"),
                            tr("잘생김"),
                            tr("잘생김"),
                          ])
                        ],
                      ),
                    ),
                  ),
                ],
                GestureDetector(
                  onTap: () {
                    Get.to(() => FeedbackScreen());
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GoskiText(
                            text: "건너뛰기",
                            size: goskiFontXSmall,
                            color: goskiDarkGray,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget infoCard(BuildContext context) {
    return GoskiCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoskiText(text: widget.resortName, size: goskiFontLarge),
                const GoskiText(text: " - ", size: goskiFontLarge),
                GoskiText(text: widget.teamName, size: goskiFontLarge),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoskiText(
                  text: tr(DateFormat('yyyy.MM.dd (E) HH:mm')
                      .format(widget.startTime)
                      .toString()),
                  size: goskiFontSmall,
                  color: goskiDarkGray,
                ),
                GoskiText(
                  text: tr(
                      DateFormat('~HH:mm').format(widget.endTime).toString()),
                  size: goskiFontSmall,
                  color: goskiDarkGray,
                ),
              ],
            ),
            GoskiText(
              text: tr('dynamicInstructor', args: [widget.instructorName]),
              size: goskiFontSmall,
              color: goskiDarkGray,
            ),
          ],
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int value;
  final void Function(int) onChanged;

  StarRating({this.value = 0, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: Icon(
            index < value ? Icons.star : Icons.star_border,
          ),
          color: goskiYellow,
          iconSize: 40,
          onPressed: () {
            onChanged(index + 1);
          },
        );
      }),
    );
  }
}
