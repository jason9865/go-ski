import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_smallsize_button.dart';

/// isLocalImage : 로컬 이미지 파일 가져와야 하는지 여부
/// imageUrl : 로컬 이미지인 경우 이미지 경로 입력, 네트워크 이미지의 경우 이미지 URL
class GoskiImageDialog extends StatelessWidget {
  final bool isLocalImage;
  final String imageUrl;

  const GoskiImageDialog({
    super.key,
    required this.isLocalImage,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();

    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: screenSizeController.getHeightByRatio(0.5),
          ),
          child: InteractiveViewer(
            child: isLocalImage
                ? Image.file(
                    File(imageUrl),
                    width: double.infinity,
                  )
                : Image.network(
                    width: double.infinity,
                    imageUrl,
                  ),
          ),
        ),
        SizedBox(
          height: screenSizeController.getHeightByRatio(0.025),
        ),
        GoskiSmallsizeButton(
          width: screenSizeController.getWidthByRatio(3),
          text: tr('confirm'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
