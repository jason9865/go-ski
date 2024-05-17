import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';

final screenSizeController = Get.find<ScreenSizeController>();

class BuildInterval extends StatelessWidget {
  const BuildInterval({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenSizeController.getHeightByRatio(0.016),
    );
  }
}
