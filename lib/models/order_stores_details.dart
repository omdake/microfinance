// To parse this JSON data, do
//
//     final orderStoresDetails = orderStoresDetailsFromJson(jsonString);

import 'dart:convert';

List<OrderStoresDetails> orderStoresDetailsFromJson(String str) =>
    List<OrderStoresDetails>.from(
        json.decode(str).map((x) => OrderStoresDetails.fromJson(x)));

String orderStoresDetailsToJson(List<OrderStoresDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderStoresDetails {
  String? orderStoresId;
  String? orderId;
  String? cartOrderNumber;
  String? storeInstruction;
  String? productInstruction;
  bool? allowBestReplacement;
  String? allowBestReplacementText;
  String? replacementProductId;
  String? replacementProductName;
  String? replacementOptionDescription;
  String? storeId;
  String? storeName;
  String? orderProductId;
  double? qtyOrWeight;
  String? productId;
  String? productName;
  dynamic productCode;
  String? productDesc;
  dynamic productImageUrl;
  double? productMrp;
  double? productSalePrice;
  double? productRate;
  double? productTax;
  String? currencyRepresentation;
  String? currencyDesc;
  double? pkgSize;
  String? pkgUnit;
  dynamic storeImagePath;
  String? storeAddress;
  dynamic orderProductStatusId;
  double? shoppedQtyOrWeight;
  double? qtyCancelled;
  double? ourPrice;
  dynamic shoppedProductId;
  String? shoppedProductName;
  double? minOrderQuantity;
  double? maxOrderQuantity;
  int? uomid;
  double? uomIncrementByQuantity;
  double? minOrderValue;
  double? shopPrice;
  double? totalShoppingAmount;
  double? totalCustomerAmount;
  double? shoppedItemSalePrice;
  String? uomDesc;
  String? shopperRemark;
  String? isSpecialProduct;
  double? itemShippingWeight;
  int? freeDeliveryLimit;
  String? replacedProductImage;

  OrderStoresDetails({
    this.orderStoresId,
    this.orderId,
    this.cartOrderNumber,
    this.storeInstruction,
    this.productInstruction,
    this.allowBestReplacement,
    this.allowBestReplacementText,
    this.replacementProductId,
    this.replacementProductName,
    this.replacementOptionDescription,
    this.storeId,
    this.storeName,
    this.orderProductId,
    this.qtyOrWeight,
    this.productId,
    this.productName,
    this.productCode,
    this.productDesc,
    this.productImageUrl,
    this.productMrp,
    this.productSalePrice,
    this.productRate,
    this.productTax,
    this.currencyRepresentation,
    this.currencyDesc,
    this.pkgSize,
    this.pkgUnit,
    this.storeImagePath,
    this.storeAddress,
    this.orderProductStatusId,
    this.shoppedQtyOrWeight,
    this.qtyCancelled,
    this.ourPrice,
    this.shoppedProductId,
    this.shoppedProductName,
    this.minOrderQuantity,
    this.maxOrderQuantity,
    this.uomid,
    this.uomIncrementByQuantity,
    this.minOrderValue,
    this.shopPrice,
    this.totalShoppingAmount,
    this.totalCustomerAmount,
    this.shoppedItemSalePrice,
    this.uomDesc,
    this.shopperRemark,
    this.isSpecialProduct,
    this.itemShippingWeight,
    this.freeDeliveryLimit,
    this.replacedProductImage,
  });

  factory OrderStoresDetails.fromJson(Map<String, dynamic> json) =>
      OrderStoresDetails(
        orderStoresId: json["OrderStoresID"],
        orderId: json["OrderID"],
        cartOrderNumber: json["CartOrderNumber"],
        storeInstruction: json["StoreInstruction"],
        productInstruction: json["ProductInstruction"] ?? "",
        allowBestReplacement: json["AllowBestReplacement"] ?? false,
        allowBestReplacementText: json["AllowBestReplacementText"] ?? "",
        replacementProductId: json["ReplacementProductID"] ?? "",
        replacementProductName: json["ReplacementProductName"] ?? "",
        replacementOptionDescription:
            json["ReplacementOptionDescription"] ?? "",
        storeId: json["StoreID"] ?? "",
        storeName: json["StoreName"] ?? "",
        orderProductId: json["OrderProductID"] ?? "",
        qtyOrWeight: json["QtyOrWeight"] ?? 0.0,
        productId: json["ProductID"] ?? "",
        productName: json["ProductName"] ?? "",
        productCode: json["ProductCode"],
        productDesc: json["ProductDesc"] ?? "",
        productImageUrl: json["ProductImageUrl"] ?? "",
        productMrp: json["ProductMRP"] ?? 0.0,
        productSalePrice: json["ProductSalePrice"] ?? 0.0,
        productRate: json["ProductRate"] ?? 0.0,
        productTax: json["ProductTax"] ?? 0.0,
        currencyRepresentation: json["CurrencyRepresentation"] ?? "",
        currencyDesc: json["CurrencyDesc"] ?? "",
        pkgSize: json["PkgSize"] ?? 0.0,
        pkgUnit: json["PkgUnit"] ?? "",
        storeImagePath: json["StoreImagePath"] ?? "",
        storeAddress: json["StoreAddress"] ?? "",
        orderProductStatusId: json["OrderProductStatusId"],
        shoppedQtyOrWeight: json["ShoppedQtyOrWeight"] ?? 0.0,
        qtyCancelled: json["QtyCancelled"] ?? 0.0,
        ourPrice: json["OurPrice"] ?? 0.0,
        shoppedProductId: json["ShoppedProductID"],
        shoppedProductName: json["ShoppedProductName"] ?? "",
        minOrderQuantity: json["MinOrderQuantity"] ?? 0.0,
        maxOrderQuantity: json["MaxOrderQuantity"] ?? 0.0,
        uomid: json["UOMID"] ?? 0,
        uomIncrementByQuantity: json["UOMIncrementByQuantity"] ?? 0.0,
        minOrderValue: json["MinOrderValue"] ?? 0.0,
        shopPrice: json["ShopPrice"] ?? 0.0,
        totalShoppingAmount: json["TotalShoppingAmount"] ?? 0.0,
        totalCustomerAmount: json["TotalCustomerAmount"] ?? 0.0,
        shoppedItemSalePrice: json["ShoppedItemSalePrice"] ?? 0.0,
        uomDesc: json["UOMDesc"] ?? "",
        shopperRemark: json["ShopperRemark"] ?? "",
        isSpecialProduct: json["IsSpecialProduct"] ?? "",
        itemShippingWeight: json["ItemShippingWeight"] ?? 0.0,
        freeDeliveryLimit: json["FreeDeliveryLimit"] ?? 0,
        replacedProductImage: json["ReplacedProductImageUrl"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "OrderStoresID": orderStoresId,
        "OrderID": orderId,
        "CartOrderNumber": cartOrderNumber,
        "StoreInstruction": storeInstruction,
        "ProductInstruction": productInstruction,
        "AllowBestReplacement": allowBestReplacement,
        "AllowBestReplacementText": allowBestReplacementText,
        "ReplacementProductID": replacementProductId,
        "ReplacementProductName": replacementProductName,
        "ReplacementOptionDescription": replacementOptionDescription,
        "StoreID": storeId,
        "StoreName": storeName,
        "OrderProductID": orderProductId,
        "QtyOrWeight": qtyOrWeight,
        "ProductID": productId,
        "ProductName": productName,
        "ProductCode": productCode,
        "ProductDesc": productDesc,
        "ProductImageUrl": productImageUrl,
        "ProductMRP": productMrp,
        "ProductSalePrice": productSalePrice,
        "ProductRate": productRate,
        "ProductTax": productTax,
        "CurrencyRepresentation": currencyRepresentation,
        "CurrencyDesc": currencyDesc,
        "PkgSize": pkgSize,
        "PkgUnit": pkgUnit,
        "StoreImagePath": storeImagePath,
        "StoreAddress": storeAddress,
        "OrderProductStatusId": orderProductStatusId,
        "ShoppedQtyOrWeight": shoppedQtyOrWeight,
        "QtyCancelled": qtyCancelled,
        "OurPrice": ourPrice,
        "ShoppedProductID": shoppedProductId,
        "ShoppedProductName": shoppedProductName,
        "MinOrderQuantity": minOrderQuantity,
        "MaxOrderQuantity": maxOrderQuantity,
        "UOMID": uomid,
        "UOMIncrementByQuantity": uomIncrementByQuantity,
        "MinOrderValue": minOrderValue,
        "ShopPrice": shopPrice,
        "TotalShoppingAmount": totalShoppingAmount,
        "TotalCustomerAmount": totalCustomerAmount,
        "ShoppedItemSalePrice": shoppedItemSalePrice,
        "UOMDesc": uomDesc,
        "ShopperRemark": shopperRemark,
        "IsSpecialProduct": isSpecialProduct,
        "ItemShippingWeight": itemShippingWeight,
        "FreeDeliveryLimit": freeDeliveryLimit,
        "ReplacedProductImageUrl": replacedProductImage,
      };
}
