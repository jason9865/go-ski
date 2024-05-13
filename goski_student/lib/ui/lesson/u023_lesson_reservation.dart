import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/data/model/instructor.dart';
import 'package:goski_student/data/model/reservation.dart';
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
    _DummyPolicy(title: '약관 전체 동의', isChecked: false),
    _DummyPolicy(title: '[필수] 개인정보 수집 및 이용', isChecked: false),
    _DummyPolicy(title: '[필수] 개인정보 제 3자 제공', isChecked: false),
    _DummyPolicy(title: '[선택] 마케팅 수신 동의', isChecked: false),
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
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    final titlePadding = screenSizeController.getHeightByRatio(0.010);
    final contentPadding = screenSizeController.getHeightByRatio(0.015);
    final cardPadding = screenSizeController.getWidthByRatio(0.03);
    final checkboxSize = screenSizeController.getWidthByRatio(0.05);
    final reservationInfo = reservationViewModel.reservation.value;
    String requestComplain = '';
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
    List<_AmountOfPayment> amountOfPaymentList = [];
    if (widget.instructor != null && widget.teamInformation != null) {
      amountOfPaymentList = [
        _AmountOfPayment(name: '강습료', price: widget.teamInformation!.cost),
        _AmountOfPayment(
            name: '강사 지정료', price: widget.instructor!.designatedFee),
      ];
    } else if (widget.teamInformation != null) {
      amountOfPaymentList = [
        _AmountOfPayment(name: '강습료', price: widget.teamInformation!.cost),
      ];
    } else if (widget.teamInformation == null && widget.instructor != null) {
      amountOfPaymentList = [
        _AmountOfPayment(
            name: '강습료',
            price: widget.instructor!.cost - widget.instructor!.designatedFee),
        _AmountOfPayment(
            name: '강사 지정료', price: widget.instructor!.designatedFee)
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
                  requestComplain);
            } else if (widget.instructor == null &&
                widget.teamInformation != null) {
              // 팀만 있고, 지정강사는 없는경우 -> 초급, 팀 강습
              lessonPaymentViewModel.teamLessonPayment(
                  reservationInfo,
                  widget.teamInformation!,
                  studentInfoViewModel.studentInfoList,
                  requestComplain);
            } else if (widget.instructor != null &&
                widget.teamInformation == null) {
              // 팀은 없고, 강사만 있는 경우 -> 중급, 고급 지정 강습
              // TODO. 중,고급 강습 결제
            }
          } else if (!widget.policyList[1].isChecked ||
              !widget.policyList[2].isChecked) {
            //TODO. 필수약관 동의해주세요 Dialog
          } else if (studentInfoViewModel.studentInfoList.length !=
              reservationInfo.studentCount) {
            //TODO. 강습생 정보를 모두 입력해주세요 Dialog
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
                              args: [widget.instructor!.userName ?? '']),
                          size: goskiFontMedium,
                        ),
                      SizedBox(height: contentPadding),
                      GoskiText(
                        text: tr('date'),
                        size: goskiFontSmall,
                        color: goskiDarkGray,
                      ),
                      GoskiText(
                        //TODO. 일자, 시간 이쁘게 나오게 수정
                        text:
                            '${reservationInfo.lessonDate}\n${reservationInfo.startTime} ~ 17:00',
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
                                NumberFormat('###,###,###')
                                    .format(widget.teamInformation!.cost)
                              ]),
                              size: goskiFontMedium,
                              isBold: true,
                            ),
                          if (widget.teamInformation == null &&
                              widget.instructor != null)
                            GoskiText(
                              text: tr('price', args: [
                                NumberFormat('###,###,###')
                                    .format(widget.instructor!.cost)
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
                                  .toString()
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
                          requestComplain = text;
                        },
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
                          _AmountOfPayment item = amountOfPaymentList[index];

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
                      GoskiPaymentButton(
                        width: screenSizeController.getWidthByRatio(1),
                        text: tr('kakaoPay'),
                        imagePath: 'assets/images/person1.png',
                        // TODO. 카카오페이 버튼으로 변경 필요
                        backgroundColor: kakaoYellow,
                        foregroundColor: goskiBlack,
                        onTap: () {},
                      ),
                      SizedBox(height: titlePadding),
                      // GoskiPaymentButton(
                      //   width: screenSizeController.getWidthByRatio(1),
                      //   text: tr('naverPay'),
                      //   imagePath: 'assets/images/person2.png',
                      //   // TODO. 네이버페이 버튼으로 변경 필요
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

class _AmountOfPayment {
  final String name;
  final int price;

  _AmountOfPayment({
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
