import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';

// TODO: 환불 정책 페이지  추가 필요
class RefundPolicyScreen extends StatelessWidget {

  const RefundPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: GoskiSubHeader(title: tr('refundPolicy2')),
        body: Container(
          decoration: const BoxDecoration(
            color: goskiBackground,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: GoskiText(
                    text: tr('refundPolicyDetail'),
                    size: goskiFontLarge,
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