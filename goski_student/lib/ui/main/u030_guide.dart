import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';

// TODO: 도움말 페이지  추가 필요
class GuideScreen extends StatelessWidget {

  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: GoskiSubHeader(title: tr('guide')),
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
                    // TODO: 진짜 도움말 페이지 추가 필요
                    text: '도움말 페이지',
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