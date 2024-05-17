import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/enum/gender.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/parser.dart';
import 'package:goski_student/main.dart';
import 'package:goski_student/ui/component/goski_basic_info_container.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_switch.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/main/u003_student_main.dart';
import 'package:goski_student/view_model/signup_view_model.dart';

final SignupViewModel signupViewModel = Get.put(SignupViewModel());

// loginController, 추후에 refactoring
class LoginController extends GetxController {
  RxBool isLogin = false.obs;

  void login() {
    isLogin.value = true;
    // Get.to(() => const Test());
    logger.d("로그인 ${isLogin.value}");
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isBoss = false;
  List<String> certificates = []; // 자격증을 렌더링할 리스트
  // List<File> certificateImages = []; // 자격증 이미지 파일 리스트, 나중에 진짜 파일 가져올 때 사용
  List<String> certificateImages = []; // 이미지 경로를 저장하는 리스트
  String profileImage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GoskiContainer(
                onConfirm: () {
                  logger.d("로그 ${signupViewModel.user.value}");
                  if (signupViewModel.user.value.isValid()) {
                    logger.d("로그 : 유효한 요청");
                    signupViewModel
                        .userSignup(signupViewModel.user.value)
                        .then((value) => {
                              if (value)
                                {
                                  if (!Get.isSnackbarOpen)
                                    {
                                      Get.snackbar(
                                          tr('successSignup'), tr('welcome'))
                                    },
                                  Get.offAll(() => const StudentMainScreen())
                                }
                              else
                                {
                                  if (!Get.isSnackbarOpen)
                                    {
                                      Get.snackbar(
                                          tr('failSignup'), tr('tryLater'))
                                    }
                                }
                            });
                  }
                },
                buttonName: "signup",
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenSizeController.getHeightByRatio(0.1),
                    ),
                    child: GoskiCard(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenSizeController.getHeightByRatio(0.05),
                          horizontal:
                              screenSizeController.getWidthByRatio(0.03),
                        ),
                        child: Column(
                          children: [
                            buildRegisterProfileImage(),
                            const BuildInterval(),
                            const BuildBasicInfo(),
                          ],
                        ),
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
                text: tr("registerProfileImage"),
                size: goskiFontSmall,
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
