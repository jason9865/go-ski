import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/data/model/instructor.dart';
import 'package:goski_student/data/model/reservation.dart';
import 'package:goski_student/main.dart';
import 'package:goski_student/ui/component/goski_border_white_container.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_expansion_tile.dart';
import 'package:goski_student/ui/component/goski_modal.dart';
import 'package:goski_student/ui/component/goski_payment_button.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/ui/component/goski_textfield.dart';
import 'package:goski_student/ui/reservation/d_u024_input_student_info.dart';
import 'package:goski_student/view_model/lesson_payment_view_model.dart';
import 'package:goski_student/view_model/reservation_view_model.dart';
import 'package:goski_student/view_model/student_info_view_model.dart';

final ReservationViewModel reservationViewModel =
    Get.find<ReservationViewModel>();
final StudentInfoViewModel studentInfoViewModel =
    Get.find<StudentInfoViewModel>();
final LessonPaymentViewModel lessonPaymentViewModel =
    Get.find<LessonPaymentViewModel>();

class LessonReservationScreen extends StatefulWidget {
  bool isCouponSelected = false;

  final List<_DummyPolicy> policyList = [
    _DummyPolicy(title: tr('policyCheckAll'), isChecked: false),
    _DummyPolicy(
        title: tr('policyCheckPrivacyCollectAndUse'), isChecked: false),
    _DummyPolicy(title: tr('policyCheckProvideOther'), isChecked: false),
    _DummyPolicy(title: tr('policyMarketing'), isChecked: false),
  ];

  BeginnerResponse? teamInformation;
  Instructor? instructor;

  LessonReservationScreen({
    this.teamInformation,
    this.instructor,
    super.key,
  });

  @override
  State<LessonReservationScreen> createState() =>
      _LessonReservationScreenState();
}

class _LessonReservationScreenState extends State<LessonReservationScreen> {
  final formatter = NumberFormat.simpleCurrency(locale: 'ko');
  // TODO: 네이버 페이 추가시 Enum으로 변경하는 것이 좋을 것으로 예상
  String payment = tr('kakaoPay');
  String requestComplain = '';

  void onPolicyCheckboxClicked(_DummyPolicy item, int index, bool value) {
    if (index == 0) {
      for (_DummyPolicy policy in widget.policyList) {
        policy.isChecked = value;
      }
    } else {
      item.isChecked = value;
      bool checkedAll = true;

      for (int i = 1; i < widget.policyList.length; i++) {
        if (!widget.policyList[i].isChecked) {
          checkedAll = false;
          break;
        }
      }
      widget.policyList[0].isChecked = checkedAll;
    }
  }

