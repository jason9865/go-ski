import 'package:flutter/material.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';

class GoskiMiddlesizeButton extends StatelessWidget {
  final double width;
  final String text;
  final VoidCallback onTap;

  const GoskiMiddlesizeButton({
    super.key,
    required this.width,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(goskiWhite),
        // 배경색 설정
        foregroundColor: MaterialStateProperty.all(goskiBlack),
        // 텍스트 색상 설정
        minimumSize: MaterialStateProperty.all(Size(width * 0.26, 67)),
        // 최소 크기 설정
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: goskiBlack, width: 1) // 테두리 반경 설정
                )),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)), // 패딩 설정
      ),
      child: Row(
        children: [
          // const Icon(
          //   Icons.account_balance_wallet,
          // ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: goskiFontMedium),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
