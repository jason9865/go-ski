import 'dart:io';
import 'package:goski_instructor/const/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_bottomsheet.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_switch.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/ui/component/goski_textfield.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isBoss = false;
  List<Widget> certificates = []; // 자격증을 저장할 리스트
  // List<File> certificateImages = []; // 자격증 이미지 파일 리스트, 나중에 진짜 파일 가져올 때 사용
  List<String> certificateImages = []; // 이미지 경로를 저장하는 리스트
  String profileImage = "";

  @override
  Widget build(BuildContext context) {
    return GoskiContainer(
      onConfirm: () => 0,
      buttonName: "signup",
      child: GoskiCard(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: goskiDarkGray, width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          14), // Container borderRadius - 1
                      child: profileImage == ""
                          ? const Icon(Icons.photo,
                              size: 50, color: Colors.grey)
                          : Image.asset(profileImage, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: pickProfileImage,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_outlined),
                        Text("사진 등록", style: TextStyle(fontSize: bodyMedium)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const BasicInfo(),
              Row(
                children: [
                  GoskiText(
                    text: tr("isBoss"),
                    size: labelLarge,
                    isBold: true,
                    isExpanded: true,
                  ),
                  Checkbox(
                      value: isBoss,
                      onChanged: (newValue) {
                        setState(() {
                          isBoss = newValue!;
                        });
                      }),
                ],
              ),
              !isBoss
                  ? Column(
                      children: [
                        Row(
                          children: [
                            GoskiText(
                              text: tr("certificate"),
                              size: labelLarge,
                              isBold: true,
                              isExpanded: true,
                            ),
                            IconButton(
                              onPressed: () => {
                                showGoskiBottomSheet(
                                  context: context,
                                  child: const SizedBox(
                                    height: 400,
                                    child: Text("자격증 바텀시트 나와라"),
                                  ),
                                ),
                                addCertificate(),
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        ...certificates,
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: pickCertificateImage,
                                  icon: const Icon(Icons.photo_camera),
                                ),
                              ],
                            ),
                            certificateImages.isNotEmpty
                                ? Card(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: SizedBox(
                                      height: 120,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: certificateImages.length,
                                        itemBuilder: (context, index) {
                                          return Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                width: 100,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Image.asset(
                                                  certificateImages[index],
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                right: -12,
                                                top: -10,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.remove_circle,
                                                    color: goskiBlack,
                                                  ),
                                                  onPressed: () =>
                                                      removeCertificateImage(
                                                          index),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickProfileImage() async {
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      // 일단 assets 폴더에 있는 이미지의 경로를 리스트에 추가
      profileImage = "assets/images/person2.png";
    });
  }

  Future<void> pickCertificateImage() async {
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      // 일단 assets 폴더에 있는 이미지의 경로를 리스트에 추가
      certificateImages.add("assets/images/certificate.png");
    });
  }

  void removeCertificateImage(int index) {
    setState(() {
      certificateImages.removeAt(index);
    });
  }

  void addCertificate() {
    certificates.add(
      Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GoskiTextField(
                  width: screenSizeController.getWidthByRatio(0.6),
                  hintText: tr("selectCertificate"),
                  canEdit: false,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => removeCertificate(certificates.length - 1),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
    setState(() {});
  }

  void removeCertificate(int index) {
    if (index >= 0 && index < certificates.length) {
      certificates.removeAt(index);
      setState(() {});
    }
  }
}

class BasicInfo extends StatelessWidget {
  const BasicInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BasicInfoContainer(
          text: "name",
          textField: "enterName",
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            GoskiText(
              text: tr("gender"),
              size: labelLarge,
              isBold: true,
              isExpanded: true,
            ),
            GoskiSwitch(
                items: const ['남자', '여자'],
                width: screenSizeController.getWidthByRatio(0.6)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const BasicInfoContainer(
          text: "birthDate",
          textField: "enterBirthDate",
        ),
        const SizedBox(
          height: 20,
        ),
        const BasicInfoContainer(
          text: "phoneNumber",
          textField: "enterPhoneNumber",
        ),
      ],
    );
  }
}

class BasicInfoContainer extends StatelessWidget {
  final String text;
  final String textField;
  const BasicInfoContainer({
    required this.text,
    required this.textField,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GoskiText(
          text: tr(text),
          size: labelLarge,
          isBold: true,
          isExpanded: true,
        ),
        GoskiTextField(
          width: screenSizeController.getWidthByRatio(0.6),
          hintText: tr(textField),
        ),
      ],
    );
  }
}
