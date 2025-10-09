// To parse this JSON data, do
//
//     final orderContactDetailsModel = orderContactDetailsModelFromJson(jsonString);

import 'dart:convert';

List<OrderContactDetailsModel> orderContactDetailsModelFromJson(String str) =>
    List<OrderContactDetailsModel>.from(
        json.decode(str).map((x) => OrderContactDetailsModel.fromJson(x)));

String orderContactDetailsModelToJson(List<OrderContactDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderContactDetailsModel {
  String? orderStoresId;
  String? orderId;
  String? deliveryOrPickupOrder;
  String? storeTimingId;
  String? storeStartTime;
  String? storeCloseTime;
  String? expectedDeliveryDate;
  String? orderDeliveryId;
  String? orderPaymentId;
  String? clientName;
  String? phone;
  String? secondaryPhone;
  String? email;
  String? clientAddress;
  dynamic isLeaveAtMyDoor;
  String? storeInstructions;
  String? deliveryInstructions;
  String? cityName;
  String? stateId;
  dynamic zipCode;
  dynamic issuer;
  dynamic cardEndingwith;
  String? instructionForShopper;
  dynamic paymentApprovalDate;
  dynamic stripePaymentIndentId;
  dynamic stripePaymentMethodId;
  dynamic stripeClientId;
  dynamic approvedAmount;

  OrderContactDetailsModel({
    this.orderStoresId,
    this.orderId,
    this.deliveryOrPickupOrder,
    this.storeTimingId,
    this.storeStartTime,
    this.storeCloseTime,
    this.expectedDeliveryDate,
    this.orderDeliveryId,
    this.orderPaymentId,
    this.clientName,
    this.phone,
    this.secondaryPhone,
    this.email,
    this.clientAddress,
    this.isLeaveAtMyDoor,
    this.storeInstructions,
    this.deliveryInstructions,
    this.cityName,
    this.stateId,
    this.zipCode,
    this.issuer,
    this.cardEndingwith,
    this.instructionForShopper,
    this.paymentApprovalDate,
    this.stripePaymentIndentId,
    this.stripePaymentMethodId,
    this.stripeClientId,
    this.approvedAmount,
  });

  factory OrderContactDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderContactDetailsModel(
        orderStoresId: json["OrderStoresID"],
        orderId: json["OrderID"],
        deliveryOrPickupOrder: json["DeliveryOrPickupOrder"],
        storeTimingId: json["StoreTimingID"],
        storeStartTime: json["StoreStartTime"],
        storeCloseTime: json["StoreCloseTime"],
        expectedDeliveryDate: json["ExpectedDeliveryDate"],
        orderDeliveryId: json["OrderDeliveryID"],
        orderPaymentId: json["OrderPaymentID"],
        clientName: json["ClientName"],
        phone: json["Phone"],
        secondaryPhone: json["SecondaryPhone"],
        email: json["Email"],
        clientAddress: json["ClientAddress"],
        isLeaveAtMyDoor: json["IsLeaveAtMyDoor"],
        storeInstructions: json["StoreInstructions"],
        deliveryInstructions: json["DeliveryInstructions"],
        cityName: json["CityName"],
        stateId: json["StateID"],
        zipCode: json["ZipCode"],
        issuer: json["Issuer"],
        cardEndingwith: json["CardEndingwith"],
        instructionForShopper: json["InstructionForShopper"],
        paymentApprovalDate: json["PaymentApprovalDate"],
        stripePaymentIndentId: json["StripePaymentIndentId"],
        stripePaymentMethodId: json["StripePaymentMethodID"],
        stripeClientId: json["StripeClientID"],
        approvedAmount: json["ApprovedAmount"],
      );

  Map<String, dynamic> toJson() => {
        "OrderStoresID": orderStoresId,
        "OrderID": orderId,
        "DeliveryOrPickupOrder": deliveryOrPickupOrder,
        "StoreTimingID": storeTimingId,
        "StoreStartTime": storeStartTime,
        "StoreCloseTime": storeCloseTime,
        "ExpectedDeliveryDate": expectedDeliveryDate,
        "OrderDeliveryID": orderDeliveryId,
        "OrderPaymentID": orderPaymentId,
        "ClientName": clientName,
        "Phone": phone,
        "SecondaryPhone": secondaryPhone,
        "Email": email,
        "ClientAddress": clientAddress,
        "IsLeaveAtMyDoor": isLeaveAtMyDoor,
        "StoreInstructions": storeInstructions,
        "DeliveryInstructions": deliveryInstructions,
        "CityName": cityName,
        "StateID": stateId,
        "ZipCode": zipCode,
        "Issuer": issuer,
        "CardEndingwith": cardEndingwith,
        "InstructionForShopper": instructionForShopper,
        "PaymentApprovalDate": paymentApprovalDate,
        "StripePaymentIndentId": stripePaymentIndentId,
        "StripePaymentMethodID": stripePaymentMethodId,
        "StripeClientID": stripeClientId,
        "ApprovedAmount": approvedAmount,
      };
}
