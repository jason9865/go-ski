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
import 'package:goski_student/ui/component/goski_text.dart';

class CouponScreen extends StatelessWidget {
  final List<Coupon> couponList = [
    Coupon(
        couponName: '재강습 할인 쿠폰',
        discountAmount: 20000,
        discountRate: null,
        expirationDate: DateTime.now(),
        couponCount: 1),
    Coupon(
        couponName: '재강습 할인 쿠폰',
        discountAmount: 20000,
        discountRate: null,
        expirationDate: DateTime.now(),
        couponCount: 1),
    Coupon(
        couponName: '시즌 할인 쿠폰',
        discountAmount: null,
        discountRate: 10,
        expirationDate: DateTime.now(),
        couponCount: 1),
    Coupon(
        couponName: '신규 가입 쿠폰',
        discountAmount: 10000,
        discountRate: null,
        expirationDate: DateTime.now(),
        couponCount: 1),
    Coupon(
        couponName: '피드백 자동 생성 쿠폰',
        discountAmount: 1,
        discountRate: null,
        expirationDate: DateTime.now(),
        couponCount: 7),
  ];

  CouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();

    return GoskiContainer(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: couponList.length,
        itemBuilder: (BuildContext context, int index) {
          final coupon = couponList[index];

          return GoskiCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(
                      screenSizeController.getWidthByRatio(0.04)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GoskiText(
                        text: coupon.discountAmount != null
                            ? coupon.discountAmount != 1
                                ? tr('moneyUnit', args: [
                                    NumberFormat('#,###')
                                        .format(coupon.discountAmount)
                                  ])
                                : tr('countUnit',
                                    args: [coupon.discountAmount.toString()])
                            : '${coupon.discountRate}%',
                        size: goskiFontXXLarge,
                        color: goskiLightPink,
                      ),
                      GoskiText(
                        text: coupon.couponName,
                        size: goskiFontLarge,
                        color: goskiBlack,
                      ),
                      Row(
                        children: [
                          GoskiText(
                            text: tr('dueYear', args: [
                              DateFormat('yyyy')
                                  .format(coupon.expirationDate)
                                  .toString()
                            ]),
                            size: goskiFontSmall,
                            color: goskiDarkGray,
                          ),
                          GoskiText(
                            text: tr('dueMonth', args: [
                              DateFormat('MM')
                                  .format(coupon.expirationDate)
                                  .toString()
                            ]),
                            size: goskiFontSmall,
                            color: goskiDarkGray,
                          ),
                          GoskiText(
                            text: tr('dueDay', args: [
                              DateFormat('dd')
                                  .format(coupon.expirationDate)
                                  .toString()
                            ]),
                            size: goskiFontSmall,
                            color: goskiDarkGray,
                          )
                        ],
                      )
                    ],

                    //여기에는 쿠폰 내용 들어가면 됨
                  ),
                ),
                SizedBox(
                  width: screenSizeController.getWidthByRatio(0.2),
                  height: screenSizeController.getHeightByRatio(0.2),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        color: goskiLightGray,
                        border: Border(
                            left: BorderSide(
                          color: goskiDashGray,
                          width: 1.0, // 경계선 두께
                          style: BorderStyle.solid,
                        ))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GoskiText(
                          text: tr('couponCount',
                              args: [coupon.couponCount.toString()]),
                          size: goskiFontLarge,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

// 추후 API연동 후 response로 대체
class Coupon {
  final String couponName;
  final int? discountAmount;
  final int? discountRate;
  final DateTime expirationDate;
  final int couponCount;

  Coupon({
    required this.couponName,
    this.discountAmount,
    this.discountRate,
    required this.expirationDate,
    required this.couponCount,
  }) : assert(
          (discountAmount == null) != (discountRate == null),
          'discountAmount or discountRate 중 하나는 반드시 필요합니다.',
        );
}
