// To parse this JSON data, do
//
//     final storeProductSearchMoodel = storeProductSearchMoodelFromJson(jsonString);

import 'dart:convert';

StoreProductSearchMoodel storeProductSearchMoodelFromJson(String str) =>
    StoreProductSearchMoodel.fromJson(json.decode(str));

String storeProductSearchMoodelToJson(StoreProductSearchMoodel data) =>
    json.encode(data.toJson());

class StoreProductSearchMoodel {
  bool? success;
  String? message;
  Response? response;

  StoreProductSearchMoodel({
    this.success,
    this.message,
    this.response,
  });

  factory StoreProductSearchMoodel.fromJson(Map<String, dynamic> json) =>
      StoreProductSearchMoodel(
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
  List<SearchproductStorelist>? table;

  Response({
    this.table,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        table: List<SearchproductStorelist>.from(
            json["Table"].map((x) => SearchproductStorelist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Table": List<dynamic>.from(table!.map((x) => x.toJson())),
      };
}

class SearchproductStorelist {
  String? productId;
  String? storeId;
  String? name;
  dynamic productCode;
  String? subCategoryId;
  String? subCategoryPath;
  String? subCategoryName;
  String? categoryName;
  String? categoryIcon;
  String? categoryId;
  String? formId;
  String? manuFacturerId;
  dynamic itemDesc;
  dynamic pkgSize;
  String? pkgUnit;
  String? itemBarcode;
  dynamic itemRate;
  dynamic itemVat;
  dynamic itemNetRate;
  dynamic itemMrp;
  dynamic itemSalePrice;
  String? companyId;
  String? status;
  DateTime? updateOn;
  dynamic cess;
  String? hsnCode;
  String? approvalStatus;
  String? productImageUrl;
  String? createOn;
  bool? isPromo;
  bool? isPremiumPromo;
  String? promoText;
  String? premiumPromoText;
  bool? isOutOfStock;
  String? currencyRepresentation;
  String? currencyDesc;
  dynamic minOrderQuantity;
  dynamic maxOrderQuantity;
  dynamic uomid;
  dynamic uomIncrementByQuantity;
  String? productType;
  dynamic isInFavourites;
  String? uomDesc;
  dynamic searchRank;

  SearchproductStorelist({
    this.productId,
    this.storeId,
    this.name,
    this.productCode,
    this.subCategoryId,
    this.subCategoryPath,
    this.subCategoryName,
    this.categoryName,
    this.categoryIcon,
    this.categoryId,
    this.formId,
    this.manuFacturerId,
    this.itemDesc,
    this.pkgSize,
    this.pkgUnit,
    this.itemBarcode,
    this.itemRate,
    this.itemVat,
    this.itemNetRate,
    this.itemMrp,
    this.itemSalePrice,
    this.companyId,
    this.status,
    this.updateOn,
    this.cess,
    this.hsnCode,
    this.approvalStatus,
    this.productImageUrl,
    this.createOn,
    this.isPromo,
    this.isPremiumPromo,
    this.promoText,
    this.premiumPromoText,
    this.isOutOfStock,
    this.currencyRepresentation,
    this.currencyDesc,
    this.minOrderQuantity,
    this.maxOrderQuantity,
    this.uomid,
    this.uomIncrementByQuantity,
    this.productType,
    this.isInFavourites,
    this.uomDesc,
    this.searchRank,
  });

  factory SearchproductStorelist.fromJson(Map<String, dynamic> json) =>
      SearchproductStorelist(
        productId: json["ProductID"],
        storeId: json["StoreID"],
        name: json["Name"],
        productCode: json["ProductCode"],
        subCategoryId: json["SubCategoryID"],
        subCategoryPath: json["SubCategoryPath"],
        subCategoryName: json["SubCategoryName"],
        categoryName: json["CategoryName"],
        categoryIcon: json["CategoryIcon"],
        categoryId: json["CategoryID"],
        formId: json["FormID"],
        manuFacturerId: json["ManuFacturerID"],
        itemDesc: json["ItemDesc"],
        pkgSize: json["PkgSize"],
        pkgUnit: json["PkgUnit"],
        itemBarcode: json["ItemBarcode"],
        itemRate: json["ItemRate"],
        itemVat: json["ItemVat"],
        itemNetRate: json["ItemNetRate"],
        itemMrp: json["ItemMRP"],
        itemSalePrice: json["ItemSalePrice"],
        companyId: json["CompanyID"],
        status: json["Status"],
        updateOn: DateTime.parse(json["UpdateON"]),
        cess: json["Cess"],
        hsnCode: json["HSNCode"],
        approvalStatus: json["ApprovalStatus"],
        productImageUrl: json["ProductImageUrl"],
        createOn: json["CreateOn"],
        isPromo: json["IsPromo"],
        isPremiumPromo: json["IsPremiumPromo"],
        promoText: json["PromoText"],
        premiumPromoText: json["PremiumPromoText"],
        isOutOfStock: json["IsOutOfStock"],
        currencyRepresentation: json["CurrencyRepresentation"],
        currencyDesc: json["CurrencyDesc"],
        minOrderQuantity: json["MinOrderQuantity"],
        maxOrderQuantity: json["MaxOrderQuantity"],
        uomid: json["UOMID"],
        uomIncrementByQuantity: json["UOMIncrementByQuantity"],
        productType: json["ProductType"],
        isInFavourites: json["IsInFavourites"],
        uomDesc: json["UOMDesc"],
        searchRank: json["SearchRank"],
      );

  Map<String, dynamic> toJson() => {
        "ProductID": productId,
        "StoreID": storeId,
        "Name": name,
        "ProductCode": productCode,
        "SubCategoryID": subCategoryId,
        "SubCategoryPath": subCategoryPath,
        "SubCategoryName": subCategoryName,
        "CategoryName": categoryName,
        "CategoryIcon": categoryIcon,
        "CategoryID": categoryId,
        "FormID": formId,
        "ManuFacturerID": manuFacturerId,
        "ItemDesc": itemDesc,
        "PkgSize": pkgSize,
        "PkgUnit": pkgUnit,
        "ItemBarcode": itemBarcode,
        "ItemRate": itemRate,
        "ItemVat": itemVat,
        "ItemNetRate": itemNetRate,
        "ItemMRP": itemMrp,
        "ItemSalePrice": itemSalePrice,
        "CompanyID": companyId,
        "Status": status,
        "UpdateON": updateOn!.toIso8601String(),
        "Cess": cess,
        "HSNCode": hsnCode,
        "ApprovalStatus": approvalStatus,
        "ProductImageUrl": productImageUrl,
        "CreateOn": createOn,
        "IsPromo": isPromo,
        "IsPremiumPromo": isPremiumPromo,
        "PromoText": promoText,
        "PremiumPromoText": premiumPromoText,
        "IsOutOfStock": isOutOfStock,
        "CurrencyRepresentation": currencyRepresentation,
        "CurrencyDesc": currencyDesc,
        "MinOrderQuantity": minOrderQuantity,
        "MaxOrderQuantity": maxOrderQuantity,
        "UOMID": uomid,
        "UOMIncrementByQuantity": uomIncrementByQuantity,
        "ProductType": productType,
        "IsInFavourites": isInFavourites,
        "UOMDesc": uomDesc,
        "SearchRank": searchRank,
      };
}
