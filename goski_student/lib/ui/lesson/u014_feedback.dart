import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/view_model/feedback_view_model.dart';
import 'package:goski_student/view_model/lesson_list_view_model.dart';
import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart'; // getApplicationDocumentsDirectory 사용하려면 필요한 import

var logger = Logger();

class FeedbackScreen extends StatelessWidget {
  final lessonListViewModel = Get.find<LessonListViewModel>();
  final feedbackViewModel = Get.find<FeedbackViewModel>();

  FeedbackScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: GoskiSubHeader(
          title: tr('feedback'),
        ),
        body: GoskiContainer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                infoCard(context),
                const BuildInterval(),
                if (feedbackViewModel.feedback.value.images.isNotEmpty) ...[
                  imageListCard(),
                  const BuildInterval()
                ],
                if (feedbackViewModel.feedback.value.videos.isNotEmpty) ...[
                  videoListCard(),
                  const BuildInterval()
                ],
                feedbackTextCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoCard(BuildContext context) {
    var lesson = lessonListViewModel.selectedLesson;

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
                GoskiText(text: lesson.value.resortName, size: goskiFontLarge),
                const GoskiText(text: " - ", size: goskiFontLarge),
                GoskiText(text: lesson.value.teamName, size: goskiFontLarge),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoskiText(
                  text: tr(DateFormat('yyyy.MM.dd (E) HH:mm')
                      .format(lesson.value.startTime)
                      .toString()),
                  size: goskiFontMedium,
                  color: goskiDarkGray,
                ),
                GoskiText(
                  text: tr(DateFormat('~HH:mm')
                      .format(lesson.value.endTime)
                      .toString()),
                  size: goskiFontMedium,
                  color: goskiDarkGray,
                ),
              ],
            ),
            GoskiText(
              text: tr('dynamicInstructor', args: [
                lesson.value.instructorName == null
                    ? '이름 없음'
                    : lesson.value.instructorName!
              ]),
              size: goskiFontMedium,
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
                    text:
                        '${tr('feedbackImage')} (${feedbackViewModel.feedback.value.images.length})',
                    size: goskiFontLarge,
                    isExpanded: true,
                  ),
                  IconButton(
                      onPressed: () async {
                        String savedDir =
                            (await getApplicationDocumentsDirectory()).path;

                        for (var mediaData
                            in feedbackViewModel.feedback.value.images) {
                          feedbackViewModel.download(
                              mediaData.mediaUrl, savedDir);
                        }
                      },
                      icon: const Icon(Icons.file_download)),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: feedbackViewModel.feedback.value.images.map((image) {
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Image.network(
                      image.mediaUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
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
                    text:
                        '${tr('feedbackVideo')} (${feedbackViewModel.feedback.value.videos.length})',
                    size: goskiFontLarge,
                    isExpanded: true,
                  ),
                  IconButton(
                      onPressed: () async {
                        String savedDir = await ExternalPath
                            .getExternalStoragePublicDirectory(
                                ExternalPath.DIRECTORY_DOWNLOADS);

                        logger.d('savedDir : $savedDir');

                        for (var mediaData
                            in feedbackViewModel.feedback.value.videos) {
                          feedbackViewModel.download(
                              mediaData.mediaUrl, savedDir);
                        }
                      },
                      icon: const Icon(Icons.file_download)),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: feedbackViewModel.videoThumbnailList
                    .map(
                      (thumbnailPath) => Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.file(
                          File(thumbnailPath),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GoskiText(text: tr('feedback'), size: goskiFontLarge),
            SizedBox(
              height: screenSizeController.getHeightByRatio(0.02),
            ),
            GoskiText(
              text: tr(feedbackViewModel.feedback.value.content),
              size: goskiFontMedium,
            )
          ],
        ),
      ),
    );
  }
}
