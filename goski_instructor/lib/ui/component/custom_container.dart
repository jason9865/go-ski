import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class CustomContainer extends StatelessWidget {
  // 내용들
  final Widget content;
  // 버튼 눌렀을 때 동작할 메서드, 있을 수도 있고 없을 수도 있음
  final VoidCallback? onConfirm;

  const CustomContainer({
    super.key,
    required this.content,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();

    return const SingleChildScrollView();
  }
}