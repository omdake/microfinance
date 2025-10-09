// To parse this JSON data, do
//
//     final orderResponseModel = orderResponseModelFromJson(jsonString);

import 'dart:convert';

OrderResponseModel orderResponseModelFromJson(String str) => OrderResponseModel.fromJson(json.decode(str));

String orderResponseModelToJson(OrderResponseModel data) => json.encode(data.toJson());

class OrderResponseModel {
    bool? success;
    String? message;
    Response? response;

    OrderResponseModel({
        this.success,
        this.message,
        this.response,
    });

    factory OrderResponseModel.fromJson(Map<String, dynamic> json) => OrderResponseModel(
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
    List<OrderStore>? orderStore;

    Response({
        this.orderStore,
    });

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        orderStore: List<OrderStore>.from(json["OrderStore"].map((x) => OrderStore.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "OrderStore": List<dynamic>.from(orderStore!.map((x) => x.toJson())),
    };
}

class OrderStore {
    String? orderStoresId;
    String? deliveryPartnerName;
    double? deliveryCharges;
    double? totalWtOfParcels;
    int? noOfParcels;
    List<Parcel>? parcels;

    OrderStore({
        this.orderStoresId,
        this.deliveryPartnerName,
        this.deliveryCharges,
        this.totalWtOfParcels,
        this.noOfParcels,
        this.parcels,
    });

    factory OrderStore.fromJson(Map<String, dynamic> json) => OrderStore(
        orderStoresId: json["OrderStoresID"],
        deliveryPartnerName: json["DeliveryPartnerName"],
        deliveryCharges: json["DeliveryCharges"].toDouble(),
        totalWtOfParcels: json["TotalWtOfParcels"].toDouble(),
        noOfParcels: json["NoOfParcels"],
        parcels: List<Parcel>.from(json["Parcels"].map((x) => Parcel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "OrderStoresID": orderStoresId,
        "DeliveryPartnerName": deliveryPartnerName,
        "DeliveryCharges": deliveryCharges,
        "TotalWtOfParcels": totalWtOfParcels,
        "NoOfParcels": noOfParcels,
        "Parcels": List<dynamic>.from(parcels!.map((x) => x.toJson())),
    };
}

class Parcel {
    String? orderStorePackagingId;
    int? parcelNo;
    String? stuartJobId;
    String? stuartJobStatus;
    String? stuartJobDeliveryId;
    String? stuartJobDeliveryStatus;
    String? stuartTrackingUrl;
    String? etaPickup;
    String? etaDropoff;
    List<OrderParcelProductList>? orderParcelProductList;

    Parcel({
        this.orderStorePackagingId,
        this.parcelNo,
        this.stuartJobId,
        this.stuartJobStatus,
        this.stuartJobDeliveryId,
        this.stuartJobDeliveryStatus,
        this.stuartTrackingUrl,
        this.etaPickup,
        this.etaDropoff,
        this.orderParcelProductList,
    });

    factory Parcel.fromJson(Map<String, dynamic> json) => Parcel(
        orderStorePackagingId: json["OrderStorePackagingID"],
        parcelNo: json["ParcelNo"],
        stuartJobId: json["StuartJobID"],
        stuartJobStatus: json["StuartJobStatus"],
        stuartJobDeliveryId: json["StuartJobDeliveryID"],
        stuartJobDeliveryStatus: json["StuartJobDeliveryStatus"],
        stuartTrackingUrl: json["StuartTrackingUrl"],
        etaPickup: json["etaPickup"],
        etaDropoff: json["etaDropoff"],
        orderParcelProductList: List<OrderParcelProductList>.from(json["OrderParcelProductList"].map((x) => OrderParcelProductList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "OrderStorePackagingID": orderStorePackagingId,
        "ParcelNo": parcelNo,
        "StuartJobID": stuartJobId,
        "StuartJobStatus": stuartJobStatus,
        "StuartJobDeliveryID": stuartJobDeliveryId,
        "StuartJobDeliveryStatus": stuartJobDeliveryStatus,
        "StuartTrackingUrl": stuartTrackingUrl,
        "etaPickup": etaPickup,
        "etaDropoff": etaDropoff,
        "OrderParcelProductList": List<dynamic>.from(orderParcelProductList!.map((x) => x.toJson())),
    };
}

class OrderParcelProductList {
    String? orderProductId;
    String? itemId;
    double? qtyOrWeight;
    String? productName;
    double? itemShippingWeight;
    String? itemImagePath;
    double? pkgSize;
    String? pkgUnit;
    int? uomid;
    String? uomDesc;
    double? itemMrp;
    double? itemSalePrice;

    OrderParcelProductList({
        this.orderProductId,
        this.itemId,
        this.qtyOrWeight,
        this.productName,
        this.itemShippingWeight,
        this.itemImagePath,
        this.pkgSize,
        this.pkgUnit,
        this.uomid,
        this.uomDesc,
        this.itemMrp,
        this.itemSalePrice,
    });

    factory OrderParcelProductList.fromJson(Map<String, dynamic> json) => OrderParcelProductList(
        orderProductId: json["OrderProductID"],
        itemId: json["ItemID"],
        qtyOrWeight: json["QtyOrWeight"],
        productName: json["ProductName"],
        itemShippingWeight: json["ItemShippingWeight"].toDouble(),
        itemImagePath: json["ItemImagePath"],
        pkgSize: json["PkgSize"].toDouble(),
        pkgUnit: json["PkgUnit"],
        uomid: json["UOMID"],
        uomDesc: json["UOMDesc"],
        itemMrp: json["ItemMRP"].toDouble(),
        itemSalePrice: json["ItemSalePrice"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "OrderProductID": orderProductId,
        "ItemID": itemId,
        "QtyOrWeight": qtyOrWeight,
        "ProductName": productName,
        "ItemShippingWeight": itemShippingWeight,
        "ItemImagePath": itemImagePath,
        "PkgSize": pkgSize,
        "PkgUnit": pkgUnit,
        "UOMID": uomid,
        "UOMDesc": uomDesc,
        "ItemMRP": itemMrp,
        "ItemSalePrice": itemSalePrice,
    };
}
