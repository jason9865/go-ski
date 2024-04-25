import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/ui/component/goski_textfield.dart';

import '../../const/util/screen_size_controller.dart';
import '../component/goski_smallsize_button.dart';

class SendMessageDialog extends StatelessWidget {
  const SendMessageDialog({super.key});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GoskiText(
                text: tr('content'),
                size: 20,
                isBold: true,
              ),
              InkWell(
                onTap: () {
                  // TODO. 이미지 첨부하기 동작 추가 필요
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/add_image.svg',
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        goskiBlack,
                        BlendMode.srcIn,
                      ),
                    ),
                    GoskiText(
                      text: tr('addImage'),
                      size: 12,
                      isBold: true,
                    ),
                  ],
                ),
              )
            ],
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
