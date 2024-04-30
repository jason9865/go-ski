import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_instructor_card.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class ReservationTeamDetailScreen extends StatefulWidget {
  final String teamName;
  final List<String> teamImages;
  final String description;
  final List<Instructor> instructors;
  final int cost;

  const ReservationTeamDetailScreen(
      {super.key,
      required this.teamName,
      required this.teamImages,
      required this.description,
      required this.instructors,
      required this.cost});

  @override
  State<ReservationTeamDetailScreen> createState() =>
      _ReservationTeamDetailScreenState();
}

class _ReservationTeamDetailScreenState
    extends State<ReservationTeamDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return GoskiContainer(
        buttonName: tr('reserveTeam',
            args: [NumberFormat('#,###').format(widget.cost)]),
        onConfirm: () {
          print('예약완료');
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              GoskiCard(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                            color: goskiLightGray,
                            border: Border(
                                bottom: BorderSide(
                              color: goskiDashGray,
                              width: 1.0, // 경계선 두께
                              style: BorderStyle.solid,
                            ))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoskiText(
                              text: tr(widget.teamName),
                              size: goskiFontLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Column(
                          children: widget.teamImages
                              .map((imagePath) => Image.asset(
                                    imagePath,
                                    width: double.infinity,
                                  ))
                              .toList(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                screenSizeController.getWidthByRatio(0.05),
                            vertical:
                                screenSizeController.getWidthByRatio(0.03),
                          ),
                          child: GoskiText(
                              text: widget.description, size: goskiFontSmall),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GoskiCard(
                child: ListTileTheme(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  horizontalTitleGap: 0,
                  minLeadingWidth: 0,
                  dense: true,
                  child: ExpansionTile(
                    collapsedShape: RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    title: GoskiText(
                      text: tr('instructorList'),
                      size: goskiFontMedium,
                    ),
                    subtitle: GoskiText(
                      text: tr('ifSelectInstructor'),
                      size: goskiFontSmall,
                      color: goskiDarkGray,
                    ),
                    children: widget.instructors.asMap().entries.map((entry) {
                      int index = entry.key;
                      Instructor instructor = entry.value;
                      return GestureDetector(
                        onTap: () {
                          print("강사 : ${instructor.name}, index : $index");
                        },
                        child: GoskiInstructorCard(
                          name: instructor.name,
                          position: instructor.position,
                          badgeColor: instructor.badgeColor,
                          description: instructor.description,
                          imagePath: instructor.imagePath,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class Instructor {
  final String position;
  final Color badgeColor;
  final String name;
  final String description;
  final String imagePath;

  Instructor({
    required this.position,
    required this.badgeColor,
    required this.name,
    required this.description,
    this.imagePath = 'assets/images/penguin.png',
  });
}
