import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/main.dart';

import '../../const/font_size.dart';

/*
  ## 사용법
  ### title && content는 필수 parameter
  ### onConfirm && buttonName은 필수x, 근데 쓸거면 같이 써줘야 버튼 제대로 렌더링됨
  ### 버튼은 추후 customButton으로 수정
onPressed: () {
  showDialog(
    context = context,
    builder = (BuildContext context) => GoskiModal(
      title: 모달 이름,
      child: 모달에 들어갈 컨텐츠(위젯),
      onConfirm: () => 함수 정의,
      buttonName: "버튼이름",
    ),
  );
};
*/

class GoskiModal extends StatelessWidget {
  // 헤더에 들어갈 모달 제목
  final String title;
  // 내용들
  final Widget child;
  // 버튼 눌렀을 때 동작할 메서드, 있을 수도 있고 없을 수도 있음
  final VoidCallback? onConfirm;
  final String? buttonName;

  const GoskiModal({
    super.key,
    required this.title,
    required this.child,
    this.onConfirm,
    this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = screenSizeController.getWidthByRatio(0.05);
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      insetPadding:
          EdgeInsets.all(screenSizeController.getHeightByRatio(0.023)),
      titlePadding: EdgeInsets.symmetric(
          vertical: screenSizeController.getHeightByRatio(0.01)),
      actionsPadding: EdgeInsets.symmetric(
        // vertical: screenSizeController.getHeightByRatio(0.02),
        horizontal: horizontalPadding,
      ),
      backgroundColor: goskiBackground,
      title: SizedBox(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: screenSizeController.getHeightByRatio(0.01)),
              child: Text(
                title,
                style: const TextStyle(
                    color: goskiBlack,
                    fontSize: goskiFontXLarge,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(
              color: goskiDarkGray,
              thickness: 2,
            ),
          ],
        ),
      ),
      // titlePadding: const EdgeInsets.all(20),
      content: Container(
        width: screenSizeController.getWidthByRatio(1),
        constraints: BoxConstraints(
            maxHeight: screenSizeController.getHeightByRatio(0.9)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            child,
          ],
        ),
      ),
      actions: onConfirm != null && buttonName != null
          ? <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 뒤로 가기
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(tr('cancel')),
                  ),
                ],
              ),
            ]
          : <Widget>[
              SizedBox(
                height: screenSizeController.getHeightByRatio(0.02),
              )
            ],
    );
  }
}
