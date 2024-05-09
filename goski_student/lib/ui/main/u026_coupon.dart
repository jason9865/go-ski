import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goski_student/const/color.dart';
import 'package:goski_student/const/font_size.dart';
import 'package:goski_student/const/util/screen_size_controller.dart';
import 'package:goski_student/data/model/coupon_response.dart';
import 'package:goski_student/ui/component/goski_card.dart';
import 'package:goski_student/ui/component/goski_container.dart';
import 'package:goski_student/ui/component/goski_sub_header.dart';
import 'package:goski_student/ui/component/goski_text.dart';
import 'package:goski_student/view_model/coupon_view_model.dart';

class CouponScreen extends StatelessWidget {
  final CouponViewModel couponViewModel = Get.find();

  CouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSizeController = Get.find<ScreenSizeController>();
    RxList<Coupon> couponList = couponViewModel.couponList;

    return Obx(
          () {
        if (couponViewModel.isLoading.value) {
          return Scaffold(
            appBar: GoskiSubHeader(
              title: tr('couponBox'),
            ),
            body: const GoskiContainer(
              child: Center(
                child: CircularProgressIndicator(
                  color: goskiBlack,
                ),
              ),
            ),
          );
        } else if (couponList.isEmpty) {
          return Scaffold(
            appBar: GoskiSubHeader(
              title: tr('couponBox'),
            ),
            body: GoskiContainer(
              child: Center(
                child: GoskiText(
                  text: tr('noCoupon'),
                  size: goskiFontLarge,
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: GoskiSubHeader(
              title: tr('couponBox'),
            ),
            body: GoskiContainer(
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
                                    : tr('countUnit', args: [
                                  coupon.discountAmount.toString()
                                ])
                                    : '${coupon.discountRate}%',
                                size: goskiFontXXLarge,
                                color: goskiLightPink,
                              ),
                              GoskiText(
                                text: coupon.name,
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
            ),
          );
        }
      },
    );
  }
}
