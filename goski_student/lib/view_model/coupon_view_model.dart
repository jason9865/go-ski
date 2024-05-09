import 'package:get/get.dart';
import 'package:goski_student/data/model/coupon_response.dart';
import 'package:goski_student/data/repository/coupon_repository.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class CouponViewModel extends GetxController {
  final CouponRepository couponRepository = Get.find();
  RxList<Coupon> couponList = <Coupon>[].obs;
  RxBool isLoading = false.obs;


  Future<void> getCouponList() async {
    isLoading.value = true;
    couponList.clear();

    List<Coupon> response = await couponRepository.getCouponList();

    couponList.addAll(response);
    isLoading.value = false;
  }
}