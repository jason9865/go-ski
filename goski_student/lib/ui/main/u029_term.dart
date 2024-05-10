import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

// TODO: 약관 페이지  추가 필요
class TermScreen extends StatelessWidget {
  const TermScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: GoskiSubHeader(title: tr('term')),
        body: Container(
          decoration: const BoxDecoration(
            color: goskiBackground,
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: GoskiText(
                    text: '약관 페이지',
                    size: goskiFontXXLarge,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
