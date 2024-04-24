import 'package:flutter/material.dart';
import 'package:goski_instructor/const/text_theme.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/test.dart';
// import 'package:goski_instructor/ui/I004.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/ui/component/goski_main_header.dart';
// import 'package:goski_instructor/ui/component/goski_sub_header.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
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
          return const Scaffold(
            appBar: GoskiMainHeader(),
            // appBar: SubHeader(title: "페이지 이름"),
            body: Test(),
          );
        },
      ),
    );
  }
}
