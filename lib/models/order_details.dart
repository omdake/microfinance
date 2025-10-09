// To parse this JSON data, do
//
//     final orderDetails = orderDetailsFromJson(jsonString);

import 'dart:convert';

OrderDetails orderDetailsFromJson(String str) =>
    OrderDetails.fromJson(json.decode(str));

String orderDetailsToJson(OrderDetails data) => json.encode(data.toJson());

class OrderDetails {
  String? orderId;
  String? clientId;
  String? orderNo;
  String? orderDate;
  double? orderamount;
  double? approvedAmount;
  double? revisedAmount;
  double? paymentAmount;
  double? extraChargeAmount;
  String? instructionForShopper;
  String? orderStoresId;
  String? cartOrderNumber;
  int? statusId;
  String? storeName;
  String? storeId;
  String? orderStatus;
  String? storeLogo;
  String? fileLocation;
  double? deliveryFee;
  double? serviceFee;
  double? longDistanceDeliveryFee;
  double? taxes;
  double? pickUpAssistFee;
  double? packagingFees;
  String? inStoreShoppingManagedBy;
  String? twilioConversationId;
  String? twilioParticipantId;
  String? participantIdentity;
  double? tipAmount;
  String? couponCode;
  double? discount;
  List<String>? productImage;

  OrderDetails({
    this.orderId,
    this.clientId,
    this.orderNo,
    this.orderDate,
    this.orderamount,
    this.approvedAmount,
    this.revisedAmount,
    this.paymentAmount,
    this.extraChargeAmount,
    this.instructionForShopper,
    this.orderStoresId,
    this.cartOrderNumber,
    this.statusId,
    this.storeName,
    this.storeId,
    this.orderStatus,
    this.storeLogo,
    this.fileLocation,
    this.deliveryFee,
    this.serviceFee,
    this.longDistanceDeliveryFee,
    this.taxes,
    this.pickUpAssistFee,
    this.packagingFees,
    this.inStoreShoppingManagedBy,
    this.twilioConversationId,
    this.twilioParticipantId,
    this.participantIdentity,
    this.tipAmount,
    this.couponCode,
    this.discount,
    this.productImage,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        orderId: json["OrderID"],
        clientId: json["ClientID"],
        orderNo: json["OrderNo"],
        orderDate: json["OrderDate"],
        orderamount: json["Orderamount"].toDouble(),
        approvedAmount: json["ApprovedAmount"].toDouble(),
        revisedAmount: json["RevisedAmount"].toDouble(),
        paymentAmount: json["PaymentAmount"],
        extraChargeAmount: json["ExtraChargeAmount"],
        instructionForShopper: json["InstructionForShopper"],
        orderStoresId: json["OrderStoresID"],
        cartOrderNumber: json["CartOrderNumber"],
        statusId: json["StatusID"],
        storeName: json["StoreName"],
        storeId: json["StoreID"],
        orderStatus: json["OrderStatus"],
        storeLogo: json["StoreLogo"],
        fileLocation: json["FileLocation"],
        deliveryFee: json["DeliveryFee"],
        serviceFee: json["ServiceFee"],
        longDistanceDeliveryFee: json["LongDistanceDeliveryFee"],
        taxes: json["Taxes"],
        pickUpAssistFee: json["PickUpAssistFee"],
        packagingFees: json["PackagingFees"],
        inStoreShoppingManagedBy: json["InStoreShoppingManagedBy"],
        twilioConversationId: json["TwilioConversationId"],
        twilioParticipantId: json["TwilioParticipantId"],
        participantIdentity: json["ParticipantIdentity"],
        tipAmount: json["TipAmount"],
        couponCode: json["CouponCode"],
        discount: json["Discount"],
        productImage: List<String>.from(json["productImage"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "OrderID": orderId,
        "ClientID": clientId,
        "OrderNo": orderNo,
        "OrderDate": orderDate,
        "Orderamount": orderamount,
        "ApprovedAmount": approvedAmount,
        "RevisedAmount": revisedAmount,
        "PaymentAmount": paymentAmount,
        "ExtraChargeAmount": extraChargeAmount,
        "InstructionForShopper": instructionForShopper,
        "OrderStoresID": orderStoresId,
        "CartOrderNumber": cartOrderNumber,
        "StatusID": statusId,
        "StoreName": storeName,
        "StoreID": storeId,
        "OrderStatus": orderStatus,
        "StoreLogo": storeLogo,
        "FileLocation": fileLocation,
        "DeliveryFee": deliveryFee,
        "ServiceFee": serviceFee,
        "LongDistanceDeliveryFee": longDistanceDeliveryFee,
        "Taxes": taxes,
        "PickUpAssistFee": pickUpAssistFee,
        "PackagingFees": packagingFees,
        "InStoreShoppingManagedBy": inStoreShoppingManagedBy,
        "TwilioConversationId": twilioConversationId,
        "TwilioParticipantId": twilioParticipantId,
        "ParticipantIdentity": participantIdentity,
        "TipAmount": tipAmount,
        "CouponCode": couponCode,
        "Discount": discount,
        "productImage": List<dynamic>.from(productImage!.map((x) => x)),
      };
}
