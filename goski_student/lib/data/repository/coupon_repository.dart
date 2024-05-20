import 'package:get/get.dart';
import 'package:goski_student/data/data_source/coupon_service.dart';
import 'package:goski_student/data/model/coupon_response.dart';

class CouponRepository {
  final CouponService couponService = Get.find();

  Future<List<Coupon>> getCouponList() async {
    List<CouponResponse> response = await couponService.getCouponList();

    return response
        .map<Coupon>((couponResponse) => couponResponse.toCoupon())
        .toList();
  }
}
