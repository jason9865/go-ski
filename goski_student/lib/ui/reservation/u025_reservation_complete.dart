import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/ui/component/goski_build_interval.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_text.dart';

class ReservationCompleteScreen extends StatefulWidget {
  final String resortName;
  final String teamName;
  final String instructorName;
  final DateTime startTime;
  final DateTime endTime;
  final int numberOfStudents;
  final int payment;

  const ReservationCompleteScreen({
    super.key,
    required this.resortName,
    required this.teamName,
    required this.instructorName,
    required this.startTime,
    required this.endTime,
    required this.numberOfStudents,
    required this.payment,
  });

  @override
  State<ReservationCompleteScreen> createState() =>
      _ReservationCompleteScreenState();
}

class _ReservationCompleteScreenState extends State<ReservationCompleteScreen> {
  final imageWidth = screenSizeController.getWidthByRatio(0.5);

  @override
  Widget build(BuildContext context) {
    return GoskiContainer(
      buttonName: "toMain",
      onConfirm: () {
        //TODO. 예약 취소 기능
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/penguin.png",
              width: imageWidth,
              height: imageWidth,
              fit: BoxFit.fitHeight,
            ),
            GoskiText(text: tr('completePayment'), size: goskiFontXLarge),
            const BuildInterval(),
            GoskiCard(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      GoskiText(
                        text: tr('reservationInfo'),
                        size: goskiFontLarge,
                        isBold: true,
                      )
                    ]),
                    const BuildInterval(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              GoskiText(
                                  text: tr(widget.resortName),
                                  size: goskiFontMedium),
                              GoskiText(text: tr(' - '), size: goskiFontMedium),
                              GoskiText(
                                  text: tr(widget.teamName),
                                  size: goskiFontMedium),
                            ],
                          ),
                          Row(
                            children: [
                              GoskiText(
                                  text: tr('designatedInstructor',
                                      args: [widget.instructorName]),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GoskiText(
                                text: DateFormat('yyyy.MM.dd (E)')
                                    .format(widget.startTime)
                                    .toString(),
                                size: goskiFontMedium,
                              ),
                              Row(
                                children: [
                                  GoskiText(
                                    text: DateFormat('HH:mm')
                                        .format(widget.startTime)
                                        .toString(),
                                    size: goskiFontMedium,
                                  ),
                                  GoskiText(
                                    text: DateFormat('~HH:mm')
                                        .format(widget.endTime)
                                        .toString(),
                                    size: goskiFontMedium,
                                  ),
                                ],
                              )
                            ],
                          )
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
                              text:
                                  tr('${widget.numberOfStudents.toString()} 명'),
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
                            text: tr('moneyUnit', args: [
                              NumberFormat('#,###').format(widget.payment)
                            ]),
                            size: goskiFontMedium,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
