import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../const/util/image_picker_controller.dart';
import '../../const/util/screen_size_controller.dart';
import '../component/goski_border_white_container.dart';
import '../component/goski_modal.dart';
import '../component/goski_smallsize_button.dart';
import '../component/goski_text.dart';
import '../component/goski_textfield.dart';

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
      child: SingleChildScrollView(
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
              onTextChange: (text) {
                // TODO: 로직 추가 필요
              },
            ),
            SizedBox(height: contentPadding),
            GoskiText(
              text: tr('content'),
              size: goskiFontLarge,
              isBold: true,
            ),
            SizedBox(height: titlePadding),
            Container(
              width: double.infinity,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: goskiWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GoskiTextField(
                hintText: tr('contentHint'),
                maxLines: 10,
                onTextChange: (text) {
                  // TODO: 로직 추가 필요
                },
              ),
            ),
            SizedBox(height: contentPadding),
            GoskiText(
              text: tr('image'),
              size: goskiFontLarge,
              isBold: true,
            ),
            SizedBox(height: titlePadding),
            GoskiBorderWhiteContainer(
              child: GestureDetector(
                onTap: () async {
                  if (hasImage && image != null) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return GoskiModal(
                            title: image!.name.split('.')[0].length <= 15
                                ? image!.name
                                : '${image!.name.split('.')[0].substring(0, 14)}···.${image!.name.split('.')[1]}',
                            child: Column(
                              children: [
                                Image.file(
                                  File(image!.path),
                                  width: double.infinity,
                                ),
                                SizedBox(
                                  height: screenSizeController
                                      .getHeightByRatio(0.025),
                                ),
                                GoskiSmallsizeButton(
                                  width:
                                      screenSizeController.getWidthByRatio(3),
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
                      if (image != null) {
                        hasImage = !hasImage;
                      }
                    });
                  }
                },
                child: hasImage
                    ? Row(
                        children: [
                          Expanded(
                            child: GoskiText(
                              text: image!.name,
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
                            width: goskiFontLarge,
                            height: goskiFontLarge,
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
            SizedBox(height: contentPadding * 2),
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
      ),
    );
  }
}
