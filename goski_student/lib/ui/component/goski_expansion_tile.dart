import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/color.dart';
import '../../const/util/screen_size_controller.dart';

/// verticalPadding 기본값(최솟값)은 -4이고 4까지 가능
class GoskiExpansionTile extends StatelessWidget {
  final Widget title;
  final List<Widget> children;
  final double radius, verticalPadding;
  final Color backgroundColor;

  const GoskiExpansionTile({
    super.key,
    required this.title,
    required this.children,
    this.radius = 10,
    this.backgroundColor = goskiLightGray,
    this.verticalPadding = -4.0,
  });

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final horizontalPadding = screenSizeController.getWidthByRatio(0.02);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ListTileTheme(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        minLeadingWidth: 0,
        dense: true,
        child: ExpansionTile(
          visualDensity: VisualDensity(
            horizontal: 0,
            vertical: verticalPadding < -4
                ? -4
                : verticalPadding > 4
                    ? 4
                    : verticalPadding,
          ),
          childrenPadding: EdgeInsets.only(
              bottom: screenSizeController.getWidthByRatio(0.03)),
          iconColor: goskiBlack,
          collapsedIconColor: goskiBlack,
          shape: const Border(),
          collapsedShape: const Border(),
          expandedAlignment: Alignment.centerLeft,
          title: title,
          children: children,
        ),
      ),
    );
  }
}
