// To parse this JSON data, do
//
//     final addNewItemProductModel = addNewItemProductModelFromJson(jsonString);

import 'dart:convert';

AddNewItemProductModel addNewItemProductModelFromJson(String str) =>
    AddNewItemProductModel.fromJson(json.decode(str));

String addNewItemProductModelToJson(AddNewItemProductModel data) =>
    json.encode(data.toJson());

class AddNewItemProductModel {
  String? productId;
  String? storeId;
  String? name;
  String? productCode;
  String? subCategoryId;
  String? formId;
  String? manuFacturerId;
  String? itemDesc;
  double? pkgSize;
  String? pkgUnit;
  String? itemBarcode;
  double? itemRate;
  double? itemVat;
  double? itemNetRate;
  double? itemMrp;
  double? itemSalePrice;
  String? companyId;
  String? status;
  DateTime? updateOn;
  double? cess;
  String? hsnCode;
  String? approvalStatus;
  String? productImageUrl;
  DateTime? createOn;
  bool? isPromo;
  bool? isPremiumPromo;
  String? promoText;
  String? premiumPromoText;
  bool? isOutOfStock;
  String? currencyRepresentation;
  String? currencyDesc;
  double? minOrderQuantity;
  double? maxOrderQuantity;
  int? uomid;
  double? uomIncrementByQuantity;
  int? isInFavourites;
  String? uomDesc;
  int? qaty;

  AddNewItemProductModel({
    this.productId,
    this.qaty,
    this.storeId,
    this.name,
    this.productCode,
    this.subCategoryId,
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
    this.isInFavourites,
    this.uomDesc,
  });

  factory AddNewItemProductModel.fromJson(Map<String, dynamic> json) =>
      AddNewItemProductModel(
        productId: json["ProductID"],
        storeId: json["StoreID"],
        name: json["Name"],
        productCode: json["ProductCode"],
        subCategoryId: json["SubCategoryID"],
        formId: json["FormID"],
        manuFacturerId: json["ManuFacturerID"],
        itemDesc: json["ItemDesc"],
        pkgSize: json["PkgSize"].toDouble(),
        pkgUnit: json["PkgUnit"],
        itemBarcode: json["ItemBarcode"],
        itemRate: json["ItemRate"].toDouble(),
        itemVat: json["ItemVat"].toDouble(),
        itemNetRate: json["ItemNetRate"].toDouble(),
        itemMrp: json["ItemMRP"].toDouble(),
        itemSalePrice: json["ItemSalePrice"].toDouble(),
        companyId: json["CompanyID"],
        status: json["Status"],
        updateOn:
            json["UpdateON"] == null ? null : DateTime.parse(json["UpdateON"]),
        cess: json["Cess"].toDouble(),
        hsnCode: json["HSNCode"],
        approvalStatus: json["ApprovalStatus"],
        productImageUrl: json["ProductImageUrl"],
        createOn:
            json["CreateOn"] == null ? null : DateTime.parse(json["CreateOn"]),
        isPromo: json["IsPromo"],
        isPremiumPromo: json["IsPremiumPromo"],
        promoText: json["PromoText"],
        premiumPromoText: json["PremiumPromoText"],
        isOutOfStock: json["IsOutOfStock"],
        currencyRepresentation: json["CurrencyRepresentation"],
        currencyDesc: json["CurrencyDesc"],
        minOrderQuantity: json["MinOrderQuantity"].toDouble(),
        maxOrderQuantity: json["MaxOrderQuantity"].toDouble(),
        uomid: json["UOMID"],
        uomIncrementByQuantity: json["UOMIncrementByQuantity"].toDouble(),
        isInFavourites: json["IsInFavourites"],
        uomDesc: json["UOMDesc"],
      );

  Map<String, dynamic> toJson() => {
        "ProductID": productId,
        "StoreID": storeId,
        "Name": name,
        "ProductCode": productCode,
        "SubCategoryID": subCategoryId,
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
        "CreateOn": createOn!.toIso8601String(),
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
        "IsInFavourites": isInFavourites,
        "UOMDesc": uomDesc,
      };
}
