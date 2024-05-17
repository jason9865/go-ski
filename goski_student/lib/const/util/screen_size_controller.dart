import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenSizeController extends GetxController {
  final RxDouble width = 0.0.obs;
  final RxDouble height = 0.0.obs;

  void setScreenSize(double newWidth, double newHeight) {
    width.value = newWidth;
    height.value = newHeight;
  }

  // 비율에 따라 계산된 Size 인스턴스 반환
  Size getSizeByRatio(double widthRatio, double heightRatio) {
    return Size(width.value * widthRatio, height.value * heightRatio);
  }

  // 비율에 따라 계산된 너비 반환
  double getWidthByRatio(double widthRatio) {
    return width.value * widthRatio;
  }

  // 비율에 따라 계산된 높이 반환
  double getHeightByRatio(double heightRatio) {
    return height.value * heightRatio;
  }
}
