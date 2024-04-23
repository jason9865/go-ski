import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenSizeController extends GetxController {
  final RxDouble width = 0.0.obs;
  final RxDouble height = 0.0.obs;

  void setScreenSize(double newWidth, double newHeight) {
    width.value = newWidth;
    height.value = newHeight;
  }

  // 비율에 따라 계산된 크기 반환
  Size getWidthByRatio(double widthRatio, double heightRatio) {
    return Size(width.value * widthRatio, height.value * heightRatio);
  }
}
