import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_dropdown.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class CancelLessonScreen extends StatelessWidget {
  const CancelLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _Reservation reservation = _Reservation(
      resortName: '지산스키장',
      teamName: '고승민의 스키교실',
      instructorName: '고승민',
      startTime: DateTime(2024, 1, 1, 15, 0),
      endTime: DateTime(2024, 1, 1, 17, 0),
      numberOfStudents: 3,
      payment: 160000,
      charge: 48000,
      finalPrice: 112000,
    );

    return Scaffold(
      appBar: GoskiSubHeader(
        title: tr('cancelLesson'),
      ),
      body: GoskiContainer(
        buttonName: "cancelLesson",
        onConfirm: () {
          //TODO. 예약 취소 기능
          print("예약취소");
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GoskiCard(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoskiText(
                              text: tr('reservationInfo'),
                              size: goskiFontLarge,
                              isBold: true,
                            )
                          ]),
                      BuildInterval(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GoskiText(
                                    text: tr(reservation.resortName),
                                    size: goskiFontMedium),
                                GoskiText(
                                    text: tr(' - '), size: goskiFontMedium),
                                GoskiText(
                                    text: tr(reservation.teamName),
                                    size: goskiFontMedium),
                              ],
                            ),
                            Row(
                              children: [
                                GoskiText(
                                    text: tr('designatedInstructor',
                                        args: [reservation.instructorName]),
                                    size: goskiFontMedium),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GoskiText(
                              text: tr('date'),
                              size: goskiFontSmall,
                              color: goskiDarkGray,
                            ),
                            dateRow(reservation),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GoskiText(
                              text: tr('studentNumber'),
                              size: goskiFontSmall,
                              color: goskiDarkGray,
                            ),
                            GoskiText(
                                text: tr(
                                    '${reservation.numberOfStudents.toString()} 명'),
                                size: goskiFontMedium),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GoskiText(
                              text: tr('paymentAmount'),
                              size: goskiFontMedium,
                            ),
                            GoskiText(
                              text: tr('moneyUnit',
                                  args: [reservation.payment.toString()]),
                              size: goskiFontMedium,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BuildInterval(),
              //TODO. 환불 규정 안내 추가
              GoskiDropdown(
                hint: tr("환불 규정 안내"),
                list: [" ", " "],
                selected: null,
                onSelected: (idx) {  },
              ),
              BuildInterval(),
              GoskiCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GoskiText(
                        text: tr("checkRefund"),
                        size: goskiFontMedium,
                        isBold: true,
                      ),
                      BuildInterval(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GoskiText(
                              text: tr('paymentAmount'), size: goskiFontMedium),
                          GoskiText(
                              text: tr('moneyUnit',
                                  args: [reservation.payment.toString()]),
                              size: goskiFontMedium),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GoskiText(
                              text: tr('refundCharge'), size: goskiFontMedium),
                          GoskiText(
                              text: tr('moneyUnit',
                                  args: [reservation.charge.toString()]),
                              size: goskiFontMedium),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        height: 15,
                        color: goskiDashGray,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GoskiText(
                            text: tr('expectedRefund'),
                            size: goskiFontMedium,
                          ),
                          GoskiText(
                            text: tr('moneyUnit',
                                args: [reservation.finalPrice.toString()]),
                            size: goskiFontMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget dateRow(_Reservation reservation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GoskiText(
          text: DateFormat('yyyy.MM.dd (E)')
              .format(reservation.startTime)
              .toString(),
          size: goskiFontMedium,
        ),
        Row(
          children: [
            GoskiText(
              text:
                  DateFormat('HH:mm').format(reservation.startTime).toString(),
              size: goskiFontMedium,
            ),
            GoskiText(
              text: DateFormat('~HH:mm').format(reservation.endTime).toString(),
              size: goskiFontMedium,
            ),
          ],
        )
      ],
    );
  }
}

class _Reservation {
  final String resortName;
  final String teamName;
  final String instructorName;
  final DateTime startTime;
  final DateTime endTime;
  final int numberOfStudents;
  final int payment;
  final int charge;
  final int finalPrice;

  _Reservation({
    required this.resortName,
    required this.teamName,
    required this.instructorName,
    required this.startTime,
    required this.endTime,
    required this.numberOfStudents,
    required this.payment,
    required this.charge,
    required this.finalPrice,
  });
}
