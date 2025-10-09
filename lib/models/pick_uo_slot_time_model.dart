// To parse this JSON data, do
//
//     final pickUpSlotMoodel = pickUpSlotMoodelFromJson(jsonString);

import 'dart:convert';

PickUpSlotMoodel pickUpSlotMoodelFromJson(String str) =>
    PickUpSlotMoodel.fromJson(json.decode(str));

String pickUpSlotMoodelToJson(PickUpSlotMoodel data) =>
    json.encode(data.toJson());

class PickUpSlotMoodel {
  bool? success;
  String? message;
  Response? response;

  PickUpSlotMoodel({
    this.success,
    this.message,
    this.response,
  });

  factory PickUpSlotMoodel.fromJson(Map<String, dynamic> json) =>
      PickUpSlotMoodel(
        success: json["success"],
        message: json["message"],
        response: Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "response": response!.toJson(),
      };
}

class Response {
  List<PickUpSlotTable>? table;

  Response({this.table});

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        table: List<PickUpSlotTable>.from(
            json["Table"].map((x) => PickUpSlotTable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Table": List<dynamic>.from(table!.map((x) => x.toJson())),
      };
}

class PickUpSlotTable {
  String? weekDayGroupDetsId;
  String? storeName;
  String? pickupDate;
  String? weekday;
  String? storeStartTime;
  String? storeCloseTime;
  int? storeTimingTypeId;
  String? storeTimingId;
  bool? isSelected;

  PickUpSlotTable({
    this.weekDayGroupDetsId,
    this.storeName,
    this.pickupDate,
    this.weekday,
    this.storeStartTime,
    this.storeCloseTime,
    this.storeTimingTypeId,
    this.storeTimingId,
    this.isSelected,
  });

  factory PickUpSlotTable.fromJson(Map<String, dynamic> json) =>
      PickUpSlotTable(
        weekDayGroupDetsId: json["WeekDayGroupDetsID"],
        storeName: json["StoreName"],
        pickupDate: json["PickupDate"],
        weekday: json["Weekday"],
        storeStartTime: json["StoreStartTime"],
        storeCloseTime: json["StoreCloseTime"],
        storeTimingTypeId: json["StoreTimingTypeID"],
        storeTimingId: json["StoreTimingID"],
        isSelected: false,
      );

  Map<String, dynamic> toJson() => {
        "WeekDayGroupDetsID": weekDayGroupDetsId,
        "StoreName": storeName,
        "PickupDate": pickupDate,
        "Weekday": weekday,
        "StoreStartTime": storeStartTime,
        "StoreCloseTime": storeCloseTime,
        "StoreTimingTypeID": storeTimingTypeId,
        "StoreTimingID": storeTimingId,
      };
}

