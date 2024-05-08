import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class FeedbackViewModel extends GetxController {
  @override
  void onInit() {
    super.onInit();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  void download(String url, String savedDir) async {
    await FlutterDownloader.enqueue(
      url: url,
      savedDir: savedDir,
    );
  }

  static void downloadCallback(String id, int status, int progress) {
    logger.w(
        'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }
}
