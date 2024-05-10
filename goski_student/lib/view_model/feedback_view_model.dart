import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:goski_student/data/model/feedback_response.dart';
import 'package:goski_student/data/repository/feedback_repository.dart';
import 'package:logger/logger.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

var logger = Logger();

class FeedbackViewModel extends GetxController {
  final FeedbackRepository feedbackRepository = Get.find();
  final Rx<Feedback> feedback = Feedback(
    feedbackId: 0,
    content: '',
    images: <MediaData>[],
    videos: <MediaData>[],
  ).obs;
  final RxList<String> videoThumbnailList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  Future<void> getFeedback(int lessonId) async {
    Feedback? response = await feedbackRepository.getFeedback(lessonId);

    if (response != null) {
      feedback.value = response;

      for (MediaData mediaData in response.videos) {
        String thumbnailPath = (await VideoThumbnail.thumbnailFile(
          video: mediaData.mediaUrl,
          timeMs: 2000,
          quality: 100,
        ))!;

        videoThumbnailList.add(thumbnailPath);
      }

      logger.w(videoThumbnailList);
    }
  }

  void download(String url, String savedDir) async {
    await FlutterDownloader.enqueue(
      url: url,
      savedDir: savedDir,
      saveInPublicStorage: true,
    );
  }

  static void downloadCallback(String id, int status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }
}
