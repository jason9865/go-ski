import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_header_right_icons.dart';

class GoskiMainHeader extends StatelessWidget implements PreferredSizeWidget {
  const GoskiMainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: goskiBackground,
      backgroundColor: goskiBackground,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/logo.png'),
      ),
      actions: [
        headerRightIcons(context),
      ],
      scrolledUnderElevation: 0,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.find<ScreenSizeController>().getHeightByRatio(0.07));
}
