import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_basic_info_container.dart';
import 'package:goski_instructor/ui/component/goski_build_interval.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_switch.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class UpdateBossInfoScreen extends StatefulWidget {
  const UpdateBossInfoScreen({super.key});

  @override
  State<UpdateBossInfoScreen> createState() => _UpdateBossInfoScreenState();
}

class _UpdateBossInfoScreenState extends State<UpdateBossInfoScreen> {
  String profileImage = "assets/images/person2.png";

  @override
  Widget build(BuildContext context) {
    return GoskiContainer(
      onConfirm: () => 0,
      buttonName: "update",
      child: SingleChildScrollView(
        child: GoskiCard(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                buildRegisterProfilePhoto(),
                const BuildInterval(),
                const BuildBasicInfo(),
                const BuildInterval(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRegisterProfilePhoto() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: screenSizeController.getWidthByRatio(0.3),
          height: screenSizeController.getHeightByRatio(0.2),
          decoration: BoxDecoration(
            border: Border.all(color: goskiDarkGray, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(14), // Container borderRadius - 1
            child: profileImage == ""
                ? const Icon(Icons.photo, size: 50, color: Colors.grey)
                : Image.asset(profileImage, fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: screenSizeController.getHeightByRatio(0.005)),
        GestureDetector(
          onTap: pickProfileImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.photo_outlined),
              GoskiText(
                text: tr("updateProfileImage"),
                size: goskiFontSmall,
                isBold: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> pickProfileImage() async {
    // 추후에 디바이스에서 사진 가져올 때 사용할 변수들
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      // 일단 assets 폴더에 있는 이미지의 경로를 리스트에 추가
      profileImage = "assets/images/person2.png";
    });
  }
}

class BuildBasicInfo extends StatelessWidget {
  const BuildBasicInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BasicInfoContainer(
          text: "name",
          textField: "enterName",
          onTextChange: (text) => 0,
        ),
        const BuildInterval(),
        Row(
          children: [
            GoskiText(
              text: tr("gender"),
              size: goskiFontLarge,
              isBold: true,
              isExpanded: true,
            ),
            GoskiSwitch(
                items: [tr('male'), tr('female')],
                width: screenSizeController.getWidthByRatio(0.6)),
          ],
        ),
        const BuildInterval(),
        BasicInfoContainer(
          text: "birthDate",
          textField: "enterBirthDate",
          onTextChange: (text) => 0,
        ),
        const BuildInterval(),
        BasicInfoContainer(
          text: "phoneNumber",
          textField: "enterPhoneNumber",
          onTextChange: (text) => 0,
        ),
      ],
    );
  }
}
