import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/color.dart';
import '../../const/font_size.dart';
import '../../const/util/screen_size_controller.dart';
import '../../const/util/student_info_list.dart';
import 'goski_text.dart';

/// items로 name, isSelected 속성을 가진 리스트가 들어와야 됨
class GoskiSelectGrid extends StatefulWidget {
  final List<GridItem> items;
  final int rows;
  final void Function(int) onItemClicked;

  const GoskiSelectGrid({
    super.key,
    required this.items,
    required this.rows,
    required this.onItemClicked,
  });

  @override
  State<GoskiSelectGrid> createState() => _GoskiSelectGridState();
}

class _GoskiSelectGridState extends State<GoskiSelectGrid> {
  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final space = screenSizeController.getWidthByRatio(0.02);

    return LayoutBuilder(builder: (context, constraints) {
      double itemWidth = (constraints.maxWidth - space) / 2;
      double itemHeight =
          goskiFontMedium + screenSizeController.getWidthByRatio(0.03) * 2;

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.rows,
          mainAxisSpacing: space,
          crossAxisSpacing: space,
          childAspectRatio: itemWidth / itemHeight,
        ),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return GoskiSelectGridItem(
            title: widget.items[index].name,
            isSelected: widget.items[index].isSelected,
            onItemClicked: () {
              setState(() {
                for (int i = 0; i < widget.items.length; i++) {
                  if (i == index) {
                    widget.items[i].isSelected = true;
                  } else {
                    widget.items[i].isSelected = false;
                  }
                }
                widget.onItemClicked(index);
              });
            },
          );
        },
      );
    });
  }
}

class GoskiSelectGridItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onItemClicked;

  const GoskiSelectGridItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onItemClicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isSelected) onItemClicked();
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
            color: isSelected ? goskiButtonBlack : goskiWhite,
            border: Border.all(width: 1, color: goskiDarkGray),
            borderRadius: BorderRadius.circular(10)),
        child: GoskiText(
          text: tr(title),
          size: goskiFontMedium,
          textAlign: TextAlign.center,
          color: isSelected ? goskiWhite : goskiBlack,
        ),
      ),
    );
  }
}
