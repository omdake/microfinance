// To parse this JSON data, do
//
//     final newSearchStoreListDataModel = newSearchStoreListDataModelFromJson(jsonString);

import 'dart:convert';

NewSearchStoreListDataModel newSearchStoreListDataModelFromJson(String str) =>
    NewSearchStoreListDataModel.fromJson(json.decode(str));

String newSearchStoreListDataModelToJson(NewSearchStoreListDataModel data) =>
    json.encode(data.toJson());

class NewSearchStoreListDataModel {
  String? storeId;
  String? code;
  String? name;
  String? address1;
  String? address2;
  String? address3;
  String? zipCode;
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
  int? orderLimitPerDay;
  int? releasetimeInMinsForOrders;
  double? latitude;
  double? longitude;
  String? storeFeeArrangement;
  int? agreedMarkUpCommission;
  String? delveryManagementby;
  String? inStoreShoppingManagedBy;
  String? phoneNo;
  String? storeNote;
  dynamic printerType;
  dynamic deliveryPartnerId;
  int? maxCartAmount;
  String? storeImageLogo;
  String? storeImageThumbnail;
  DateTime? pickupStoreStartTime;
  DateTime? pickupStoreCloseTime;
  DateTime? deliveryStoreStartTime;
  DateTime? deliveryStoreCloseTime;
  String? attributeId;
  dynamic offerDescription;
  String? zipCodeId;
  int? deliveryFee;
  int? pickUpAssistFee;
  int? longDistanceDeliveryFee;
  int? packagingFees;
  int? cutOffTimeInMinsForDelOrders;
  int? cutOffTimeInMinsForPickUpOrders;
  String? thirdPartyLogisticSupport;
  int? serviceFee;
  int? taxes;
  int? isInFavourites;
  int? storeAllowsPickups;
  int? storeAllowsDelivery;
  dynamic earliestDeliveryTime;
  dynamic earliestPikUpTime;

  NewSearchStoreListDataModel({
    this.storeId,
    this.code,
    this.name,
    this.address1,
    this.address2,
    this.address3,
    this.zipCode,
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
    this.storeImageLogo,
    this.storeImageThumbnail,
    this.pickupStoreStartTime,
    this.pickupStoreCloseTime,
    this.deliveryStoreStartTime,
    this.deliveryStoreCloseTime,
    this.attributeId,
    this.offerDescription,
    this.zipCodeId,
    this.deliveryFee,
    this.pickUpAssistFee,
    this.longDistanceDeliveryFee,
    this.packagingFees,
    this.cutOffTimeInMinsForDelOrders,
    this.cutOffTimeInMinsForPickUpOrders,
    this.thirdPartyLogisticSupport,
    this.serviceFee,
    this.taxes,
    this.isInFavourites,
    this.storeAllowsPickups,
    this.storeAllowsDelivery,
    this.earliestDeliveryTime,
    this.earliestPikUpTime,
  });

  factory NewSearchStoreListDataModel.fromJson(Map<String, dynamic> json) =>
      NewSearchStoreListDataModel(
        storeId: json["StoreID"],
        code: json["Code"],
        name: json["Name"],
        address1: json["Address1"],
        address2: json["Address2"],
        address3: json["Address3"],
        zipCode: json["ZipCode"],
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
        storeImageLogo: json["StoreImageLogo"],
        storeImageThumbnail: json["StoreImageThumbnail"],
        pickupStoreStartTime: json["PickupStoreStartTime"] != null
            ? DateTime.parse(json["PickupStoreStartTime"])
            : null,
        pickupStoreCloseTime: json["PickupStoreCloseTime"] != null
            ? DateTime.parse(json["PickupStoreCloseTime"])
            : null,
        deliveryStoreStartTime: json["DeliveryStoreStartTime"] != null
            ? DateTime.parse(json["DeliveryStoreStartTime"])
            : null,
        deliveryStoreCloseTime: json["DeliveryStoreCloseTime"] != null
            ? DateTime.parse(json["DeliveryStoreCloseTime"])
            : null,
        attributeId: json["AttributeID"],
        offerDescription: json["OfferDescription"],
        zipCodeId: json["ZipCodeId"],
        deliveryFee: json["DeliveryFee"],
        pickUpAssistFee: json["PickUpAssistFee"],
        longDistanceDeliveryFee: json["LongDistanceDeliveryFee"],
        packagingFees: json["PackagingFees"],
        cutOffTimeInMinsForDelOrders: json["CutOffTimeInMinsForDelOrders"],
        cutOffTimeInMinsForPickUpOrders:
            json["CutOffTimeInMinsForPickUpOrders"],
        thirdPartyLogisticSupport: json["ThirdPartyLogisticSupport"],
        serviceFee: json["ServiceFee"],
        taxes: json["Taxes"],
        isInFavourites: json["IsInFavourites"],
        storeAllowsPickups: json["StoreAllowsPickups"],
        storeAllowsDelivery: json["StoreAllowsDelivery"],
        earliestDeliveryTime: json["EarliestDeliveryTime"],
        earliestPikUpTime: json["EarliestPikUpTime"],
      );

  Map<String, dynamic> toJson() => {
        "StoreID": storeId,
        "Code": code,
        "Name": name,
        "Address1": address1,
        "Address2": address2,
        "Address3": address3,
        "ZipCode": zipCode,
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
        "StoreImageLogo": storeImageLogo,
        "StoreImageThumbnail": storeImageThumbnail,
        "PickupStoreStartTime": pickupStoreStartTime!.toIso8601String(),
        "PickupStoreCloseTime": pickupStoreCloseTime!.toIso8601String(),
        "DeliveryStoreStartTime": deliveryStoreStartTime!.toIso8601String(),
        "DeliveryStoreCloseTime": deliveryStoreCloseTime!.toIso8601String(),
        "AttributeID": attributeId,
        "OfferDescription": offerDescription,
        "ZipCodeId": zipCodeId,
        "DeliveryFee": deliveryFee,
        "PickUpAssistFee": pickUpAssistFee,
        "LongDistanceDeliveryFee": longDistanceDeliveryFee,
        "PackagingFees": packagingFees,
        "CutOffTimeInMinsForDelOrders": cutOffTimeInMinsForDelOrders,
        "CutOffTimeInMinsForPickUpOrders": cutOffTimeInMinsForPickUpOrders,
        "ThirdPartyLogisticSupport": thirdPartyLogisticSupport,
        "ServiceFee": serviceFee,
        "Taxes": taxes,
        "IsInFavourites": isInFavourites,
        "StoreAllowsPickups": storeAllowsPickups,
        "StoreAllowsDelivery": storeAllowsDelivery,
        "EarliestDeliveryTime": earliestDeliveryTime,
        "EarliestPikUpTime": earliestPikUpTime,
      };
}