  @override
  void initState() {
    studentInfoViewModel.clearData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titlePadding = screenSizeController.getHeightByRatio(0.010);
    final contentPadding = screenSizeController.getHeightByRatio(0.015);
    final cardPadding = screenSizeController.getWidthByRatio(0.03);
    final checkboxSize = screenSizeController.getWidthByRatio(0.05);
    final reservationInfo = reservationViewModel.reservation.value;

    // final List<_AmountOfPayment> amountOfPaymentList = widget.instructor !=
    //             null &&
    //         widget.teamInformation != null
    //     ? [
    //         _AmountOfPayment(name: '강습료', price: widget.teamInformation!.cost),
    //         _AmountOfPayment(
    //             name: '강사 지정료', price: widget.instructor!.designatedFee),
    //       ]
    //     : [
    //         _AmountOfPayment(name: '강습료', price: widget.teamInformation!.cost),
    //       ];
    List<AmountOfPayment> amountOfPaymentList = [];
    if (widget.instructor != null && widget.teamInformation != null) {
      amountOfPaymentList = [
        AmountOfPayment(name: tr('cost'), price: widget.teamInformation!.cost),
        AmountOfPayment(
            name: tr('designatedCost'),
            price: widget.instructor!.designatedFee),
      ];
    } else if (widget.teamInformation != null) {
      amountOfPaymentList = [
        AmountOfPayment(name: tr('cost'), price: widget.teamInformation!.cost),
      ];
    } else if (widget.teamInformation == null && widget.instructor != null) {
      amountOfPaymentList = [
        AmountOfPayment(
            name: tr('cost'),
            price: (widget.instructor!.basicFee +
                    widget.instructor!.peopleOptionFee) *
                reservationViewModel.reservation.value.duration),
        AmountOfPayment(
            name: tr('designatedCost'),
            price: widget.instructor!.designatedFee),
        AmountOfPayment(
            name: tr('levelOptionCost'),
            price: widget.instructor!.levelOptionFee *
                reservationViewModel.reservation.value.duration),
      ];
    }
    int sum() {
      int sum = 0;
      for (int i = 0; i < amountOfPaymentList.length; i++) {
        sum += amountOfPaymentList[i].price;
      }

      return sum;
    }

    return Scaffold(
      appBar: GoskiSubHeader(
        title: tr('reservation'),
      ),
      body: GoskiContainer(
        buttonName: tr('letReservation'),
        onConfirm: () {
          if (widget.policyList[1].isChecked &&
              widget.policyList[2].isChecked &&
              studentInfoViewModel.studentInfoList.length ==
                  reservationInfo.studentCount) {
            if (widget.instructor != null && widget.teamInformation != null) {
              // 팀, 지정강사 다 있는경우 -> 초급, 지정강사 강습
              lessonPaymentViewModel.instLessonPayment(
                  reservationInfo,
                  widget.teamInformation!,
                  widget.instructor!,
                  studentInfoViewModel.studentInfoList,
                  requestComplain,
                  context);
            } else if (widget.instructor == null &&
                widget.teamInformation != null) {
              // 팀만 있고, 지정강사는 없는경우 -> 초급, 팀 강습
              lessonPaymentViewModel.teamLessonPayment(
                  reservationInfo,
                  widget.teamInformation!,
                  studentInfoViewModel.studentInfoList,
                  requestComplain,
                  context);
            } else if (widget.instructor != null &&
                widget.teamInformation == null) {
              // 팀은 없고, 강사만 있는 경우 -> 중급, 고급 지정 강습
              lessonPaymentViewModel.advancedLessonPayment(
                  reservationInfo,
                  widget.instructor!,
                  studentInfoViewModel.studentInfoList,
                  requestComplain,
                  context);
            }
          } else if (studentInfoViewModel.studentInfoList.length !=
              reservationInfo.studentCount) {
            showCompleteStudentInfoDialog(context);
          } else if (!widget.policyList[1].isChecked ||
              !widget.policyList[2].isChecked) {
            showPolicyAgreementDialog(context);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 예약 정보
              GoskiCard(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GoskiText(
                        text: tr('reservationInfo'),
                        size: goskiFontLarge,
                        isBold: true,
                      ),
                      SizedBox(height: titlePadding),
                      GoskiExpansionTile(
                        title: GoskiText(
                          text: tr('refundPolicy'),
                          size: goskiFontSmall,
                        ),
                        children: [
                          GoskiText(
                            text: tr('refundPolicyDetail'),
                            size: goskiFontSmall,
                          ),
                        ],
                      ),
                      SizedBox(height: contentPadding),
                      if (widget.teamInformation != null)
                        GoskiText(
                          text: tr(widget.teamInformation!.teamName),
                          size: goskiFontMedium,
                        ),
                      if (widget.teamInformation == null &&
                          widget.instructor != null)
                        GoskiText(
                          text: tr(widget.instructor!.teamName),
                          size: goskiFontMedium,
                        ),
                      if (widget.instructor != null)
                        GoskiText(
                          text: tr('designatedInstructor',
                              args: [widget.instructor!.userName]),
                          size: goskiFontMedium,
                        ),
                      SizedBox(height: contentPadding),
                      GoskiText(
                        text: tr('date'),
                        size: goskiFontSmall,
                        color: goskiDarkGray,
                      ),
                      GoskiText(
                        text: formatSessionTime(
                          reservationInfo.lessonDate,
                          reservationInfo.startTime,
                          reservationInfo.duration,
                        ),
                        size: goskiFontMedium,
                      ),
                      SizedBox(height: contentPadding),
                      GoskiText(
                        text: tr('studentNumber'),
                        size: goskiFontSmall,
                        color: goskiDarkGray,
                      ),
                      GoskiText(
                        text: tr('hintStudentCount',
                            args: [reservationInfo.studentCount.toString()]),
                        size: goskiFontMedium,
                      ),
                      SizedBox(height: contentPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (widget.teamInformation != null)
                            GoskiText(
                              text: tr('price', args: [
                                NumberFormat('###,###,###').format(sum())
                              ]),
                              size: goskiFontMedium,
                              isBold: true,
                            ),
                          if (widget.teamInformation == null &&
                              widget.instructor != null)
                            GoskiText(
                              text: tr('price', args: [
                                NumberFormat('###,###,###').format((widget
                                                .instructor!.basicFee +
                                            widget.instructor!.peopleOptionFee +
                                            widget.instructor!.levelOptionFee) *
                                        reservationInfo.duration +
                                    widget.instructor!.designatedFee)
                              ]),
                              size: goskiFontMedium,
                              isBold: true,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // 수강생 정보
              Obx(() => GoskiCard(
                    child: Padding(
                      padding: EdgeInsets.all(cardPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GoskiText(
                            text: tr('studentInfo'),
                            size: goskiFontLarge,
                            isBold: true,
                          ),
                          SizedBox(height: titlePadding),
                          GoskiText(
                            text: tr('reservationPeopleCount', args: [
                              studentInfoViewModel.studentInfoList.length
                                  .toString(),
                              reservationInfo.studentCount.toString()
                            ]),
                            size: goskiFontMedium,
                            isBold: true,
                          ),
                          SizedBox(height: titlePadding),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                studentInfoViewModel.studentInfoList.length,
                            itemBuilder: (context, index) {
                              var item =
                                  studentInfoViewModel.studentInfoList[index];

                              return Obx(() => GoskiExpansionTile(
                                    title: GoskiText(
                                      text: '${index + 1}. ${item.name}',
                                      size: goskiFontMedium,
                                    ),
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              GoskiText(
                                                text: '${tr(item.age)} / ',
                                                size: goskiFontMedium,
                                              ),
                                              GoskiText(
                                                text: tr(item.gender),
                                                size: goskiFontMedium,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              GoskiText(
                                                text: '${tr(item.height)} / ',
                                                size: goskiFontMedium,
                                              ),
                                              GoskiText(
                                                text: '${tr(item.weight)} / ',
                                                size: goskiFontMedium,
                                              ),
                                              GoskiText(
                                                text: tr('footSize', args: [
                                                  item.footSize.toString()
                                                ]),
                                                size: goskiFontMedium,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            studentInfoViewModel.studentInfoList
                                                .removeAt(index);
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: screenSizeController
                                                  .getWidthByRatio(0.01)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GoskiText(
                                                text: tr('delete'),
                                                size: goskiFontMedium,
                                                color: goskiDarkGray,
                                                textDecoration:
                                                    TextDecoration.underline,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ));
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: titlePadding);
                            },
                          ),
                          SizedBox(height: titlePadding),
                          if (studentInfoViewModel.studentInfoList.length <
                              reservationInfo.studentCount)
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => GoskiModal(
                                    title: tr('inputStudentInfo'),
                                    child: const InputStudentInfoDialog(),
                                  ),
                                );
                              },
                              child: GoskiBorderWhiteContainer(
                                child: GoskiText(
                                  text: tr('addAccount'),
                                  size: goskiFontMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )),
              // 요청사항
              GoskiCard(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GoskiText(
                        text: tr('requestMessage'),
                        size: goskiFontLarge,
                        isBold: true,
                      ),
                      SizedBox(height: titlePadding),
                      GoskiTextField(
                        hintText: tr('hintRequestMessage'),
                        hasInnerPadding: false,
                        maxLines: 5,
                        minLines: 1,
                        onTextChange: (text) {
                          setState(() {
                            requestComplain = text;
                          });
                        },
                        isNewLine: true,
                      ),
                    ],
                  ),
                ),
              ),
              // // 쿠폰 선택
              // GoskiCard(
              //   child: Padding(
              //     padding: EdgeInsets.all(cardPadding),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             GoskiText(
              //               text: tr('coupon'),
              //               size: goskiFontLarge,
              //               isBold: true,
              //             ),
              //             GoskiText(
              //               text: tr('couponSelectCount', args: ['3']),
              //               size: goskiFontMedium,
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: titlePadding),
              //         InkWell(
              //           onTap: () {
              //             setState(() {
              //               widget.isCouponSelected = !widget.isCouponSelected;
              //             });
              //           },
              //           child: GoskiBorderWhiteContainer(
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 GoskiText(
              //                   text: widget.isCouponSelected
              //                       ? tr('discount', args: ['20,000'])
              //                       : tr('hintSelectCoupon'),
              //                   size: goskiFontMedium,
              //                   color: widget.isCouponSelected
              //                       ? goskiLightPink
              //                       : goskiDarkGray,
              //                   isBold: widget.isCouponSelected,
              //                 ),
              //                 const Icon(
              //                     size: goskiFontLarge,
              //                     Icons.keyboard_arrow_right)
              //               ],
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // 결제 금액 확인
              GoskiCard(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GoskiText(
                        text: tr('confirmAmountOfPayment'),
                        size: goskiFontLarge,
                        isBold: true,
                      ),
                      SizedBox(height: titlePadding),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: amountOfPaymentList.length,
                        itemBuilder: (context, index) {
                          AmountOfPayment item = amountOfPaymentList[index];

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GoskiText(
                                text: item.name,
                                size: goskiFontMedium,
                              ),
                              GoskiText(
                                text: tr(
                                  'price',
                                  args: [
                                    index != 0 && item.price > 0
                                        ? '+${formatter.format(item.price)}'
                                        : formatter.format(item.price)
                                  ],
                                ),
                                size: goskiFontMedium,
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: titlePadding / 2);
                        },
                      ),
                      Divider(
                        thickness: 1,
                        height: contentPadding * 2,
                        color: goskiBlack,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GoskiText(
                            text: tr('amountOfPayment'),
                            size: goskiFontMedium,
                            isBold: true,
                          ),
                          GoskiText(
                            text:
                                tr('price', args: [(formatter.format(sum()))]),
                            size: goskiFontMedium,
                            isBold: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // 결제 수단
              GoskiCard(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GoskiText(
                        text: tr('paymentType'),
                        size: goskiFontLarge,
                        isBold: true,
                      ),
                      SizedBox(height: titlePadding),
                      RadioListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.zero,
                        activeColor: goskiBlack,
                        title: GoskiPaymentButton(
                          width: screenSizeController.getWidthByRatio(1),
                          text: tr('kakaoPay'),
                          imagePath: 'assets/images/kakaopay_button_image.png',
                          backgroundColor: kakaoYellow,
                          foregroundColor: goskiBlack,
                          onTap: () {},
                        ),
                        value: tr('kakaoPay'),
                        onChanged: (value) {},
                        groupValue: payment,
                      ),
                      SizedBox(height: titlePadding),
                      // GoskiPaymentButton(
                      //   width: screenSizeController.getWidthByRatio(1),
                      //   text: tr('naverPay'),
                      //   // TODO. 네이버페이 버튼으로 변경 필요
                      //   imagePath: 'assets/images/person2.png',
                      //   backgroundColor: naverPayGreen,
                      //   foregroundColor: goskiWhite,
                      //   onTap: () {},
                      // ),
                    ],
                  ),
                ),
              ),
              GoskiCard(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.policyList.length,
                    itemBuilder: (context, index) {
                      _DummyPolicy item = widget.policyList[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            onPolicyCheckboxClicked(
                                item, index, !item.isChecked);
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: contentPadding),
                          child: Row(
                            children: [
                              SizedBox(
                                width: checkboxSize,
                                height: checkboxSize,
                                child: Checkbox(
                                  activeColor: goskiBlack,
                                  visualDensity: VisualDensity.compact,
                                  value: item.isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      onPolicyCheckboxClicked(
                                          item, index, value!);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: titlePadding),
                              GoskiText(
                                text: item.title,
                                size: goskiFontMedium,
                                isBold: index == 0 ? true : false,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: contentPadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}

class TextWithIconRow extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onClicked;

  const TextWithIconRow({
    super.key,
    required this.text,
    required this.icon,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Row(
        children: [
          Expanded(
            child: GoskiText(
              text: text,
              size: goskiFontMedium,
            ),
          ),
          Icon(
            size: goskiFontLarge,
            icon,
          ),
        ],
      ),
    );
  }
}

class AmountOfPayment {
  final String name;
  final int price;

  AmountOfPayment({
    required this.name,
    required this.price,
  });
}

class _DummyPolicy {
  final String title;
  bool isChecked;

  _DummyPolicy({
    required this.title,
    required this.isChecked,
  });
}

String formatSessionTime(String lessonDate, String startTime, int duration) {
  int hour = int.parse(startTime.substring(0, 2));
  int minute = int.parse(startTime.substring(2, 4));
  DateTime startDateTime = DateTime(0, 0, 0, hour, minute);

  // Calculate end time by adding the duration in hours
  DateTime endDateTime = startDateTime.add(Duration(hours: duration));

  // Formatter for time in hh:mm format
  DateFormat timeFormatter = DateFormat('HH:mm');

  // Format the start and end time
  String formattedStartTime = timeFormatter.format(startDateTime);
  String formattedEndTime = timeFormatter.format(endDateTime);

  // Return the formatted string
  return '$lessonDate\n$formattedStartTime ~ $formattedEndTime';
}

void showPolicyAgreementDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: GoskiText(
          text: tr('policyAgreementRequire'),
          size: goskiFontLarge,
        ),
        content: GoskiText(
          text: tr('pleaseCheckPolicy'),
          size: goskiFontMedium,
        ),
        actions: <Widget>[
          TextButton(
            child: GoskiText(
              text: tr('confirm'),
              size: goskiFontMedium,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}

void showCompleteStudentInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: GoskiText(
          text: tr('incompleteInformation'),
          size: goskiFontLarge,
        ),
        content: GoskiText(
          text: tr('pleaseEnterStudentInfo'),
          size: goskiFontMedium,
        ),
        actions: <Widget>[
          TextButton(
            child: GoskiText(
              text: tr('confirm'),
              size: goskiFontMedium,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
