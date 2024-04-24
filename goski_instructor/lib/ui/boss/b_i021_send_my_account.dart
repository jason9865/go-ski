import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/ui/component/goski_bigsize_button.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/ui/component/goski_textfield.dart';

import '../../const/util/screen_size_controller.dart';

class SendMyAccountBottomSheet extends StatefulWidget {
  final GestureTapCallback? onClicked;

  const SendMyAccountBottomSheet({
    super.key,
    this.onClicked,
  });

  @override
  State<SendMyAccountBottomSheet> createState() =>
      _SendMyAccountBottomSheetState();
}

class _SendMyAccountBottomSheetState extends State<SendMyAccountBottomSheet> {
  List dummyData = [
    [null, '국민은행1', '123456-12-123456'],
    [null, '국민은행2', '123456-12-123456'],
    [null, '국민은행3', '123456-12-123456'],
    [null, '국민은행4', '123456-12-123456'],
    [null, '국민은행5', '123456-12-123456'],
    [null, '국민은행6', '123456-12-123456'],
    [null, '국민은행7', '123456-12-123456'],
    [null, '국민은행8', '123456-12-123456'],
    [null, '국민은행9', '123456-12-123456'],
    [null, '국민은행10', '123456-12-123456'],
  ];
  String? _selected = "국민은행1";

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final imageSize = screenSizeController.getWidthByRatio(0.2);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: screenSizeController.getHeightByRatio(0.5),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: dummyData.length,
              itemBuilder: (context, index) {
                return GoskiCard(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selected = dummyData[index][1];
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Image.asset(
                            width: imageSize,
                            height: imageSize,
                            'assets/images/logo.png',
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GoskiText(
                                  text: dummyData[index][1]!,
                                  size: 15,
                                  isBold: true,
                                ),
                                SizedBox(
                                  height: screenSizeController
                                      .getHeightByRatio(0.005),
                                ),
                                GoskiText(
                                  text: dummyData[index][2]!,
                                  size: 15,
                                  isBold: false,
                                ),
                              ],
                            ),
                          ),
                          Radio<String>(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => goskiButtonBlack),
                            value: dummyData[index][1],
                            groupValue: _selected,
                            onChanged: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: screenSizeController.getHeightByRatio(0.00),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: screenSizeController.getHeightByRatio(0.02),
        ),
        GoskiTextField(hintText: tr('enterAmount')),
        SizedBox(
          height: screenSizeController.getHeightByRatio(0.02),
        ),
        GoskiBigsizeButton(
          width: screenSizeController.getWidthByRatio(1),
          text: '보내기',
          onTap: () {
            widget.onClicked?.call();
          },
        )
      ],
    );
  }
}
