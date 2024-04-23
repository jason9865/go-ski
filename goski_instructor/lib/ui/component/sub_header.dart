import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/header_right_icons.dart';

class SubHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SubHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: goskiBackground,
      backgroundColor: goskiDarkGray,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(title, style: Theme.of(context).textTheme.displayMedium),
      centerTitle: false,
      actions: [
        HeaderRightIcons(),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.find<ScreenSizeController>().getHeightByRatio(0.07));
}
