import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_switch.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class ReservationInstructorListScreen extends StatefulWidget {
  const ReservationInstructorListScreen({super.key});

  @override
  State<ReservationInstructorListScreen> createState() =>
      _ReservationInstructorListScreenState();
}

class _ReservationInstructorListScreenState
    extends State<ReservationInstructorListScreen> {
  List<_Instructor> instructors = [
    _Instructor(
      position: '교육팀장',
      name: '고승민',
      description:
          '안녕하세요, 고승민입니다.안녕하세요, 고승민입니다.안녕하세요, 고승민입니다.안녕하세요, 고승민입니다.안녕하세요, 고승민입니다.안녕하세요, 고승민입니다.',
      certificateName: 'Level3',
      rating: 4.0,
      imagePath: 'assets/images/adv.jpg',
      reviewCount: 30,
      cost: 300000,
    ),
    _Instructor(
      position: '팀장',
      name: '임종율',
      description: '안녕하세요, 임종율입니다.안녕하세요, 임종율입니다',
      certificateName: 'Level3',
      imagePath: 'assets/images/person1.png',
      rating: 4.9,
      reviewCount: 30,
      cost: 250000,
    ),
    _Instructor(
      position: '코치',
      name: '김태훈',
      description: '안녕하세요, 김태훈입니다.',
      certificateName: 'Level2',
      imagePath: 'assets/images/person2.png',
      rating: 4.8,
      reviewCount: 30,
      cost: 180000,
    ),
    _Instructor(
      position: '코치',
      name: '김태훈',
      description: '안녕하세요, 김태훈입니다.',
      certificateName: 'Level2',
      imagePath: 'assets/images/person2.png',
      rating: 4.7,
      reviewCount: 30,
      cost: 180000,
    ),
    _Instructor(
      position: '코치',
      name: '김태훈',
      description: '안녕하세요, 김태훈입니다.',
      certificateName: 'Level2',
      imagePath: 'assets/images/person2.png',
      rating: 4.7,
      reviewCount: 29,
      cost: 180000,
    ),
    _Instructor(
      position: '코치',
      name: '김태훈',
      description: '안녕하세요, 김태훈입니다.',
      certificateName: 'Level2',
      imagePath: 'assets/images/person2.png',
      rating: 4.7,
      reviewCount: 31,
      cost: 150000,
    ),
    _Instructor(
      position: '코치',
      name: '김태훈',
      description: '안녕하세요, 김태훈입니다.',
      certificateName: 'Level2',
      imagePath: 'assets/images/person2.png',
      rating: 4.88564576234154,
      reviewCount: 30,
      cost: 160000,
    ),
  ];
  int currentSort = 0;

  void sortInstructors(int sortBy) {
    setState(() {
      if (sortBy == 0) {
        instructors.sort((a, b) => a.cost.compareTo(b.cost));
      } else if (sortBy == 1) {
        instructors.sort((a, b) => b.cost.compareTo(a.cost));
      } else if (sortBy == 2) {
        instructors.sort((a, b) => b.rating.compareTo(a.rating));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    sortInstructors(currentSort);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoskiSubHeader(
        title: tr('instructorList'),
      ),
      body: GoskiContainer(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GoskiSwitch(
                    items: [
                      tr('sortByLowPrice'),
                      tr('sortByHighPrice'),
                      tr('sortByRating')
                    ],
                    width: screenSizeController.getWidthByRatio(0.5),
                    onToggle: sortInstructors,
                    size: goskiFontSmall,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: instructors.length,
                itemBuilder: (context, index) {
                  final instructor = instructors[index];
                  return instructorCard(instructor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget instructorCard(_Instructor instructor) {
    return GoskiCard(
      child: Container(
        height: screenSizeController.getHeightByRatio(0.2),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                instructor.imagePath,
                width: 120,
                height: 160,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(width: screenSizeController.getWidthByRatio(0.03)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GoskiText(
                            text: tr('dynamicInstructor',
                                args: [instructor.name]),
                            size: goskiFontXLarge),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: GoskiText(
                            text: instructor.certificateName,
                            size: goskiFontLarge,
                            color: goskiDarkGray,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSizeController.getHeightByRatio(0.01),
                  ),
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            instructor.description,
                            textScaleFactor: 1.0,
                            style: const TextStyle(fontSize: goskiFontLarge),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenSizeController.getHeightByRatio(0.01),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: goskiYellow),
                          GoskiText(
                              text:
                                  '${instructor.rating.toStringAsFixed(1)} (${instructor.reviewCount})',
                              size: goskiFontMedium)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: GoskiText(
                          text: tr('moneyUnit', args: [
                            NumberFormat('###,###,###').format(instructor.cost)
                          ]),
                          size: goskiFontLarge,
                          isBold: true,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Instructor {
  final String name;
  final String position;
  final String certificateName;
  final String description;
  final double rating;
  final int reviewCount;
  final String imagePath;
  final int cost;

  _Instructor({
    required this.name,
    required this.position,
    required this.certificateName,
    required this.description,
    required this.rating,
    required this.reviewCount,
    required this.imagePath,
    required this.cost,
  });
}
