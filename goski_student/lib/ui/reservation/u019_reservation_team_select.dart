import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_switch.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();
final screenSizeController = Get.find<ScreenSizeController>();

class ReservationTeamSelectScreen extends StatefulWidget {
  const ReservationTeamSelectScreen({super.key});

  @override
  State<ReservationTeamSelectScreen> createState() =>
      _ReservationTeamSelectScreenState();
}

class _ReservationTeamSelectScreenState
    extends State<ReservationTeamSelectScreen> {
  List<Team> teamList = [];
  final format = NumberFormat('###,###,###,###');
  @override
  void initState() {
    super.initState();
    teamList = fetchTeamList();
  }

  @override
  Widget build(BuildContext context) {
    return GoskiContainer(
      child: Column(
        children: [
          buildSwitch(),
          Expanded(
            child: ListView.builder(
                itemCount: teamList.length,
                itemBuilder: (context, index) {
                  return buildTeamCard(teamList[index]);
                }),
          ),
        ],
      ),
    );
  }

  List<Team> fetchTeamList() {
    List<Team> list = [];
    for (var item in dummy) {
      Team team = Team(
        teamName: item['teamName'],
        cost: item['cost'],
        teamProfileUrl: item['teamProfileUrl'],
        description: item['description'],
        rating: item['rating'],
        reviewCount: item['reviewCount'],
      );
      list.add(team);
    }
    return list;
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
      teamList.sort((a, b) => b.rating.compareTo(a.rating));
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

  Widget buildTeamCard(Team team) {
    return GestureDetector(
      onTap: () => logger.d("팀 상세 페이지로 이동"),
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
                        image: AssetImage(team.teamProfileUrl),
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
                                    text: team.rating.toString(),
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
                                text: '${format.format(team.cost).toString()}원',
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

List<Map<String, dynamic>> dummy = [
  {
    "teamName": "팀이름1",
    "cost": 180000,
    "teamProfileUrl": "assets/images/penguin.png",
    "description": "팀소개입니다.",
    "rating": 4.0,
    "reviewCount": 30,
  },
  {
    "teamName": "팀이름2",
    "cost": 170000,
    "teamProfileUrl": "assets/images/penguin.png",
    "description": "팀소개입니다.",
    "rating": 4.1,
    "reviewCount": 30,
  },
  {
    "teamName": "팀이름3",
    "cost": 160000,
    "teamProfileUrl": "assets/images/penguin.png",
    "description": "팀소개입니다.",
    "rating": 4.2,
    "reviewCount": 30,
  },
  {
    "teamName": "팀이름4",
    "cost": 150000,
    "teamProfileUrl": "assets/images/penguin.png",
    "description": "팀소개입니다.",
    "rating": 4.3,
    "reviewCount": 30,
  },
  {
    "teamName": "팀이름5",
    "cost": 140000,
    "teamProfileUrl": "assets/images/penguin.png",
    "description": "팀소개입니다.",
    "rating": 4.4,
    "reviewCount": 30,
  },
  {
    "teamName": "팀이름6",
    "cost": 130000,
    "teamProfileUrl": "assets/images/penguin.png",
    "description": "팀소개입니다.",
    "rating": 4.5,
    "reviewCount": 30,
  },
];

class Team {
  final String teamName;
  final int cost;
  final String teamProfileUrl;
  final String description;
  final double rating;
  final int reviewCount;

  Team({
    required this.teamName,
    required this.cost,
    required this.teamProfileUrl,
    required this.description,
    required this.rating,
    required this.reviewCount,
  });
}
