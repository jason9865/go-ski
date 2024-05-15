import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/data/model/instructor.dart';
import 'package:goski_student/main.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_switch.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/reservation/u032_advanced_instructors_introduction.dart';
import 'package:goski_student/view_model/reservation_view_model.dart';

final ReservationViewModel reservationViewModel =
    Get.find<ReservationViewModel>();
final LessonInstructorListViewModel lessonInstructorListViewModel =
    Get.find<LessonInstructorListViewModel>();

class ReservationInstructorListScreen extends StatefulWidget {
  const ReservationInstructorListScreen({super.key});

  @override
  State<ReservationInstructorListScreen> createState() =>
      _ReservationInstructorListScreenState();
}

class _ReservationInstructorListScreenState
    extends State<ReservationInstructorListScreen> {
  List<Instructor> instructorList =
      lessonInstructorListViewModel.lessonInstructors;

  int currentSort = 0;

  void sortInstructors(int sortBy) {
    setState(() {
      if (sortBy == 0) {
        instructorList.sort((a, b) => a.cost.compareTo(b.cost));
      } else if (sortBy == 1) {
        instructorList.sort((a, b) => b.cost.compareTo(a.cost));
      } else if (sortBy == 2) {
        instructorList.sort((a, b) => b.rating!.compareTo(a.rating!));
      }
    });
  }

  @override
  void initState() {
    lessonInstructorListViewModel
        .getLessonInstructorList(reservationViewModel.reservation.value);
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
            Obx(() => Expanded(
                  child: ListView.builder(
                    itemCount: instructorList.length,
                    itemBuilder: (context, index) {
                      final instructor = instructorList[index];
                      return instructorCard(instructor);
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget instructorCard(Instructor instructor) {
    return GestureDetector(
      onTap: () {
        Get.to(AdvancedInstructorsIntroductionScreen(instructor: instructor));
      },
      child: GoskiCard(
        child: Container(
          // height: screenSizeController.getHeightByRatio(0.2),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  instructor.instructorUrl,
                  width: 90,
                  height: 120,
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
                                  args: [instructor.userName]),
                              size: goskiFontXLarge),
                          if (instructor.skiCertificate.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: GoskiText(
                                text: instructor.skiCertificate.first,
                                size: goskiFontMedium,
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
                            // child: Text(
                            //   instructor.description,
                            //   textScaleFactor: 1.0,
                            //   style: const TextStyle(fontSize: goskiFontLarge),
                            //   maxLines: 3,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                            child: GoskiText(
                              text: instructor.description,
                              size: goskiFontLarge,
                              maxLine: 3,
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
                                    '${instructor.rating?.toStringAsFixed(1)} (${instructor.reviewCount})',
                                size: goskiFontMedium)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: GoskiText(
                            text: tr('moneyUnit', args: [
                              NumberFormat('###,###,###')
                                  .format(instructor.cost)
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
      ),
    );
  }
}
