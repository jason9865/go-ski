import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/enum/auth_status.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/common/i002_signup.dart';
import 'package:goski_instructor/ui/instructor/i004_instructor_main.dart';
import 'package:goski_instructor/view_model/login_view_model.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const BackgroundContainer();
  }
}

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: const LoginContent(),
      ),
    );
  }
}

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: screenSizeController.getHeightByRatio(0.33),
          ),
          const LogoImage(),
          Expanded(child: Container()), // 로고와 버튼 사이에 공간
          KakaoLoginButton(),
          Expanded(child: Container()), // 버튼과 텍스트 사이에 공간
          const BottomText(),
          Container(
            height: screenSizeController.getHeightByRatio(0.03),
          ),
        ],
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo.png",
      width: 220, // 로고의 너비
      height: 120, // 로고의 높이
    );
  }
}

// class KakaoLoginButton extends StatelessWidget {
//   final LoginViewModel loginViewModel = Get.find<LoginViewModel>();

//   KakaoLoginButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         loginViewModel.loginWithKakao().then((result) {
//           switch (result) {
//             case AuthStatus.already:
//               Get.offAll(() => const InstructorMainScreen());
//               break;
//             case AuthStatus.first:
//               Get.off(() => const SignUpScreen());
//               break;
//             case AuthStatus.error:
//               Get.snackbar("Login Failed", "Please try again.");
//               break;
//           }
//         });
//       },
//       child: Image.asset(
//         "assets/images/kakao_login.png",
//         width: 300,
//         height: 60,
//       ),
//     );
//   }
// }

class KakaoLoginButton extends StatelessWidget {
  final LoginViewModel loginViewModel = Get.find<LoginViewModel>();

  KakaoLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        loginViewModel.loginWithKakao().then((result) {
          switch (result) {
            case AuthStatus.already:
              if (!Get.isSnackbarOpen) {
                Get.snackbar(tr("successLogin"), tr("welcome"));
              }
              Get.offAll(() => const InstructorMainScreen());
              break;
            case AuthStatus.first:
              if (!Get.isSnackbarOpen) {
                Get.snackbar(tr("successLogin"), tr("redirectToSignUpScreen"));
              }
              Get.off(() => const SignUpScreen());
              break;
            case AuthStatus.error:
              if (!Get.isSnackbarOpen) {
                Get.snackbar(tr("failedToLogin"), tr("tryLater"));
              }
              break;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(
            0xffFEE500,
          ),
        ),
        height: screenSizeController.getHeightByRatio(0.06),
        width: screenSizeController.getWidthByRatio(0.75),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: screenSizeController.getWidthByRatio(0.035),
              ),
              child: SvgPicture.asset(
                'assets/images/kakao_symbol.svg',
                height: screenSizeController.getHeightByRatio(0.024),
                colorFilter: const ColorFilter.mode(
                  Color(
                    0xff000000,
                  ),
                  BlendMode.srcIn,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: screenSizeController.getWidthByRatio(0.035),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tr('kakaoLogin'),
                      style: TextStyle(
                        fontFamily: "NotoSansKR",
                        fontSize: 20,
                        color: const Color(0xff000000).withOpacity(0.85),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomText extends StatelessWidget {
  const BottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'loginBottomText',
      style: TextStyle(
        fontFamily: 'RubikGlitch',
        fontSize: goskiFontLarge,
        color: goskiBlack,
      ),
    ).tr();
  }
}
