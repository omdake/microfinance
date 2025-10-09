// To parse this JSON data, do
//
//     final timeLineProductModel = timeLineProductModelFromJson(jsonString);

import 'dart:convert';

List<TimeLineProductModel> timeLineProductModelFromJson(String str) =>
    List<TimeLineProductModel>.from(
        json.decode(str).map((x) => TimeLineProductModel.fromJson(x)));

String timeLineProductModelToJson(List<TimeLineProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeLineProductModel {
  String? orderStatusId;
  String? orderStoresId;
  int? statusId;
  DateTime? statusDateTime;
  String? orderStatus;
  String? orderStatusDescription;

  TimeLineProductModel({
    this.orderStatusId,
    this.orderStoresId,
    this.statusId,
    this.statusDateTime,
    this.orderStatus,
    this.orderStatusDescription,
  });

  factory TimeLineProductModel.fromJson(Map<String, dynamic> json) =>
      TimeLineProductModel(
        orderStatusId: json["OrderStatusID"],
        orderStoresId: json["OrderStoresID"],
        statusId: json["StatusID"],
        statusDateTime: json["StatusDateTime"] != null
            ? DateTime.parse(json["StatusDateTime"])
            : null,
        orderStatus: json["OrderStatus"],
        orderStatusDescription: json["OrderStatusDescription"],
      );

  Map<String, dynamic> toJson() => {
        "OrderStatusID": orderStatusId,
        "OrderStoresID": orderStoresId,
        "StatusID": statusId,
        "StatusDateTime": statusDateTime!.toIso8601String(),
        "OrderStatus": orderStatus,
        "OrderStatusDescription": orderStatusDescription,
      };
}
