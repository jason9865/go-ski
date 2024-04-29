import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/text_theme.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/test.dart';
import 'package:goski_student/ui/component/goski_main_header.dart';
import 'package:goski_student/ui/user/u001_login.dart';
import 'package:goski_student/ui/user/u002_signup.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ko', 'KR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ko', 'KR'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        fontFamily: 'Jua',
        textTheme: AppTextTheme.lightTextTheme,
      ),
      home: Builder(
        builder: (context) {
          final mediaQueryData = MediaQuery.of(context);
          final screenSizeController = Get.put(ScreenSizeController());
          screenSizeController.setScreenSize(
            mediaQueryData.size.width,
            mediaQueryData.size.height,
          );
          logger.d(
              "ScreenHeight: ${screenSizeController.height}, ScreenWidth: ${screenSizeController.width}");

          return Obx(() {
            if (loginController.isLogin.value) {
              return const Scaffold(
                appBar: GoskiMainHeader(),
                // appBar: SubHeader(title: "페이지 이름"),
                body: Test(),
              );
            } else {
              return const LoginScreen();
            }
          });
        },
      ),
    );
  }
}
