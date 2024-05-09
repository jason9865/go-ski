import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/enum/gender.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/image_picker_controller.dart';
import 'package:goski_instructor/const/util/parser.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/common/b_i003_certificate.dart';
import 'package:goski_instructor/ui/component/goski_basic_info_container.dart';
import 'package:goski_instructor/ui/component/goski_bottomsheet.dart';
import 'package:goski_instructor/ui/component/goski_build_interval.dart';
import 'package:goski_instructor/ui/component/goski_card.dart';
import 'package:goski_instructor/ui/component/goski_container.dart';
import 'package:goski_instructor/ui/component/goski_switch.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/ui/component/goski_textfield.dart';
import 'package:goski_instructor/view_model/signup_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();
SignupViewModel signupViewModel = Get.find();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final imagePickerController = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GoskiContainer(
                onConfirm: () {
                  if (signupViewModel.user.value.isValid()) {
                    if (signupViewModel.user.value.isOwner) {
                      signupViewModel.ownerSignup(signupViewModel.user.value);
                    } else {
                      signupViewModel
                          .instructorSignup(signupViewModel.user.value);
                    }
                  }
                },
                buttonName: "signup",
                child: SingleChildScrollView(
                  child: GoskiCard(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          buildRegisterProfileImage(),
                          const BuildInterval(),
                          const BuildBasicInfo(),
                          const BuildInterval(),
                          buildIsBossRow(),
                          const BuildInterval(),
                          !signupViewModel.user.value.isOwner
                              ? Column(
                                  children: [
                                    buildLessonCategory(),
                                    const BuildInterval(),
                                    Row(
                                      children: [
                                        GoskiText(
                                          text: tr("certificate"),
                                          size: goskiFontLarge,
                                          isExpanded: true,
                                        ),
                                        IconButton(
                                          onPressed: () => {
                                            signupViewModel
                                                .getCertificateList(),
                                            showGoskiBottomSheet(
                                              context: context,
                                              child:
                                                  const CertificateBottomSheet(),
                                            ),
                                          },
                                          icon: const Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                    const BuildInterval(),
                                    buildCertificatesList(),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GoskiText(
                                              text: tr("certificateImage"),
                                              size: goskiFontLarge,
                                              isExpanded: true,
                                            ),
                                          ],
                                        ),
                                        buildCertificateImageList(),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRegisterProfileImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: screenSizeController.getWidthByRatio(0.3),
          height: screenSizeController.getHeightByRatio(0.2),
          decoration: BoxDecoration(
            border: Border.all(color: goskiLightGray, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Obx(
            () => ClipRRect(
              borderRadius:
                  BorderRadius.circular(14), // Container borderRadius - 1
              child: !signupViewModel.hasProfileImage.value
                  ? const Icon(Icons.photo, size: 50, color: Colors.grey)
                  : Image.file(
                      File(signupViewModel.user.value.profileImage!.path),
                      fit: BoxFit.cover,
                    ),
            ),
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
                text: tr("registerProfileImage"),
                size: goskiFontSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildIsBossRow() {
    return Row(
      children: [
        GoskiText(
          text: tr("isBoss"),
          size: goskiFontLarge,
          isExpanded: true,
        ),
        Checkbox(
            value: signupViewModel.user.value.isOwner,
            onChanged: (newValue) {
              setState(() {
                signupViewModel.user.update((val) {
                  val?.isOwner = newValue!;
                });
              });
            }),
      ],
    );
  }

  Widget buildLessonCategory() {
    return Row(
      children: [
        GoskiText(
          text: tr("강습 종류"),
          size: goskiFontLarge,
          isExpanded: true,
        ),
        GoskiSwitch(
          items: [
            tr('both'),
            tr('ski'),
            tr('board'),
          ],
          width: screenSizeController.getWidthByRatio(0.5),
        ),
      ],
    );
  }

  Widget buildCertificatesList() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: signupViewModel.user.value.certificates.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GoskiTextField(
                        width: screenSizeController.getWidthByRatio(0.6),
                        hintText:
                            "${signupViewModel.user.value.certificates[index].certificateType} - ${signupViewModel.user.value.certificates[index].certificateName}",
                        canEdit: false,
                        onTextChange: (text) => {},
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => signupViewModel.removeCertificate(index),
                    ),
                  ],
                ),
                const BuildInterval(),
              ],
            );
          },
        ));
  }

  Widget buildCertificateImageList() {
    return Obx(
      () => Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: signupViewModel.user.value.certificates.length,
            itemBuilder: (context, index) {
              logger.w(signupViewModel
                  .user.value.certificates[index].certificateImage);
              return Container(
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Image.file(
                  File(signupViewModel
                      .user.value.certificates[index].certificateImage!.path),
                  width: double.infinity,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> pickProfileImage() async {
    // 추후에 디바이스에서 사진 가져올 때 사용할 변수들
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    var profileImage = await imagePickerController.getImage();
    signupViewModel.user.update((val) {
      val?.profileImage = profileImage;
    });
    signupViewModel.hasProfileImage.value = true;
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
          onTextChange: (text) {
            signupViewModel.user.update((val) {
              val?.userName = text;
            });
          },
        ),
        const BuildInterval(),
        Row(
          children: [
            GoskiText(
              text: tr("gender"),
              size: goskiFontLarge,
              isExpanded: true,
            ),
            GoskiSwitch(
              items: [
                tr('male'),
                tr('female'),
              ],
              width: screenSizeController.getWidthByRatio(0.6),
              onToggle: (index) {
                signupViewModel.user.update((val) {
                  val?.gender = index == 0 ? Gender.MALE : Gender.FEMALE;
                });
              },
            ),
          ],
        ),
        const BuildInterval(),
        BasicInfoContainer(
          text: "birthDate",
          textField: "enterBirthDate",
          onTextChange: (text) {
            signupViewModel.user.update((val) {
              if (text.length == 8) {
                val?.birthDate = stringToDateTime(text);
              }
            });
          },
        ),
        const BuildInterval(),
        BasicInfoContainer(
          text: "phoneNumber",
          textField: "enterPhoneNumber",
          onTextChange: (text) {
            signupViewModel.user.update((val) {
              if (text.length == 11) {
                val?.phoneNumber = text;
              }
            });
          },
        ),
      ],
    );
  }
}
