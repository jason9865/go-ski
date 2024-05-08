import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/data/model/feedback_response.dart';
import 'package:goski_student/ui/component/goski_border_white_container.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class FeedbackScreen extends StatefulWidget {
  final String resortName;
  final String teamName;
  final String instructorName;
  final DateTime startTime;
  final DateTime endTime;
  final List<MediaData> feedbackImages;
  final List<MediaData> feedbackVideos;
  final String feedbackText;

  const FeedbackScreen({
    super.key,
    required this.resortName,
    required this.teamName,
    required this.instructorName,
    required this.startTime,
    required this.endTime,
    required this.feedbackImages,
    required this.feedbackVideos,
    required this.feedbackText,
  });

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoskiSubHeader(
        title: tr("feedback"),
      ),
      body: GoskiContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              infoCard(context),
              BuildInterval(),
              if (widget.feedbackImages.isNotEmpty) ...[
                imageListCard(),
                BuildInterval()
              ],
              if (widget.feedbackVideos.isNotEmpty) ...[
                videoListCard(),
                BuildInterval()
              ],
              feedbackTextCard(),
            ],
          ),
        ),
      ),
    );
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

  Widget imageListCard() {
    return GoskiCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GoskiText(
                    text: tr('feedbackImage'),
                    size: goskiFontLarge,
                    isExpanded: true,
                  ),
                  IconButton(onPressed: (){
                    // TODO. 이미지 전체 다운로드 기능
                    print("이미지 전체 다운로드");
                  }, icon: Icon(Icons.file_download)),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.feedbackImages
                    .map(
                      (image) => Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                          image.mediaUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget videoListCard() {
    // For the video thumbnails, you'll probably want to fetch the first frame or use a placeholder image
    return GoskiCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GoskiText(
                    text: tr('feedbackVideo'),
                    size: goskiFontLarge,
                    isExpanded: true,
                  ),
                  IconButton(onPressed: (){
                    // TODO. 동영상 전체 다운로드 기능
                    print("동영상 전체 다운로드");
                  }, icon: Icon(Icons.file_download)),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.feedbackVideos
                    .map(
                      (video) => Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.network(
                          video.mediaUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget feedbackTextCard() {
    return GoskiCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GoskiText(text: tr('feedback'), size: goskiFontLarge),
            GoskiBorderWhiteContainer(
              child: GoskiText(
                text: tr(widget.feedbackText),
                size: goskiFontMedium,
              ),
            )
          ],
        ),
      ),
    );
  }

// You can create methods to handle the downloading of images/videos and displaying a snackbar or alert when done
}
