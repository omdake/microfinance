import 'package:microfinance/utils/extension/extension/map_extensions.dart';

class AddToCart {
  String? productID;
  int? quntity;
  String? storeID;
  double? itemRate;
  double? itemSalePrice;
  String? userId;
  bool? isDelivery;

  AddToCart(
      {this.productID,
      this.quntity,
      this.storeID,
      this.itemRate,
      this.itemSalePrice,
      this.userId,
      this.isDelivery});

  AddToCart.fromJson(Map<String, dynamic> json) {
    productID = json['ProductID'];
    quntity = json['Quntity'];
    storeID = json['StoreID'];
    itemRate = json['ItemRate'];
    itemSalePrice = json['ItemSalePrice'];
    userId = json['UserId'];
    isDelivery = json['IsDelivery'];
  }

 factory AddToCart.empty() => AddToCart(
  productID : defaultString,
    quntity :defaultInt,
    storeID : defaultString,
    itemRate : defaultDouble,
    itemSalePrice : defaultDouble,
    userId :defaultString,
    isDelivery :defaultBool
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductID'] = this.productID;
    data['Quntity'] = this.quntity;
    data['StoreID'] = this.storeID;
    data['ItemRate'] = this.itemRate;
    data['ItemSalePrice'] = this.itemSalePrice;
    data['UserId'] = this.userId;
    data['IsDelivery'] = this.isDelivery;
    return data;
  }


}
