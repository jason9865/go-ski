import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/url_launch_util.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';

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
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '',
                      style: const TextStyle(
                        height: 2,
                      ),
                      children: [
                        buildTitleText(tr('KoSeungMin')),
                        buildEmailText('smink95@naver.com'),
                        buildTitleText('\n${tr('GoJeongWon')}'),
                        buildEmailText('7704wjddnjs@gmail.com'),
                        buildTitleText('\n${tr('SongJunSeok')}'),
                        buildEmailText('jswsn1526@naver.com'),
                        buildTitleText('\n${tr('ImJongoYoul')}'),
                        buildEmailText('dlawhdfbf12@gmail.com'),
                        buildTitleText('\n${tr('JangSeungHo')}'),
                        buildEmailText('jsh09865@gmail.com'),
                        buildTitleText('\n${tr('ChoiJiChan')}'),
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
        text: '$text - ',
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
