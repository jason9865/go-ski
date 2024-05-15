import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_instructor/const/color.dart';
import 'package:goski_instructor/const/font_size.dart';
import 'package:goski_instructor/ui/component/goski_text.dart';
import 'package:goski_instructor/view_model/instructor_main_view_model.dart';

import '../../const/util/screen_size_controller.dart';
import '../component/goski_border_white_container.dart';

class LessonDetailDialog extends StatefulWidget {
  final int lessonId;
  const LessonDetailDialog({
    super.key,
    required this.lessonId,
  });

  @override
  State<LessonDetailDialog> createState() => _LessonDetailDialogState();
}

class _LessonDetailDialogState extends State<LessonDetailDialog> {
  final instructorMainViewModel = Get.find<InstructorMainViewModel>();
  @override
  void initState() {
    super.initState();
    instructorMainViewModel.getLesson(widget.lessonId);
  }

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final titlePadding = screenSizeController.getHeightByRatio(0.005);
    final contentPadding = screenSizeController.getHeightByRatio(0.015);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GoskiText(
          text: tr('date'),
          size: goskiFontLarge,
          isBold: true,
        ),
        SizedBox(height: titlePadding),
        GoskiBorderWhiteContainer(
          child: GoskiText(
            text: instructorMainViewModel.lesson.lessonDate,
            size: goskiFontMedium,
          ),
        ),
        SizedBox(height: contentPadding),
        GoskiText(
          text: tr('location'),
          size: goskiFontLarge,
          isBold: true,
        ),
        SizedBox(height: titlePadding),
        GoskiBorderWhiteContainer(
          child: GoskiText(
            text: instructorMainViewModel.lesson.resortName,
            size: goskiFontMedium,
          ),
        ),
        SizedBox(height: contentPadding),
        GoskiText(
          text: tr('reservationPerson'),
          size: goskiFontLarge,
          isBold: true,
        ),
        SizedBox(height: titlePadding),
        GoskiBorderWhiteContainer(
          child: GoskiText(
            text: instructorMainViewModel.lesson.representativeName,
            size: goskiFontMedium,
          ),
        ),
        SizedBox(height: contentPadding),
        GoskiText(
          text: tr('studentInfo'),
          size: goskiFontLarge,
          isBold: true,
        ),
        SizedBox(height: titlePadding),
        GoskiBorderWhiteContainer(
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: screenSizeController.getHeightByRatio(0.25),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: instructorMainViewModel.lesson.studentInfos.length,
                  itemBuilder: (context, index) {
                    return BackgroundContainer(
                      title: GoskiText(
                        text:
                            "${index + 1}. ${instructorMainViewModel.lesson.studentInfos[index].name}",
                        size: goskiFontMedium,
                      ),
                      children: [
                        GoskiText(
                          text:
                              "${instructorMainViewModel.lesson.studentInfos[index].age} / ${instructorMainViewModel.lesson.studentInfos[index].gender}\n${instructorMainViewModel.lesson.studentInfos[index].height} / ${instructorMainViewModel.lesson.studentInfos[index].weight} / ${instructorMainViewModel.lesson.studentInfos[index].footSize}",
                          size: goskiFontMedium,
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: screenSizeController.getHeightByRatio(0.01),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: contentPadding),
        GoskiText(
          text: tr('requestMessage'),
          size: goskiFontLarge,
          isBold: true,
        ),
        SizedBox(height: titlePadding),
        GoskiBorderWhiteContainer(
          child: GoskiText(
            text: instructorMainViewModel.lesson.requestComplain ?? '',
            size: goskiFontMedium,
          ),
        ),
        SizedBox(height: contentPadding),
      ],
    );
  }
}

// 수강생 정보 카드 안 파란 배경 영역
class BackgroundContainer extends StatelessWidget {
  final Widget title;
  final List<Widget> children;

  const BackgroundContainer(
      {super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final padding = screenSizeController.getWidthByRatio(0.02);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: padding),
      decoration: BoxDecoration(
          color: goskiBackground, borderRadius: BorderRadius.circular(5)),
      child: ListTileTheme(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        minLeadingWidth: 0,
        dense: true,
        child: ExpansionTile(
          childrenPadding: EdgeInsets.only(
              bottom: screenSizeController.getWidthByRatio(0.03)),
          visualDensity: VisualDensity.compact,
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
