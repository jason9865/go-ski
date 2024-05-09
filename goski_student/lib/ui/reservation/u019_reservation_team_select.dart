import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_switch.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/reservation/u018_reservation_select.dart';
import 'package:goski_student/ui/reservation/u021_reservation_team_detail.dart';
import 'package:goski_student/view_model/reservation_view_model.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();
final ReservationViewModel reservationViewModel =
    Get.find<ReservationViewModel>();
final LessonTeamListViewModel lessonTeamListViewModel =
    Get.find<LessonTeamListViewModel>();

class ReservationTeamSelectScreen extends StatefulWidget {
  const ReservationTeamSelectScreen({super.key});

  @override
  State<ReservationTeamSelectScreen> createState() =>
      _ReservationTeamSelectScreenState();
}

class _ReservationTeamSelectScreenState
    extends State<ReservationTeamSelectScreen> {
  List<BeginnerResponse> teamList = lessonTeamListViewModel.lessonTeams;
  final format = NumberFormat('###,###,###,###');

  @override
  void initState() {
    lessonTeamListViewModel
        .getLessonTeamList(reservationViewModel.reservation.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoskiSubHeader(
        title: tr('selectTeam'),
      ),
      body: GoskiContainer(
        child: Column(
          children: [
            buildSwitch(),
            Obx(() => Expanded(
                  child: ListView.builder(
                      itemCount: teamList.length,
                      itemBuilder: (context, index) {
                        return buildTeamCard(teamList[index]);
                      }),
                )),
          ],
        ),
      ),
    );
  }

  void sortByLowerPrice() {
    setState(() {
      teamList.sort((a, b) => a.cost.compareTo(b.cost));
    });
  }

  void sortByHigherPrice() {
    setState(() {
      teamList.sort((a, b) => b.cost.compareTo(a.cost));
    });
  }

  void sortByRating() {
    setState(() {
      // teamList.sort((a, b) => b.rating.compareTo(a.rating));
      teamList.sort((a, b) {
        // Handle nulls first, assuming lower priority for nulls
        if (a.rating == null || b.rating == null) {
          return (a.rating == null) ? (b.rating == null ? 0 : 1) : -1;
        }
        // If both are non-null, use regular comparison
        return b.rating!.compareTo(a.rating!);
      });
    });
  }

  Widget buildSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(screenSizeController.getWidthByRatio(0.01)),
          child: GoskiSwitch(
            items: [
              tr('orderByLowerPrice'),
              tr('orderByHigherPrice'),
              tr('orderByStar')
            ],
            width: screenSizeController.getWidthByRatio(0.6),
            size: goskiFontSmall,
            onToggle: (index) {
              if (index == 0) {
                sortByLowerPrice();
              } else if (index == 1) {
                sortByHigherPrice();
              } else {
                sortByRating();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget buildTeamCard(BeginnerResponse team) {
    return GestureDetector(
      onTap: () {
        logger.d("팀 상세 페이지로 이동");
        Get.to(
            ReservationTeamDetailScreen(
              teamId: team.teamId,
              teamName: team.teamName,
              teamImages: team.teamImages,
              description: team.description,
              instructors: team.instructors,
              cost: team.cost,
            ), binding: BindingsBuilder(() {
          // Get.put(() => BeginnerInstructorListViewModel(), permanent: true);
          Get.lazyPut(() => BeginnerInstructorListViewModel());
        }));
      },
      child: Padding(
        padding: EdgeInsets.all(screenSizeController.getWidthByRatio(0.01)),
        child: GoskiCard(
          child: Container(
            color: goskiWhite,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(
                      screenSizeController.getWidthByRatio(0.02)),
                  child: Container(
                    width: screenSizeController.getWidthByRatio(0.25),
                    height: screenSizeController.getWidthByRatio(0.25),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        // image: Image.network(team.teamProfileUrl),
                        image: NetworkImage(team.teamProfileUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(
                        screenSizeController.getWidthByRatio(0.03)),
                    child: SizedBox(
                      height: screenSizeController.getWidthByRatio(0.25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GoskiText(
                                text: team.teamName,
                                size: goskiFontLarge,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    size: 18,
                                    color: goskiYellow,
                                    Icons.star,
                                  ),
                                  GoskiText(
                                    text: team.rating!.toStringAsFixed(1),
                                    size: goskiFontMedium,
                                  ),
                                  GoskiText(
                                    text: '(${team.reviewCount})',
                                    size: goskiFontMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: GoskiText(
                                    text: team.description,
                                    size: goskiFontMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GoskiText(
                                text: tr('moneyUnit',
                                    args: [team.cost.toString()]),
                                size: goskiFontLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
