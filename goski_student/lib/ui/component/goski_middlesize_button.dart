import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class GoskiMiddlesizeButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final double size;
  final VoidCallback onTap;

  const GoskiMiddlesizeButton({
    super.key,
    required this.width,
    required this.text,
    required this.onTap,
    this.height=67,
    this.size=goskiFontMedium,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(goskiWhite),
        foregroundColor: MaterialStateProperty.all(goskiBlack),
        minimumSize: MaterialStateProperty.all(Size(width * 0.26, height)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: goskiBlack, width: 1) // 테두리 반경 설정
                )),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)), // 패딩 설정
      ),
      child: GoskiText(text: text, size: size, textAlign: TextAlign.center,),
    );
  }
}
