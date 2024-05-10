import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';

class GoskiSubHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const GoskiSubHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: goskiBackground,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(title, style: Theme.of(context).textTheme.displayMedium),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.find<ScreenSizeController>().getHeightByRatio(0.07));
}
