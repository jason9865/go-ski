import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/image_picker_controller.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/ui/component/goski_textfield.dart';
import 'package:goski_instructor/ui/instructor/d_i013_lesson_detail.dart';
import 'package:image_picker/image_picker.dart';

import '../../const/util/screen_size_controller.dart';
import '../component/goski_modal.dart';
import '../component/goski_smallsize_button.dart';

class SendMessageDialog extends StatefulWidget {
  const SendMessageDialog({super.key});

  @override
  State<SendMessageDialog> createState() => _SendMessageDialogState();
}

class _SendMessageDialogState extends State<SendMessageDialog> {
  bool hasImage = false;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    final imagePickerController = Get.put(ImagePickerController());
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
            size: goskiFontLarge,
            isBold: true,
          ),
          SizedBox(height: titlePadding),
          GoskiTextField(
            hintText: tr('titleHint'),
          ),
          SizedBox(height: contentPadding),
          GoskiText(
            text: tr('content'),
            size: goskiFontLarge,
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
            size: goskiFontLarge,
            isBold: true,
          ),
          SizedBox(height: titlePadding),
          BorderWhiteContainer(
            child: GestureDetector(
              onTap: () async {
                if (hasImage) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return GoskiModal(
                          title: image != null ? image!.name : '이미지 오류',
                          child: Column(
                            children: [
                              Image.file(
                                File(image!.path),
                                width: double.infinity,
                              ),
                              SizedBox(height: screenSizeController.getHeightByRatio(0.025),),
                              GoskiSmallsizeButton(
                                width: screenSizeController.getWidthByRatio(3),
                                text: tr('confirm'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      });
                } else {
                  // 이미지 추가
                  image = await imagePickerController.getImage();
                  setState(() {
                    hasImage = !hasImage;
                  });
                }
              },
              child: hasImage
                  ? Row(
                      children: [
                        Expanded(
                          child: GoskiText(
                            text: image != null ? image!.name : '이미지 오류',
                            size: goskiFontMedium,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // 이미지 삭제
                            image = null;
                            setState(() {
                              hasImage = !hasImage;
                            });
                          },
                          child: const Icon(
                            size: goskiFontLarge,
                            Icons.cancel,
                          ),
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
                            size: goskiFontMedium,
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
