import 'package:get/get.dart';
import 'package:goski_instructor/data/data_source/coupon_service.dart';

import '../model/coupon_response.dart';

class CouponRepository {
  final CouponService couponService = Get.find();

  Future<List<Coupon>> getCouponList() async {
    List<CouponResponse> response = await couponService.getCouponList();

    return response
        .map<Coupon>((couponResponse) => couponResponse.toCoupon())
        .toList();
  }
}
