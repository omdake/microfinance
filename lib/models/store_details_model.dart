// To parse this JSON data, do
//
//     final pickUpSlotMoodel = pickUpSlotMoodelFromJson(jsonString);

class StoredeatilsTable {
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
  dynamic orderLimitPerDay;
  dynamic releasetimeInMinsForOrders;
  dynamic latitude;
  dynamic longitude;
  String? storeFeeArrangement;
  dynamic agreedMarkUpCommission;
  String? delveryManagementby;
  String? inStoreShoppingManagedBy;
  String? phoneNo;
  String? storeNote;
  dynamic printerType;
  String? deliveryPartnerId;
  dynamic storeImagePath;
  dynamic storeImageDesc;
  dynamic offerDescription;
  String? attributeId;
  String? pickupStoreStartTime;
  String? pickupStoreCloseTime;
  dynamic deliveryStoreStartTime;
  dynamic deliveryStoreCloseTime;
  dynamic isDeliveryAvailable;
  dynamic isPickupAvailable;
  dynamic earliestDeliveryTime;
  DateTime? earliestPickUpTime;
  dynamic minOrderValue;
  dynamic maxOrderValue;
  String? zipCodeId;
  String? zoneTag;
  dynamic deliveryFee;
  dynamic pickUpAssistFee;
  dynamic longDistanceDeliveryFee;
  dynamic cutOffTimeInMinsForDelOrders;
  dynamic cutOffTimeInMinsForPickUpOrders;
  String? thirdPartyLogisticSupport;
  dynamic packagingFees;
  dynamic serviceFee;
  dynamic taxes;
  dynamic isInFavourites;

  StoredeatilsTable({
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
    this.storeImagePath,
    this.storeImageDesc,
    this.offerDescription,
    this.attributeId,
    this.pickupStoreStartTime,
    this.pickupStoreCloseTime,
    this.deliveryStoreStartTime,
    this.deliveryStoreCloseTime,
    this.isDeliveryAvailable,
    this.isPickupAvailable,
    this.earliestDeliveryTime,
    this.earliestPickUpTime,
    this.minOrderValue,
    this.maxOrderValue,
    this.zipCodeId,
    this.zoneTag,
    this.deliveryFee,
    this.pickUpAssistFee,
    this.longDistanceDeliveryFee,
    this.cutOffTimeInMinsForDelOrders,
    this.cutOffTimeInMinsForPickUpOrders,
    this.thirdPartyLogisticSupport,
    this.packagingFees,
    this.serviceFee,
    this.taxes,
    this.isInFavourites,
  });

  factory StoredeatilsTable.fromJson(Map<String, dynamic> json) =>
      StoredeatilsTable(
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
        storeImagePath: json["StoreImagePath"],
        storeImageDesc: json["StoreImageDesc"],
        offerDescription: json["OfferDescription"],
        attributeId: json["AttributeID"],
        pickupStoreStartTime: json["PickupStoreStartTime"],
        pickupStoreCloseTime: json["PickupStoreCloseTime"],
        deliveryStoreStartTime: json["DeliveryStoreStartTime"],
        deliveryStoreCloseTime: json["DeliveryStoreCloseTime"],
        isDeliveryAvailable: json["IsDeliveryAvailable"] ?? 0,
        isPickupAvailable: json["IsPickupAvailable"] ?? 0,
        earliestDeliveryTime: json["EarliestDeliveryTime"],
        earliestPickUpTime: json["EarliestPickUpTime"] != null
            ? DateTime.parse(json["EarliestPickUpTime"])
            : null,
        minOrderValue: json["MinOrderValue"],
        maxOrderValue: json["MaxOrderValue"],
        zipCodeId: json["ZipCodeId"],
        zoneTag: json["ZoneTag"],
        deliveryFee: json["DeliveryFee"],
        pickUpAssistFee: json["PickUpAssistFee"],
        longDistanceDeliveryFee: json["LongDistanceDeliveryFee"],
        cutOffTimeInMinsForDelOrders: json["CutOffTimeInMinsForDelOrders"],
        cutOffTimeInMinsForPickUpOrders:
            json["CutOffTimeInMinsForPickUpOrders"],
        thirdPartyLogisticSupport: json["ThirdPartyLogisticSupport"],
        packagingFees: json["PackagingFees"],
        serviceFee: json["ServiceFee"],
        taxes: json["Taxes"],
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
        "StoreImagePath": storeImagePath,
        "StoreImageDesc": storeImageDesc,
        "OfferDescription": offerDescription,
        "AttributeID": attributeId,
        "PickupStoreStartTime": pickupStoreStartTime,
        "PickupStoreCloseTime": pickupStoreCloseTime,
        "DeliveryStoreStartTime": deliveryStoreStartTime,
        "DeliveryStoreCloseTime": deliveryStoreCloseTime,
        "IsDeliveryAvailable": isDeliveryAvailable,
        "IsPickupAvailable": isPickupAvailable,
        "EarliestDeliveryTime": earliestDeliveryTime,
        "EarliestPickUpTime": earliestPickUpTime!.toIso8601String(),
        "MinOrderValue": minOrderValue,
        "MaxOrderValue": maxOrderValue,
        "ZipCodeId": zipCodeId,
        "ZoneTag": zoneTag,
        "DeliveryFee": deliveryFee,
        "PickUpAssistFee": pickUpAssistFee,
        "LongDistanceDeliveryFee": longDistanceDeliveryFee,
        "CutOffTimeInMinsForDelOrders": cutOffTimeInMinsForDelOrders,
        "CutOffTimeInMinsForPickUpOrders": cutOffTimeInMinsForPickUpOrders,
        "ThirdPartyLogisticSupport": thirdPartyLogisticSupport,
        "PackagingFees": packagingFees,
        "ServiceFee": serviceFee,
        "Taxes": taxes,
        "IsInFavourites": isInFavourites,
      };
}
