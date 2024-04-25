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
  List<_Account> dummyData = [
    _Account(bankName: '국민은행1', depositorName: '송준석', accountNumber: '123456-12-123451', imagePath: 'assets/images/logo.png'),
    _Account(bankName: '국민은행2', depositorName: '송준석', accountNumber: '123456-12-123452', imagePath: 'assets/images/logo.png'),
    _Account(bankName: '국민은행3', depositorName: '송준석', accountNumber: '123456-12-123453', imagePath: 'assets/images/logo.png'),
    _Account(bankName: '국민은행4', depositorName: '송준석', accountNumber: '123456-12-123454', imagePath: 'assets/images/logo.png'),
    _Account(bankName: '국민은행5', depositorName: '송준석', accountNumber: '123456-12-123455', imagePath: 'assets/images/logo.png'),
    _Account(bankName: '국민은행6', depositorName: '송준석', accountNumber: '123456-12-123456', imagePath: 'assets/images/logo.png'),
  ];
  String? _selectedAccountNumber = '123456-12-123451';

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final imageSize = screenSizeController.getWidthByRatio(0.2);
    final space = screenSizeController.getWidthByRatio(0.005);

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
                        _selectedAccountNumber = dummyData[index].accountNumber;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Image.asset(
                            width: imageSize,
                            height: imageSize,
                            dummyData[index].imagePath,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GoskiText(
                                  text: dummyData[index].depositorName,
                                  size: 15,
                                  isBold: true,
                                ),
                                SizedBox(
                                  height: space,
                                ),
                                GoskiText(
                                  text: dummyData[index].bankName,
                                  size: 15,
                                  isBold: false,
                                ),
                                SizedBox(
                                  height: space,
                                ),
                                GoskiText(
                                  text: dummyData[index].accountNumber,
                                  size: 15,
                                  isBold: false,
                                ),
                              ],
                            ),
                          ),
                          Radio<String>(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => goskiButtonBlack),
                            value: dummyData[index].accountNumber,
                            groupValue: _selectedAccountNumber,
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
          text: tr('send'),
          onTap: () {
            widget.onClicked?.call();
          },
        )
      ],
    );
  }
}

class _Account {
  final String bankName;
  final String depositorName;
  final String accountNumber;
  final String imagePath;

  _Account({
    required this.bankName,
    required this.depositorName,
    required this.accountNumber,
    required this.imagePath
  });
}
