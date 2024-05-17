import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_header_right_icons.dart';

class GoskiMainHeader extends StatelessWidget implements PreferredSizeWidget {
  const GoskiMainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: goskiBackground,
      backgroundColor: goskiBackground,
      leading: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 2.0,
          top: 11.0,
          bottom: 11.0,
        ),
        child: Image.asset('assets/images/logo.png'),
      ),
      actions: [
        headerRightIcons(context),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.find<ScreenSizeController>().getHeightByRatio(0.07));
}
