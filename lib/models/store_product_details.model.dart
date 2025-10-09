class ProductStoreDetails {
  String? productType;
  String? productID;
  String? storeID;
  String? name;
  String? productCode;
  String? subCategoryID;
  String? formID;
  String? manuFacturerID;
  String? itemDesc;
  double? pkgSize;
  String? pkgUnit;
  String? itemBarcode;
  double? itemRate;
  // double? itemVat;
  // double? itemNetRate;
  double? itemMRP;
  double? itemSalePrice;
  String? companyID;
  String? status;
  String? updateON;
  // double? cess;
  String? hSNCode;
  String? approvalStatus;
  String? ProductImageUrl;
  String? createOn;
  bool? isPromo;
  bool? isPremiumPromo;
  String? promoText;
  String? premiumPromoText;
  bool? isOutOfStock;
  String? currencyRepresentation;
  String? currencyDesc;
  // double? uOMID;
  double? uOMIncrementByQuantity;
  double? minOrderQuantity;
  double? maxOrderQuantity;
  int? isInFavourites;
  String? uOMDesc;
  // double? column1;
  String? dataType;
  int? qaty;

  ProductStoreDetails(
      {this.productType,
      this.qaty,
      this.productID,
      this.storeID,
      this.name,
      this.productCode,
      this.subCategoryID,
      this.formID,
      this.manuFacturerID,
      this.itemDesc,
      this.pkgSize,
      this.pkgUnit,
      this.itemBarcode,
      this.itemRate,
      // this.itemVat,
      // this.itemNetRate,
      this.itemMRP,
      this.itemSalePrice,
      this.companyID,
      this.status,
      this.updateON,
      // this.cess,
      this.hSNCode,
      this.approvalStatus,
      this.ProductImageUrl,
      this.createOn,
      this.isPromo,
      this.isPremiumPromo,
      this.promoText,
      this.premiumPromoText,
      this.isOutOfStock,
      this.currencyRepresentation,
      this.currencyDesc,
      // this.uOMID,
      // this.uOMIncrementByQuantity,
      // this.minOrderQuantity,
      // this.maxOrderQuantity,
      this.isInFavourites,
      this.uOMDesc,
      // this.column1,
      this.dataType});

  ProductStoreDetails.fromJson(Map<String, dynamic> json) {
    qaty = 0;
    productType = json['ProductType'];
    productID = json['ProductID'];
    storeID = json['StoreID'];
    name = json['Name'];
    productCode = json['ProductCode'];
    subCategoryID = json['SubCategoryID'];
    formID = json['FormID'];
    manuFacturerID = json['ManuFacturerID'];
    itemDesc = json['ItemDesc'];
    pkgSize = json['PkgSize'];
    pkgUnit = json['PkgUnit'];
    itemBarcode = json['ItemBarcode'];
    itemRate = json['ItemRate'];
    // itemVat = json['ItemVat'];
    // itemNetRate = json['ItemNetRate'];
    itemMRP = json['ItemMRP'];
    itemSalePrice = json['ItemSalePrice'];
    companyID = json['CompanyID'];
    status = json['Status'];
    updateON = json['UpdateON'];
    // cess = json['Cess'];
    hSNCode = json['HSNCode'];
    approvalStatus = json['ApprovalStatus'];
    ProductImageUrl = json['ProductImageUrl'];
    createOn = json['CreateOn'];
    isPromo = json['IsPromo'];
    isPremiumPromo = json['IsPremiumPromo'];
    promoText = json['PromoText'];
    premiumPromoText = json['PremiumPromoText'];
    isOutOfStock = json['IsOutOfStock'];
    currencyRepresentation = json['CurrencyRepresentation'];
    currencyDesc = json['CurrencyDesc'];
    // uOMID = json['UOMID'];
    uOMIncrementByQuantity = json['UOMIncrementByQuantity'] ?? 1.0;
    minOrderQuantity = json['MinOrderQuantity'] ?? 1.0;
    maxOrderQuantity = json['MaxOrderQuantity'] ?? 100.0;
    isInFavourites = json['IsInFavourites'];
    uOMDesc = json['UOMDesc'];
    // column1 = json['Column1'];
    dataType = json['DataType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductType'] = this.productType;
    data['ProductID'] = this.productID;
    data['StoreID'] = this.storeID;
    data['Name'] = this.name;
    data['ProductCode'] = this.productCode;
    data['SubCategoryID'] = this.subCategoryID;
    data['FormID'] = this.formID;
    data['ManuFacturerID'] = this.manuFacturerID;
    data['ItemDesc'] = this.itemDesc;
    data['PkgSize'] = this.pkgSize;
    data['PkgUnit'] = this.pkgUnit;
    data['ItemBarcode'] = this.itemBarcode;
    data['ItemRate'] = this.itemRate;
    // data['ItemVat'] = this.itemVat;
    // data['ItemNetRate'] = this.itemNetRate;
    data['ItemMRP'] = this.itemMRP;
    data['ItemSalePrice'] = this.itemSalePrice;
    data['CompanyID'] = this.companyID;
    data['Status'] = this.status;
    data['UpdateON'] = this.updateON;
    // data['Cess'] = this.cess;
    data['HSNCode'] = this.hSNCode;
    data['ApprovalStatus'] = this.approvalStatus;
    data['ProductImageUrl'] = this.ProductImageUrl;
    data['CreateOn'] = this.createOn;
    data['IsPromo'] = this.isPromo;
    data['IsPremiumPromo'] = this.isPremiumPromo;
    data['PromoText'] = this.promoText;
    data['PremiumPromoText'] = this.premiumPromoText;
    data['IsOutOfStock'] = this.isOutOfStock;
    data['CurrencyRepresentation'] = this.currencyRepresentation;
    data['CurrencyDesc'] = this.currencyDesc;
    // data['UOMID'] = this.uOMID;
    data['UOMIncrementByQuantity'] = this.uOMIncrementByQuantity;
    // data['MinOrderQuantity'] = this.minOrderQuantity;
    // data['MaxOrderQuantity'] = this.maxOrderQuantity;
    data['IsInFavourites'] = this.isInFavourites;
    data['UOMDesc'] = this.uOMDesc;
    // data['Column1'] = this.column1;
    // data['DataType'] = this.dataType;
    return data;
  }
}
