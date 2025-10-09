// To parse this JSON data, do
//
//     final newResentStoreListDataModel = newResentStoreListDataModelFromJson(jsonString);

import 'dart:convert';

NewResentStoreListDataModel newResentStoreListDataModelFromJson(String str) =>
    NewResentStoreListDataModel.fromJson(json.decode(str));

String newResentStoreListDataModelToJson(NewResentStoreListDataModel data) =>
    json.encode(data.toJson());

class NewResentStoreListDataModel {
  String? storeId;
  String? code;
  String? name;
  String? address1;
  dynamic address2;
  dynamic address3;
  String? zipCode;
  String? zipCodeId;
  String? districtId;
  String? stateId;
  String? tagLine;
  String? storeDescription;
  String? storeType;
  String? pricingPolicy;
  String? countryId;
  String? status;
  DateTime? createdOn;
  String? createdBy;
  String? delveryOrPickUp;
  dynamic orderLimitPerDay;
  dynamic releasetimeInMinsForOrders;
  double? latitude;
  double? longitude;
  String? storeFeeArrangement;
  dynamic agreedMarkUpCommission;
  String? delveryManagementby;
  String? inStoreShoppingManagedBy;
  String? phoneNo;
  String? storeNote;
  dynamic printerType;
  String? deliveryPartnerId;
  dynamic maxCartAmount;
  dynamic storeImagePath;
  dynamic storeImageDesc;
  DateTime? startTime;
  dynamic offerDescription;
  DateTime? lastPurchasedDate;
  String? attributeId;
  dynamic earliestDeliveryTime;
  DateTime? earliestPikUpTime;
  int? isInFavourites;

  NewResentStoreListDataModel({
    this.storeId,
    this.code,
    this.name,
    this.address1,
    this.address2,
    this.address3,
    this.zipCode,
    this.zipCodeId,
    this.districtId,
    this.stateId,
    this.tagLine,
    this.storeDescription,
    this.storeType,
    this.pricingPolicy,
    this.countryId,
    this.status,
    this.createdOn,
    this.createdBy,
    this.delveryOrPickUp,
    this.orderLimitPerDay,
    this.releasetimeInMinsForOrders,
    this.latitude,
    this.longitude,
    this.storeFeeArrangement,
    this.agreedMarkUpCommission,
    this.delveryManagementby,
    this.inStoreShoppingManagedBy,
    this.phoneNo,
    this.storeNote,
    this.printerType,
    this.deliveryPartnerId,
    this.maxCartAmount,
    this.storeImagePath,
    this.storeImageDesc,
    this.startTime,
    this.offerDescription,
    this.lastPurchasedDate,
    this.attributeId,
    this.earliestDeliveryTime,
    this.earliestPikUpTime,
    this.isInFavourites,
  });

  factory NewResentStoreListDataModel.fromJson(Map<String, dynamic> json) =>
      NewResentStoreListDataModel(
        storeId: json["StoreID"],
        code: json["Code"],
        name: json["Name"],
        address1: json["Address1"],
        address2: json["Address2"],
        address3: json["Address3"],
        zipCode: json["ZipCode"],
        zipCodeId: json["ZipCodeId"],
        districtId: json["DistrictID"],
        stateId: json["StateID"],
        tagLine: json["TagLine"],
        storeDescription: json["StoreDescription"],
        storeType: json["StoreType"],
        pricingPolicy: json["PricingPolicy"],
        countryId: json["CountryID"],
        status: json["Status"],
        createdOn: json["CreatedOn"] != null
            ? DateTime.parse(json["CreatedOn"])
            : null,
        createdBy: json["CreatedBy"],
        delveryOrPickUp: json["DelveryOrPickUp"],
        orderLimitPerDay: json["OrderLimitPerDay"],
        releasetimeInMinsForOrders: json["ReleasetimeInMinsForOrders"],
        latitude: json["Latitude"].toDouble(),
        longitude: json["Longitude"].toDouble(),
        storeFeeArrangement: json["StoreFeeArrangement"],
        agreedMarkUpCommission: json["AgreedMarkUpCommission"],
        delveryManagementby: json["DelveryManagementby"],
        inStoreShoppingManagedBy: json["InStoreShoppingManagedBy"],
        phoneNo: json["PhoneNo"],
        storeNote: json["StoreNote"],
        printerType: json["PrinterType"],
        deliveryPartnerId: json["DeliveryPartnerID"],
        maxCartAmount: json["MaxCartAmount"],
        storeImagePath: json["StoreImagePath"],
        storeImageDesc: json["StoreImageDesc"],
        startTime: json["StartTime"] != null
            ? DateTime.parse(json["StartTime"])
            : null,
        offerDescription: json["OfferDescription"],
        lastPurchasedDate: json["LastPurchasedDate"] != null
            ? DateTime.parse(json["LastPurchasedDate"])
            : null,
        attributeId: json["AttributeId"],
        earliestDeliveryTime: json["EarliestDeliveryTime"],
        earliestPikUpTime: json["EarliestPikUpTime"] != null
            ? DateTime.parse(json["EarliestPikUpTime"])
            : null,
        isInFavourites: json["IsInFavourites"],
      );

  Map<String, dynamic> toJson() => {
        "StoreID": storeId,
        "Code": code,
        "Name": name,
        "Address1": address1,
        "Address2": address2,
        "Address3": address3,
        "ZipCode": zipCode,
        "ZipCodeId": zipCodeId,
        "DistrictID": districtId,
        "StateID": stateId,
        "TagLine": tagLine,
        "StoreDescription": storeDescription,
        "StoreType": storeType,
        "PricingPolicy": pricingPolicy,
        "CountryID": countryId,
        "Status": status,
        "CreatedOn": createdOn!.toIso8601String(),
        "CreatedBy": createdBy,
        "DelveryOrPickUp": delveryOrPickUp,
        "OrderLimitPerDay": orderLimitPerDay,
        "ReleasetimeInMinsForOrders": releasetimeInMinsForOrders,
        "Latitude": latitude,
        "Longitude": longitude,
        "StoreFeeArrangement": storeFeeArrangement,
        "AgreedMarkUpCommission": agreedMarkUpCommission,
        "DelveryManagementby": delveryManagementby,
        "InStoreShoppingManagedBy": inStoreShoppingManagedBy,
        "PhoneNo": phoneNo,
        "StoreNote": storeNote,
        "PrinterType": printerType,
        "DeliveryPartnerID": deliveryPartnerId,
        "MaxCartAmount": maxCartAmount,
        "StoreImagePath": storeImagePath,
        "StoreImageDesc": storeImageDesc,
        "StartTime": startTime!.toIso8601String(),
        "OfferDescription": offerDescription,
        "LastPurchasedDate": lastPurchasedDate!.toIso8601String(),
        "AttributeId": attributeId,
        "EarliestDeliveryTime": earliestDeliveryTime,
        "EarliestPikUpTime": earliestPikUpTime!.toIso8601String(),
        "IsInFavourites": isInFavourites,
      };
}
