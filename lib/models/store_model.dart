import 'package:microfinance/utils/extension/extension/map_extensions.dart';

class StoreDetails {
  String? StoreID;
  String? code;
  String? Name;
  String? address1;
  String? address2;
  String? address3;
  String? zipCode;
  String? districtId;
  String? stateId;
  String? tagLine;
  String? DelveryOrPickUp;
  String? ItemMRP;
  String? storeImageLogo;
  String? storeImageThumbnail;
  String? pickupStoreStartTime;
  String? pickupStoreCloseTime;
  String? deliveryStoreStartTime;
  String? deliveryStoreCloseTime;
  String? attributeId;
  String? offerDescription;
  String? storeType;
  String? EarliestDeliveryTime;
  String? EarliestPikUpTime;
  String? zipCodeId;
  String? zoneTag;
  int? deliveryFee;
  int? pickUpAssistFee;
  int? longDistanceDeliveryFee;
  int? cutOffTimeInMinsForDelOrders;
  int? cutOffTimeInMinsForPickUpOrders;
  String? thirdPartyLogisticSupport;
  int? packagingFees;
  int? serviceFee;
  int? taxes;
  int? isInFavourites;
  String? status;

  StoreDetails({
    this.StoreID,
    this.code,
    this.Name,
    this.address1,
    this.address2,
    this.address3,
    this.zipCode,
    this.districtId,
    this.stateId,
    this.tagLine,
    this.DelveryOrPickUp,
    this.storeImageLogo,
    this.storeImageThumbnail,
    this.pickupStoreStartTime,
    this.pickupStoreCloseTime,
    this.deliveryStoreCloseTime,
    this.attributeId,
    this.offerDescription,
    this.storeType,
    this.ItemMRP,
    this.deliveryStoreStartTime,
    this.EarliestDeliveryTime,
    this.EarliestPikUpTime,
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

  factory StoreDetails.empty() => StoreDetails(
      StoreID: defaultString,
      code: defaultString,
      Name: defaultString,
      address1: defaultString,
      zipCode: defaultString,
      address2: defaultString,
      address3: defaultString,
      districtId: defaultString,
      stateId: defaultString,
      tagLine: defaultString,
      DelveryOrPickUp: defaultString,
      ItemMRP: defaultString,
      storeImageLogo: defaultString,
      storeImageThumbnail: defaultString,
      pickupStoreStartTime: defaultString,
      attributeId: defaultString,
      offerDescription: defaultString,
      storeType: defaultString,
      deliveryStoreStartTime: defaultString,
      EarliestDeliveryTime: defaultString,
      EarliestPikUpTime: defaultString,
      isInFavourites: 0);

  factory StoreDetails.fromMap(Map data) => new StoreDetails(
      StoreID: data['StoreID'],
      code: data['code'],
      Name: data['Name'],
      zipCode: data['zipCode'],
      address1: data['Address1'],
      address2: data['Address2'],
      address3: data['Address3'],
      districtId: data['address3'],
      stateId: data['stateId'],
      tagLine: data['TagLine'],
      DelveryOrPickUp: data['DelveryOrPickUp'],
      storeImageLogo: data["StoreImageLogo"] ?? "",
      storeImageThumbnail: data["StoreImageThumbnail"] ?? "",
      pickupStoreStartTime: data["PickupStoreStartTime"] ?? "",
      pickupStoreCloseTime: data["PickupStoreCloseTime"],
      deliveryStoreStartTime: data["DeliveryStoreStartTime"],
      deliveryStoreCloseTime: data["DeliveryStoreCloseTime"],
      attributeId: data["AttributeID"],
      offerDescription: data["OfferDescription"],
      storeType: data["StoreType"],
      ItemMRP: data['ItemMRP'],
      EarliestDeliveryTime: data['EarliestDeliveryTime'],
      EarliestPikUpTime: data['EarliestPikUpTime'],
      isInFavourites: data['IsInFavourites'] ?? 0);

  factory StoreDetails.fromJson(dynamic json) {
    return StoreDetails(
      StoreID: json['StoreID'] as String? ?? '',
      code: json['code'] as String? ?? '',
      Name: json['Name'] as String? ?? '',
      zipCode: json['zipCode'] as String? ?? '',
      address1: json['address1'] as String? ?? json['Address1'] ?? "",
      address2: json['address2'] as String? ?? json['Address2'] ?? "",
      address3: json['address3'] as String? ?? json['Address3'] ?? "",
      districtId: json['districtId'] as String? ?? '',
      tagLine: json['TagLine'] as String? ?? '',
      DelveryOrPickUp: json['DelveryOrPickUp'] as String? ?? '',
      ItemMRP: json['ItemMRP'] as String? ?? '',
      storeImageLogo: json["StoreImageLogo"] as String? ?? '',
      storeImageThumbnail: json["StoreImageThumbnail"] as String? ?? '',
      pickupStoreStartTime: json["PickupStoreStartTime"] as String? ?? '',
      pickupStoreCloseTime: json["PickupStoreCloseTime"],
      deliveryStoreStartTime: json["DeliveryStoreStartTime"],
      deliveryStoreCloseTime: json["DeliveryStoreCloseTime"],
      attributeId: json["AttributeID"] as String? ?? '',
      offerDescription: json["OfferDescription"] as String? ?? '',
      storeType: json["StoreType"] as String? ?? '',
      EarliestDeliveryTime: json["EarliestDeliveryTime"] as String? ?? '',
      EarliestPikUpTime: json["EarliestPikUpTime"] as String? ?? '',
      isInFavourites: json["IsInFavourites"] as int? ?? 0,
    );
  }
}
