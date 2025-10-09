class ReferralListResponse {
  bool success;
  String message;
  List<Referral> referrals;

  ReferralListResponse({
    required this.success,
    required this.message,
    required this.referrals,
  });

  factory ReferralListResponse.fromJson(Map<String, dynamic> json) {
    return ReferralListResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      referrals: (json['response']['Table'] as List)
          .map((referral) => Referral.fromJson(referral))
          .toList(),
    );
  }
}

class Referral {
  String? referralID;
  String? clientID;
  String? title;
  String? firstName;
  String? lastName;
  String? emailID;
  String? phoneNo;
  String? referralCode;
  DateTime? referralSentOn;
  int? referralStatusID;
  String? registeredClientID;
  DateTime? registeredOn;
  String? orderID;
  DateTime? orderCreatedOn;
  String? couponID;
  String? referralStatus;
  String? couponCode;
  DateTime? validFrom;
  DateTime? validTo;
  String? referredByCouponStatus;
  String? referredToCouponStatus;

  Referral({
    this.referralID,
    this.clientID,
    this.title,
    this.firstName,
    this.lastName,
    this.emailID,
    this.phoneNo,
    this.referralCode,
    this.referralSentOn,
    this.referralStatusID,
    this.registeredClientID,
    this.registeredOn,
    this.orderID,
    this.orderCreatedOn,
    this.couponID,
    this.referralStatus,
    this.couponCode,
    this.validFrom,
    this.validTo,
    this.referredByCouponStatus,
    this.referredToCouponStatus
  });

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      referralID: json['ReferralID'] as String,
      clientID: json['ClientID'] as String,
      title: json['Title'] as String,
      firstName: json['FirstName'] as String,
      lastName: json['LastName'] as String,
      emailID: json['EmailID'] as String,
      phoneNo: json['PhoneNo'] as String,
      referralCode: json['ReferralCode'] as String,
      referralSentOn: DateTime.parse(json['ReferralSentOn'] as String),
      referralStatusID: json['ReferralStatusID'] as int,
      registeredClientID: json['RegisteredClientID'] as String?,
      registeredOn: json['RegisteredOn'] != null ? DateTime.parse(json['RegisteredOn'] as String) : null,
      orderID: json['OrderID'] as String?,
      orderCreatedOn: json['OrderCreatedOn'] != null ? DateTime.parse(json['OrderCreatedOn'] as String) : null,
      couponID: json['CouponID'] as String?,
      referralStatus: json['ReferralStatus'] as String,
      couponCode: json['CouponCode'] as String?,
      validFrom: json['ValidFrom'] != null ? DateTime.parse(json['ValidFrom'] as String) : null,
      validTo: json['ValidTo'] != null ? DateTime.parse(json['ValidTo'] as String) : null,
      referredByCouponStatus: json['referredByCouponStatus'] as String?,
      referredToCouponStatus: json['referredToCouponStatus'] as String?,
    );
  }
}
