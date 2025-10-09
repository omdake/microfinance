// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

CouponModel couponModelFromJson(String str) =>
    CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  String? couponId;
  String? couponCode;
  String? couponDescription;
  String? couponImage;
  DateTime? validFrom;
  DateTime? validTo;
  dynamic maxCountToBeUsed;
  dynamic discountPercent;
  dynamic fixedDiscountAmount;
  dynamic storeId;
  dynamic minCartAmount;
  dynamic maxCouponDiscount;
  bool? isActive;

  CouponModel({
    this.couponId,
    this.couponCode,
    this.couponDescription,
    this.couponImage,
    this.validFrom,
    this.validTo,
    this.maxCountToBeUsed,
    this.discountPercent,
    this.fixedDiscountAmount,
    this.storeId,
    this.minCartAmount,
    this.maxCouponDiscount,
    this.isActive,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        couponId: json["CouponID"],
        couponCode: json["CouponCode"],
        couponDescription: json["CouponDescription"],
        couponImage: json["CouponImage"],
        validFrom: json["ValidFrom"] != null
            ? DateTime.parse(json["ValidFrom"])
            : null,
        validTo:
            json["ValidTo"] != null ? DateTime.parse(json["ValidTo"]) : null,
        maxCountToBeUsed: json["MaxCountToBeUsed"],
        discountPercent: json["DiscountPercent"],
        fixedDiscountAmount: json["FixedDiscountAmount"],
        storeId: json["StoreID"],
        minCartAmount: json["MinCartAmount"],
        maxCouponDiscount: json["MaxCouponDiscount"],
        isActive: json["IsActive"],
      );

  Map<String, dynamic> toJson() => {
        "CouponID": couponId,
        "CouponCode": couponCode,
        "CouponDescription": couponDescription,
        "CouponImage": couponImage,
        "ValidFrom": validFrom!.toIso8601String(),
        "ValidTo": validTo!.toIso8601String(),
        "MaxCountToBeUsed": maxCountToBeUsed,
        "DiscountPercent": discountPercent,
        "FixedDiscountAmount": fixedDiscountAmount,
        "StoreID": storeId,
        "MinCartAmount": minCartAmount,
        "MaxCouponDiscount": maxCouponDiscount,
        "IsActive": isActive,
      };
}
