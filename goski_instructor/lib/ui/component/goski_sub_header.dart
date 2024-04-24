import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/util/screen_size_controller.dart';
import 'package:goski_instructor/ui/component/goski_header_right_icons.dart';

class GoskiSubHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const GoskiSubHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: goskiBackground,
      backgroundColor: goskiBackground,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(title, style: Theme.of(context).textTheme.displayMedium),
      centerTitle: false,
      actions: [
        headerRightIcons(context),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.find<ScreenSizeController>().getHeightByRatio(0.07));
}
