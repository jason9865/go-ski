import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';

class AccountListScreen extends StatelessWidget {
  const AccountListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final imageSize = screenSizeController.getWidthByRatio(0.2);
    final VoidCallback onTap = () {
      print("버튼 클릭");
    };

    final List<_Account> accountList = [
      _Account(
          bankName: '국민은행1',
          depositorName: '홍길동1',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/logo.png'
      ),
      _Account(
          bankName: '국민은행2',
          depositorName: '홍길동2',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/penguin.png'
      ),
      _Account(
          bankName: '국민은행3',
          depositorName: '홍길동3',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/logo.png'
      ),
      _Account(
          bankName: '국민은행4',
          depositorName: '홍길동4',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/penguin.png'
      ),
      _Account(
          bankName: '국민은행1',
          depositorName: '홍길동1',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/logo.png'
      ),
      _Account(
          bankName: '국민은행2',
          depositorName: '홍길동2',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/penguin.png'
      ),
      _Account(
          bankName: '국민은행3',
          depositorName: '홍길동3',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/logo.png'
      ),
      _Account(
          bankName: '국민은행4',
          depositorName: '홍길동4',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/penguin.png'
      ),
      _Account(
          bankName: '국민은행1',
          depositorName: '홍길동1',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/logo.png'
      ),
      _Account(
          bankName: '국민은행2',
          depositorName: '홍길동2',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/penguin.png'
      ),
      _Account(
          bankName: '국민은행3',
          depositorName: '홍길동3',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/logo.png'
      ),
      _Account(
          bankName: '국민은행4',
          depositorName: '홍길동4',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/penguin.png'
      ),
      _Account(
          bankName: '국민은행1',
          depositorName: '홍길동1',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/logo.png'
      ),
      _Account(
          bankName: '국민은행2',
          depositorName: '홍길동2',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/penguin.png'
      ),
      _Account(
          bankName: '국민은행3',
          depositorName: '홍길동3',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/logo.png'
      ),
      _Account(
          bankName: '국민은행4',
          depositorName: '홍길동4',
          accountNumber: '123456-12-123456',
          imagePath : 'assets/images/penguin.png'
      ),
    ];

    return GoskiContainer(
      buttonName: tr('addAccount'),
      onConfirm: onTap,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: accountList.length,
        itemBuilder: (BuildContext context, int index) {
          final account = accountList[index];
          return GoskiCard(
            child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Image.asset(
                    width: imageSize,
                    height: imageSize,
                    account.imagePath,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GoskiText(
                          text: account.depositorName,
                          size: bodyMedium,
                          isBold: true,
                        ),
                        SizedBox(
                          height: screenSizeController
                              .getHeightByRatio(0.005),
                        ),
                        GoskiText(
                          text: account.bankName,
                          size: bodyMedium,
                          isBold: false,
                        ),
                        SizedBox(
                          height: screenSizeController
                              .getHeightByRatio(0.005),
                        ),
                        GoskiText(
                          text: account.accountNumber,
                          size: bodyMedium,
                          isBold: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
