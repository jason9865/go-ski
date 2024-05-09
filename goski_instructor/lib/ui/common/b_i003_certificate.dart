import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/util/image_picker_controller.dart';
import 'package:goski_instructor/data/model/certificate.dart';
import 'package:goski_instructor/main.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/view_model/signup_view_model.dart';

import '../../const/font_size.dart';
import '../../const/util/screen_size_controller.dart';

class CertificateBottomSheet extends StatefulWidget {
  final GestureTapCallback? onClicked;

  const CertificateBottomSheet({super.key, this.onClicked});

  @override
  State<CertificateBottomSheet> createState() => _CertificateBottomSheetState();
}

class _CertificateBottomSheetState extends State<CertificateBottomSheet> {
  final SignupViewModel signupViewModel = Get.find();
  final imagePickerController = Get.put(ImagePickerController());
  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final padding = screenSizeController.getWidthByRatio(0.01);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GoskiSwitch(
          items: [tr('ski'), tr('board')],
          width: screenSizeController.getWidthByRatio(0.7),
          onToggle: (index) {
            signupViewModel.switchCertificateChoiceList(index);
          },
        ),
        SizedBox(
          height: screenSizeController.getHeightByRatio(0.02),
        ),
        Obx(
          () => GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: padding,
              crossAxisSpacing: padding,
              childAspectRatio: 1.0,
            ),
            itemCount: signupViewModel.certificateChoiceList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  var certificate = Certificate(
                    certificateId: signupViewModel
                        .certificateChoiceList[index].certificateId,
                    certificateImage: await imagePickerController.getImage(),
                    certificateName: signupViewModel
                        .certificateChoiceList[index].certificateName,
                    certificateType: signupViewModel
                        .certificateChoiceList[index].certificateType,
                  );
                  signupViewModel.addCertificate(certificate);
                  logger.w(certificate.certificateImage);
                  Navigator.pop(context);
                },
                child: GoskiCard(
                  child: InkWell(
                    onTap: widget.onClicked,
                    child: Container(
                      alignment: Alignment.center,
                      child: GoskiText(
                        text: signupViewModel
                            .certificateChoiceList[index].certificateName!,
                        size: goskiFontMedium,
                        isBold: true,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
