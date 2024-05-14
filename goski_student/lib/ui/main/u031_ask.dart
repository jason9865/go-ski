import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/const/util/url_launch_util.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class AskScreen extends StatelessWidget {
  const AskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: GoskiSubHeader(title: tr('ask')),
        body: Container(
          decoration: const BoxDecoration(
            color: goskiBackground,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      style: const TextStyle(
                        height: 2,
                      ),
                      children: [
                        buildTitleText('고승민(사장)'),
                        buildEmailText('smink95@naver.com'),
                        buildTitleText('\n고정원'),
                        buildEmailText('7704wjddnjs@gmail.com'),
                        buildTitleText('\n송준석'),
                        buildEmailText('jswsn1526@naver.com'),
                        buildTitleText('\n임종율'),
                        buildEmailText('dlawhdfbf12@gmail.com'),
                        buildTitleText('\n장승호'),
                        buildEmailText('jsh09865@gmail.com'),
                        buildTitleText('\n최지찬'),
                        buildEmailText('pnlkc@naver.com'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  TextSpan buildTitleText(String text) {
    return TextSpan(
        text: '$text : ',
        style: const TextStyle(
          color: goskiBlack,
          fontSize: goskiFontLarge,
          fontFamily: 'Jua',
        ),
    );
  }

  TextSpan buildEmailText(String email) {
    return TextSpan(
        text: email,
        style: const TextStyle(
          color: goskiBlue,
          fontSize: goskiFontLarge,
          fontFamily: 'Jua',
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            UrlLaunchUtil.launch('mailto:$email');
          }
    );
  }
}
