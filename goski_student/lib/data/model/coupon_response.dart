import 'package:easy_localization/easy_localization.dart';

class CouponResponse {
  String name;
  int? discountAmount;
  int? discountRate;
  DateTime expirationDate;
  int couponCount;

  CouponResponse({
    required this.name,
    this.discountAmount,
    this.discountRate,
    required this.expirationDate,
    required this.couponCount,
  }) : assert(
          (discountAmount == null) != (discountRate == null),
          'discountAmount or discountRate 중 하나는 반드시 필요합니다.',
        );

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      name: json['name'] as String,
      discountAmount: json['discountAmount'] as int,
      discountRate: json['discountRate'] as int,
      expirationDate:
          DateFormat('yyMMdd').parse(json['expirationDate'] as String),
      couponCount: json['couponCount'] as int,
    );
  }

  @override
  String toString() {
    return 'CouponResponse{name: $name, discountAmount: $discountAmount, discountRate: $discountRate, expirationDate: $expirationDate, couponCount: $couponCount}';
  }
}

class Coupon {
  String name;
  int? discountAmount;
  int? discountRate;
  DateTime expirationDate;
  int couponCount;

  Coupon({
    required this.name,
    required this.discountAmount,
    required this.discountRate,
    required this.expirationDate,
    required this.couponCount,
  });

  @override
  String toString() {
    return 'Coupon{name: $name, discountAmount: $discountAmount, discountRate: $discountRate, expirationDate: $expirationDate, couponCount: $couponCount}';
  }
}

extension CouponResponseToCoupon on CouponResponse {
  Coupon toCoupon() {
    return Coupon(
      name: name,
      discountAmount: discountAmount,
      discountRate: discountRate,
      expirationDate: expirationDate,
      couponCount: couponCount,
    );
  }
}
