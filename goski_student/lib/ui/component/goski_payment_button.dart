import 'package:flutter/material.dart';
import 'package:goski_student/main.dart';

class GoskiPaymentButton extends StatelessWidget {
  final double width;
  final String text, imagePath;
  final VoidCallback onTap;
  final Color backgroundColor, foregroundColor;

  const GoskiPaymentButton({
    super.key,
    required this.width,
    required this.text,
    required this.imagePath,
    required this.onTap,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        // 배경색 설정
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        // 텍스트 색상 설정
        minimumSize: MaterialStateProperty.all(Size(width * 0.9, 50)),
        // 최소 크기 설정
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // 테두리 반경 설정
        )),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)), // 패딩 설정
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
              width: screenSizeController.getWidthByRatio(0.23),
              // height: screenSizeController.getWidthByRatio(0.2),
              imagePath),
          // SizedBox(width: screenSizeController.getWidthByRatio(0.02)),
          // Text(
          //   text,
          //   style: const TextStyle(fontSize: goskiFontLarge),
          // ),
        ],
      ),
    );
  }
}
