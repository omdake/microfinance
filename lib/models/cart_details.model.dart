class CartDetails {
  String? productID;
  String? name;
  dynamic itemCode;
  String? itemDesc;
  String? productImageUrl;
  double? itemMRP;
  double? itemSalePrice;
  double? itemRate;
  double? productTax;
  String? currencyRepresentation;
  String? currencyDesc;
  String? storeID;
  String? storeName;
  String? deliveryStoreStartTime;
  int? freeDeliveryLimit;
  double? pkgSize;
  String? pkgUnit;
  String? storeImagePath;
  String? storeAddress;
  String? deliverytype;
  String? replaceItemID;
  String? replaceItemName;
  String? productInstruction;
  dynamic itemNotAvailableOption;
  double? quantity;
  double? minOrderValue;
  double? minOrderQuantity;
  double? maxOrderQuantity;
  int? uOMID;
  double? uOMIncrementByQuantity;
  String? zipCodeId;
  String? zoneTag;
  double? deliveryFee;
  double? pickUpAssistFee;
  double? longDistanceDeliveryFee;
  int? cutOffTimeInMinsForDelOrders;
  int? cutOffTimeInMinsForPickUpOrders;
  String? thirdPartyLogisticSupport;
  double? packagingFees;
  double? serviceFee;
  double? taxes;
  String? uOMDesc;
  String? isSpecialProduct;
  double? itemShippingWeight;
  bool? isSelected;
  String? replacementImage;
  String? replacementdisc;

  CartDetails(
      {this.productID,
      this.name,
      this.replacementImage,
      this.replacementdisc,
      this.itemCode,
      this.itemDesc,
      this.productImageUrl,
      this.itemMRP,
      this.itemSalePrice,
      this.itemRate,
      this.productTax,
      this.currencyRepresentation,
      this.currencyDesc,
      this.storeID,
      this.storeName,
      this.deliveryStoreStartTime,
      this.freeDeliveryLimit,
      this.pkgSize,
      this.pkgUnit,
      this.storeImagePath,
      this.storeAddress,
      this.deliverytype,
      this.replaceItemID,
      this.replaceItemName,
      this.productInstruction,
      this.itemNotAvailableOption,
      this.quantity,
      this.minOrderValue,
      this.minOrderQuantity,
      this.maxOrderQuantity,
      this.uOMID,
      this.uOMIncrementByQuantity,
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
      this.uOMDesc,
      this.isSpecialProduct,
      this.itemShippingWeight,
      this.isSelected});

  CartDetails.fromJson(Map<String, dynamic> json) {
    productID = json['ProductID'];
    name = json['Name'];
    itemCode = json['ItemCode'];
    itemDesc = json['ItemDesc'];
    productImageUrl = json['ProductImageUrl'];
    itemMRP = json['ItemMRP'];
    itemSalePrice = json['ItemSalePrice'];
    itemRate = json['ItemRate'];
    productTax = json['ProductTax'];
    currencyRepresentation = json['CurrencyRepresentation'];
    currencyDesc = json['CurrencyDesc'];
    storeID = json['StoreID'];
    storeName = json['StoreName'];
    deliveryStoreStartTime = json['DeliveryStoreStartTime'];
    freeDeliveryLimit = json['FreeDeliveryLimit'];
    pkgSize = json['PkgSize'];
    pkgUnit = json['PkgUnit'];
    storeImagePath = json['StoreImagePath'];
    storeAddress = json['StoreAddress'];
    deliverytype = json['deliverytype'];
    replaceItemID = json['ReplaceItemID'];
    replaceItemName = json['ReplaceItemName'];
    productInstruction = json['ProductInstruction'];
    itemNotAvailableOption = json['ItemNotAvailableOption'];
    quantity = json['Quantity'];
    minOrderValue = json['MinOrderValue'];
    minOrderQuantity = json['MinOrderQuantity'];
    maxOrderQuantity = json['MaxOrderQuantity'];
    uOMID = json['UOMID'];
    uOMIncrementByQuantity = json['UOMIncrementByQuantity'];
    zipCodeId = json['ZipCodeId'];
    zoneTag = json['ZoneTag'];
    deliveryFee = json['DeliveryFee'];
    pickUpAssistFee = json['PickUpAssistFee'];
    longDistanceDeliveryFee = json['LongDistanceDeliveryFee'];
    cutOffTimeInMinsForDelOrders = json['CutOffTimeInMinsForDelOrders'];
    cutOffTimeInMinsForPickUpOrders = json['CutOffTimeInMinsForPickUpOrders'];
    thirdPartyLogisticSupport = json['ThirdPartyLogisticSupport'];
    packagingFees = json['PackagingFees'];
    serviceFee = json['ServiceFee'];
    taxes = json['Taxes'];
    uOMDesc = json['UOMDesc'];
    isSpecialProduct = json['IsSpecialProduct'];
    itemShippingWeight = json['ItemShippingWeight'];
    replacementImage = json['ReplacementProductImageUrl'];
    replacementdisc = json['ReplaceItemDesc'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ReplacementProductImageUrl'] = this.replacementImage;
    data['ReplaceItemDesc'] = this.replacementdisc;
    data['ProductID'] = this.productID;
    data['Name'] = this.name;
    data['ItemCode'] = this.itemCode;
    data['ItemDesc'] = this.itemDesc;
    data['ProductImageUrl'] = this.productImageUrl;
    data['ItemMRP'] = this.itemMRP;
    data['ItemSalePrice'] = this.itemSalePrice;
    data['ItemRate'] = this.itemRate;
    data['ProductTax'] = this.productTax;
    data['CurrencyRepresentation'] = this.currencyRepresentation;
    data['CurrencyDesc'] = this.currencyDesc;
    data['StoreID'] = this.storeID;
    data['StoreName'] = this.storeName;
    data['DeliveryStoreStartTime'] = this.deliveryStoreStartTime;
    data['FreeDeliveryLimit'] = this.freeDeliveryLimit;
    data['PkgSize'] = this.pkgSize;
    data['PkgUnit'] = this.pkgUnit;
    data['StoreImagePath'] = this.storeImagePath;
    data['StoreAddress'] = this.storeAddress;
    data['deliverytype'] = this.deliverytype;
    data['ReplaceItemID'] = this.replaceItemID;
    data['ReplaceItemName'] = this.replaceItemName;
    data['ProductInstruction'] = this.productInstruction;
    data['ItemNotAvailableOption'] = this.itemNotAvailableOption;
    data['Quantity'] = this.quantity;
    data['MinOrderValue'] = this.minOrderValue;
    data['MinOrderQuantity'] = this.minOrderQuantity;
    data['MaxOrderQuantity'] = this.maxOrderQuantity;
    data['UOMID'] = this.uOMID;
    data['UOMIncrementByQuantity'] = this.uOMIncrementByQuantity;
    data['ZipCodeId'] = this.zipCodeId;
    data['ZoneTag'] = this.zoneTag;
    data['DeliveryFee'] = this.deliveryFee;
    data['PickUpAssistFee'] = this.pickUpAssistFee;
    data['LongDistanceDeliveryFee'] = this.longDistanceDeliveryFee;
    data['CutOffTimeInMinsForDelOrders'] = this.cutOffTimeInMinsForDelOrders;
    data['CutOffTimeInMinsForPickUpOrders'] =
        this.cutOffTimeInMinsForPickUpOrders;
    data['ThirdPartyLogisticSupport'] = this.thirdPartyLogisticSupport;
    data['PackagingFees'] = this.packagingFees;
    data['ServiceFee'] = this.serviceFee;
    data['Taxes'] = this.taxes;
    data['UOMDesc'] = this.uOMDesc;
    data['IsSpecialProduct'] = this.isSpecialProduct;
    data['ItemShippingWeight'] = this.itemShippingWeight;
    return data;
  }
}
