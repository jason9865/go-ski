import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';

class GoskiSmallsizeButton extends StatelessWidget {
  final double width, height;
  final String text;
  final VoidCallback onTap;
  final double textSize;
  final Color backgroundColor, foregroundColor;

  const GoskiSmallsizeButton({
    super.key,
    required this.width,
    this.height = 40,
    required this.text,
    required this.onTap,
    this.textSize = goskiFontLarge,
    this.backgroundColor = goskiButtonBlack,
    this.foregroundColor = goskiWhite,
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
        minimumSize: MaterialStateProperty.all(Size(width * 0.33, height)),
        // 최소 크기 설정
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // 테두리 반경 설정
        )),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)), // 패딩 설정
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: textSize,
        ),
      ),
    );
  }
}
