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
                  Get.to(() => FeedbackScreen(
                        resortName: widget.resortName,
                        teamName: widget.teamName,
                        instructorName: widget.instructorName,
                        startTime: widget.startTime,
                        endTime: widget.endTime,
                        feedbackImages: [
                          "assets/images/person1.png",
                          "assets/images/person1.png",
                          "assets/images/person1.png",
                          "assets/images/person1.png",
                          "assets/images/person1.png"
                        ],
                        feedbackVideos: [
                          "assets/images/person2.png",
                          "assets/images/person2.png",
                          "assets/images/person2.png",
                          "assets/images/person2.png",
                          "assets/images/person2.png",
                          "assets/images/person2.png"
                        ],
                        feedbackText:
                            "홍길동님, 안녕하세요!\n 오늘 스키 강습을 담당했던 김싸피라고 합니다.우리가 오늘 함께 연습했던 기술들에 대해서 간단하게 설명드리고, 그에 대한 피드백을 전달드리고자 합니다.\n첫 번째로, '스노우플라우'는 스키의 앞부분을 서로 가깝게 하고 뒷부분을 벌려 스키가 'V'자 형태를 이루게 하는 기술입니다. 이를 통해 속도를 조절하고 정지할 수 있죠. 홍길동님은 이 기술에서 체중 이동을 잘 해내셨어요. 정말 잘하셨습니다!\n다음으로, '스노우 플라우 턴'은 스노우플라우 자세에서 방향을 전환하는 기술입니다. 이때 중요한 것은 스키 끝이 서로 너무 멀어지지 않게 조절하는 것인데, 여기서 조금 아쉬웠던 점이 있습니다. 앞으로 이 부분에 조금 더 신경을 써 주시면 좋겠습니다.\n마지막으로, '슈템턴'은 한쪽 스키의 끝을 들고 반대쪽 스키로 회전하는 기술입니다. 여기서는 발을 모으는 타이밍이 조금 맞지 않았어요. 이 기술은 타이밍이 중요하므로, 다음 강습에서는 이 부분을 좀 더 집중적으로 연습해 보도록 하겠습니다.\n 오늘 강습에 참여해 주셔서 정말 감사합니다. 스키를 타며 즐거운 시간을 보내셨기를 바라며, 봄바람이 살랑이는 이 좋은 계절에 더욱 멋진 스키 실력을 쌓아가시길 응원합니다. 다음 강습에서 또 만나요!\n 김싸피 드림",
                      ));
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
                            tr("잘생김")
                          ])
                        ],
                      ),
                    ),
                  ),
                ],
                GestureDetector(
                  onTap: () {
                    Get.to(() => FeedbackScreen(
                          resortName: widget.resortName,
                          teamName: widget.teamName,
                          instructorName: widget.instructorName,
                          startTime: widget.startTime,
                          endTime: widget.endTime,
                          feedbackImages: [
                            "assets/images/person1.png",
                            "assets/images/person1.png",
                            "assets/images/person1.png",
                            "assets/images/person1.png",
                            "assets/images/person1.png"
                          ],
                          feedbackVideos: [
                            "assets/images/person2.png",
                            "assets/images/person2.png",
                            "assets/images/person2.png",
                            "assets/images/person2.png",
                            "assets/images/person2.png",
                            "assets/images/person2.png"
                          ],
                          feedbackText:
                              "홍길동님, 안녕하세요!\n 오늘 스키 강습을 담당했던 김싸피라고 합니다.우리가 오늘 함께 연습했던 기술들에 대해서 간단하게 설명드리고, 그에 대한 피드백을 전달드리고자 합니다.\n첫 번째로, '스노우플라우'는 스키의 앞부분을 서로 가깝게 하고 뒷부분을 벌려 스키가 'V'자 형태를 이루게 하는 기술입니다. 이를 통해 속도를 조절하고 정지할 수 있죠. 홍길동님은 이 기술에서 체중 이동을 잘 해내셨어요. 정말 잘하셨습니다!\n다음으로, '스노우 플라우 턴'은 스노우플라우 자세에서 방향을 전환하는 기술입니다. 이때 중요한 것은 스키 끝이 서로 너무 멀어지지 않게 조절하는 것인데, 여기서 조금 아쉬웠던 점이 있습니다. 앞으로 이 부분에 조금 더 신경을 써 주시면 좋겠습니다.\n마지막으로, '슈템턴'은 한쪽 스키의 끝을 들고 반대쪽 스키로 회전하는 기술입니다. 여기서는 발을 모으는 타이밍이 조금 맞지 않았어요. 이 기술은 타이밍이 중요하므로, 다음 강습에서는 이 부분을 좀 더 집중적으로 연습해 보도록 하겠습니다.\n 오늘 강습에 참여해 주셔서 정말 감사합니다. 스키를 타며 즐거운 시간을 보내셨기를 바라며, 봄바람이 살랑이는 이 좋은 계절에 더욱 멋진 스키 실력을 쌓아가시길 응원합니다. 다음 강습에서 또 만나요!\n 김싸피 드림",
                        ));
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
                GoskiText(text: " - ", size: goskiFontLarge),
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
            if (onChanged != null) {
              onChanged(index + 1);
            }
          },
        );
      }),
    );
  }
}
