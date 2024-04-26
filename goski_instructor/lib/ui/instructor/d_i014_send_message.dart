import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/ui/component/goski_textfield.dart';
import 'package:goski_instructor/ui/instructor/d_i013_lesson_detail.dart';

import '../../const/util/screen_size_controller.dart';
import '../component/goski_smallsize_button.dart';

class SendMessageDialog extends StatefulWidget {
  const SendMessageDialog({super.key});

  @override
  State<SendMessageDialog> createState() => _SendMessageDialogState();
}

class _SendMessageDialogState extends State<SendMessageDialog> {
  bool hasImage = false;

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final titlePadding = screenSizeController.getHeightByRatio(0.005);
    final contentPadding = screenSizeController.getHeightByRatio(0.015);

    return Flexible(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          GoskiText(
            text: tr('title'),
            size: 20,
            isBold: true,
          ),
          SizedBox(height: titlePadding),
          GoskiTextField(
            hintText: tr('titleHint'),
          ),
          SizedBox(height: contentPadding),
          GoskiText(
            text: tr('content'),
            size: 20,
            isBold: true,
          ),
          SizedBox(height: titlePadding),
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: goskiWhite, borderRadius: BorderRadius.circular(10)),
              child: GoskiTextField(
                hintText: tr('contentHint'),
                maxLines: 10,
              ),
            ),
          ),
          SizedBox(height: contentPadding),
          GoskiText(
            text: tr('image'),
            size: 20,
            isBold: true,
          ),
          SizedBox(height: titlePadding),
          BorderWhiteContainer(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (hasImage) {
                      // TODO. 이미지 삭제 기능 추가 필요
                  } else {
                      // TODO. 이미지 선택 기능 추가 필요
                  };

                  hasImage = !hasImage;
                });
              },
              child: hasImage
                  ? Row(
                      children: [
                        Expanded(
                          child: GoskiText(
                            text: 'Goski_IMG_123412312.png', // TODO. 파일명으로 변경 필요
                            size: 15,
                          ),
                        ),
                        Icon(
                          size: 20,
                          Icons.cancel,
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/add_image.svg',
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            goskiDarkGray,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(
                          width: screenSizeController.getWidthByRatio(0.01),
                        ),
                        Expanded(
                          child: GoskiText(
                            text: tr('addImage'),
                            size: 15,
                            color: goskiDarkGray,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          SizedBox(height: contentPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GoskiSmallsizeButton(
                width: screenSizeController.getWidthByRatio(1),
                text: tr('cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              GoskiSmallsizeButton(
                width: screenSizeController.getWidthByRatio(1),
                text: tr('send'),
                onTap: () {
                  // TODO. 보내기 버튼 동작 추가 필요
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
