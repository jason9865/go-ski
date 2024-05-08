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

  @override
  void onInit() {
    super.onInit();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  Future<void> getFeedback(int lessonId) async {
    Feedback? response = await feedbackRepository.getFeedback(lessonId);

    if (response != null) {
      var list = <String>[];

      for (MediaData mediaData in response.videos) {
        String thumbnailPath = (await VideoThumbnail.thumbnailFile(
          video: mediaData.mediaUrl,
          imageFormat: ImageFormat.WEBP,
          maxWidth: 100,
          maxHeight: 100,
          quality: 75,
        ))!;

        list.add(thumbnailPath);
      }

      logger.w(list);

      feedback.value = response;
      feedback.value.videoThumbnailList = list;
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
    print('======================================================================================');
    print('Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    print('======================================================================================');
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }
}
