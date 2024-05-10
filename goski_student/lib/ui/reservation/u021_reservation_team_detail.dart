
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/data/model/instructor.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_instructor_card.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/view_model/reservation_view_model.dart';

final BeginnerInstructorListViewModel beginnerInstructorListViewModel =
    Get.find<BeginnerInstructorListViewModel>();
final ReservationViewModel reservationViewModel =
    Get.find<ReservationViewModel>();

class ReservationTeamDetailScreen extends StatefulWidget {
  final int teamId;
  final String teamName;
  final List<TeamImage> teamImages;
  final String description;
  final int cost;
  final List<int> instructors;

  const ReservationTeamDetailScreen(
      {super.key,
      required this.teamId,
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
  void initState() {
    beginnerInstructorListViewModel.getBeginnerInstructorList(
        widget.instructors,
        reservationViewModel.reservation.value.studentCount,
        reservationViewModel.reservation.value.duration,
        reservationViewModel.reservation.value.level,
        widget.teamId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.e(beginnerInstructorListViewModel.instructors.length);

    return Scaffold(
      appBar: GoskiSubHeader(
        title: tr(widget.teamName),
      ),
      body: GoskiContainer(
          buttonName: tr('reserveTeam',
              args: [NumberFormat('###,###,###').format(widget.cost)]),
          onConfirm: () {
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
                                size: goskiFontXLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Column(
                            children: widget.teamImages
                                .map((teamImage) => Image.network(
                                      teamImage.teamImageUrl,
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
                                text: widget.description, size: goskiFontLarge),
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
                      collapsedShape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                      ),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                      ),
                      title: GoskiText(
                        text: tr('instructorList'),
                        size: goskiFontXLarge,
                      ),
                      subtitle: GoskiText(
                        text: tr('ifSelectInstructor'),
                        size: goskiFontMedium,
                        color: goskiDarkGray,
                      ),
                      children: beginnerInstructorListViewModel.instructors
                          .asMap()
                          .entries
                          .map((entry) {
                        Instructor instructor = entry.value;
                        String instPosition;
                        Color instbadgeColor;
                        switch (instructor.position) {
                          case 1:
                            instPosition = '사장';
                            instbadgeColor = goskiBlue;
                            break;
                          case 2:
                            instPosition = '교육팀장';
                            instbadgeColor = goskiBlue;
                            break;
                          case 3:
                            instPosition = '팀장';
                            instbadgeColor = goskiDarkPink;
                            break;
                          case 4:
                            instPosition = '강사';
                            instbadgeColor = goskiDarkGray;
                            break;
                          default:
                            instPosition = '강사';
                            instbadgeColor = goskiDarkGray;
                        }
                        return GestureDetector(
                          onTap: () {
                            // print("강사 : ${instructor.name}, index : $index");
                          },
                          child: GoskiInstructorCard(
                            name: instructor.userName,
                            position: instPosition,
                            badgeColor: instbadgeColor,
                            description: instructor.description,
                            imagePath: instructor.instructorUrl,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
