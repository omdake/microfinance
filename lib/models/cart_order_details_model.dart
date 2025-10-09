import 'dart:convert';

CartOrderDetails cartOrderDetailsFromJson(String str) =>
    CartOrderDetails.fromJson(json.decode(str));

String cartOrderDetailsToJson(CartOrderDetails data) =>
    json.encode(data.toJson());

class CartOrderDetails {
  String? orderStoresId;
  String? orderId;
  String? storeId;
  int? itemTotal;
  double? deliveryFee;
  double? serviceFee;
  double? longDistanceFee;
  double? packagingFees;
  double? taxes;
  double? tip;
  double? discount;
  double? rewards;
  double? toPay;
  double? pickUpAccetsFee;
  double? deliveryAmount;
  double? refundAmount;
  String? storeInstructions;
  String? deliveryOrPickupOrder;
  String? expectedDeliveryDate;
  DateTime? deliveryDayTime;
  DateTime? pickupDayTime;
  String? orderno;
  String? orderDate;
  String? storeName;
  String? storeZipCode;
  String? storeZipCodeValue;
  double? storeLatitude;
  double? storeLongitude;
  String? storeImagePath;
  int? statusId;
  String? orderStatus;
  String? address1;
  String? address2;
  String? address3;
  String? cityCode;
  String? cityName;
  String? zipcodeId;
  String? zipcode;
  String? deliveryorpickupLatitude;
  String? deliveryorpickupLongitude;
  String? paymethMethod;
  String? cardEndingWith;
  String? clientName;
  String? clientPhone;
  String? deliveryInstructions;
  String? userId;
  String? orderDeliveryID;
  String? isLeaveAtMyDoor;
  String? storeTimingID;
  String? stripePaymentIndentId;
  String? stripePaymentMethodID;
  String? paymentMethodID;
  dynamic bagCharges;
  double? maxCartAmount;
  String? deliveryManagementBy;

  List<OrderProductList>? orderProductList;

  CartOrderDetails({
    this.orderStoresId,
    this.orderId,
    this.storeId,
    this.itemTotal,
    this.deliveryFee,
    this.serviceFee,
    this.longDistanceFee,
    this.packagingFees,
    this.taxes,
    this.tip,
    this.discount,
    this.rewards,
    this.toPay,
    this.storeInstructions,
    this.deliveryOrPickupOrder,
    this.expectedDeliveryDate,
    this.deliveryDayTime,
    this.pickupDayTime,
    this.orderno,
    this.orderDate,
    this.storeName,
    this.storeZipCode,
    this.storeZipCodeValue,
    this.storeLatitude,
    this.storeLongitude,
    this.storeImagePath,
    this.statusId,
    this.orderStatus,
    this.address1,
    this.address2,
    this.address3,
    this.cityCode,
    this.cityName,
    this.zipcodeId,
    this.zipcode,
    this.deliveryorpickupLatitude,
    this.deliveryorpickupLongitude,
    this.paymethMethod,
    this.cardEndingWith,
    this.clientName,
    this.clientPhone,
    this.deliveryInstructions,
    this.userId,
    this.orderProductList,
    this.isLeaveAtMyDoor,
    this.orderDeliveryID,
    this.paymentMethodID,
    this.storeTimingID,
    this.stripePaymentIndentId,
    this.stripePaymentMethodID,
    this.pickUpAccetsFee,
    this.deliveryAmount,
    this.refundAmount,
    this.bagCharges,
    this.maxCartAmount,
    this.deliveryManagementBy,
  });

  factory CartOrderDetails.fromJson(Map<String, dynamic> json) =>
      CartOrderDetails(
        orderStoresId: json["OrderStoresID"],
        orderId: json["OrderID"],
        storeId: json["StoreID"],
        itemTotal: json["ItemTotal"],
        deliveryFee: json["DeliveryFee"].toDouble(),
        serviceFee: json["ServiceFee"],
        longDistanceFee: json["LongDistanceFee"].toDouble(),
        packagingFees: json["PackagingFees"].toDouble(),
        taxes: json["Taxes"].toDouble(),
        tip: json["Tip"].toDouble(),
        discount: json["Discount"].toDouble(),
        rewards: json["Rewards"].toDouble(),
        toPay: json["ToPay"].toDouble(),
        storeInstructions: json["StoreInstructions"],
        deliveryOrPickupOrder: json["DeliveryOrPickupOrder"],
        expectedDeliveryDate: json["ExpectedDeliveryDate"],
        deliveryDayTime: json["DeliveryDayTime"] != null
            ? DateTime.parse(json["DeliveryDayTime"])
            : null,
        pickupDayTime: json["PickupDayTime"] != null
            ? DateTime.parse(json["PickupDayTime"])
            : null,
        orderno: json["Orderno"],
        orderDate: json["OrderDate"],
        storeName: json["StoreName"],
        storeZipCode: json["StoreZipCode"],
        storeZipCodeValue: json["SoreZipCodeValue"],
        storeLatitude: json["StoreLatitude"].toDouble(),
        storeLongitude: json["StoreLongitude"].toDouble(),
        storeImagePath: json["StoreImagePath"],
        statusId: json["StatusID"],
        orderStatus: json["OrderStatus"],
        address1: json["Address1"],
        address2: json["Address2"],
        address3: json["Address3"],
        cityCode: json["CityCode"],
        cityName: json["CityName"],
        zipcodeId: json["ZipcodeID"] != null
           ? json["ZipcodeID"]
           : "",
        zipcode: json["Zipcode"],
        deliveryorpickupLatitude: json["DeliveryorpickupLatitude"] ?? 0.0,
        deliveryorpickupLongitude: json["DeliveryorpickupLongitude"] ?? 0.0,
        paymethMethod: json["PaymethMethod"],
        cardEndingWith: json["CardEndingWith"],
        clientName: json["ClientName"],
        clientPhone: json["ClientPhone"],
        deliveryInstructions: json["DeliveryInstructions"],
        userId: json["UserID"],
        orderDeliveryID: json["OrderDeliveryID"] != null
           ? json["OrderDeliveryID"]
           : "",
        isLeaveAtMyDoor: json["IsLeaveAtMyDoor"], 
        storeTimingID: json["StoreTimingID"],
        stripePaymentIndentId: json["StripePaymentIndentId"],
        paymentMethodID: json["PaymentMethodID"],
        stripePaymentMethodID: json["StripePaymentMethodID"],
        pickUpAccetsFee: json["PickUpAssistFee"],
        deliveryAmount: json["DeliveryAmount"],
        refundAmount: json["RefundAmount"],
        orderProductList: json["OrderProductList"] != null
           ? List<OrderProductList>.from(json["OrderProductList"].map((x) => OrderProductList.fromJson(x)))
           : [],
        bagCharges: json["BagCharges"],
        maxCartAmount: json["MaxCartAmount"],
        deliveryManagementBy: json["DelveryManagementby"]
      );

  Map<String, dynamic> toJson() => {
        "OrderStoresID": orderStoresId,
        "OrderID": orderId,
        "StoreID": storeId,
        "ItemTotal": itemTotal,
        "DeliveryFee": deliveryFee,
        "ServiceFee": serviceFee,
        "LongDistanceFee": longDistanceFee,
        "PackagingFees": packagingFees,
        "Taxes": taxes,
        "Tip": tip,
        "Discount": discount,
        "Rewards": rewards,
        "ToPay": toPay,
        "StoreInstructions": storeInstructions,
        "DeliveryOrPickupOrder": deliveryOrPickupOrder,
        "ExpectedDeliveryDate": expectedDeliveryDate,
        "DeliveryDayTime": deliveryDayTime!.toIso8601String(),
        "PickupDayTime": pickupDayTime!.toIso8601String(),
        "Orderno": orderno,
        "OrderDate": orderDate,
        "StoreName": storeName,
        "StoreZipCode": storeZipCode,
        "SoreZipCodeValue": storeZipCodeValue,
        "StoreLatitude": storeLatitude,
        "StoreLongitude": storeLongitude,
        "StoreImagePath": storeImagePath,
        "StatusID": statusId,
        "OrderStatus": orderStatus,
        "Address1": address1,
        "Address2": address2,
        "Address3": address3,
        "CityCode": cityCode,
        "CityName": cityName,
        "ZipcodeID": zipcodeId,
        "Zipcode": zipcode,
        "DeliveryorpickupLatitude": deliveryorpickupLatitude,
        "DeliveryorpickupLongitude": deliveryorpickupLongitude,
        "PaymethMethod": paymethMethod,
        "CardEndingWith": cardEndingWith,
        "ClientName": clientName,
        "ClientPhone": clientPhone,
        "DeliveryInstructions": deliveryInstructions,
        "UserID": userId,
        "OrderDeliveryID": orderDeliveryID,
        "IsLeaveAtMyDoor": isLeaveAtMyDoor,
        "StoreTimingID": storeTimingID,
        "StripePaymentIndentId": stripePaymentIndentId,
        "PaymentMethodID": paymentMethodID,
        "StripePaymentMethodID": stripePaymentMethodID,
        "PickUpAssistFee": pickUpAccetsFee,
        "DeliveryAmount": deliveryAmount,
        "RefundAmount": refundAmount,
        "BagCharges": bagCharges,
        "MaxCartAmount": maxCartAmount,
        "DelveryManagementby":deliveryManagementBy,
        "OrderProductList":
            List<dynamic>.from(orderProductList!.map((x) => x.toJson())),
      };
}

class OrderProductList {
  String? orderId;
  String? orderProductId;
  String? orderStoresId;
  String? productId;
  String? storeId;
  String? storeName;
  String? storeImagePath;
  String? storeAddress;
  String? cartOrderNumber;
  String? productName;
  String? productCode;
  String? productDesc;
  String? itemImagePath;
  double? itemMrp;
  double? qtyOrWeight;
  double? customerPrice;
  double? productSalePrice;
  double? pkgSize;
  String? pkgUnit;
  int? uomid;
  String? uomDesc;
  double? itemRate;
  double? uomIncrementByQuantity;
  double? minOrderQuantity;
  double? maxOrderQuantity;
  double? minOrderValue;
  double? maxOrderValue;
  bool? isSpecialProduct;
  double? itemShippingWeight;
  double? freeDeliveryLimit;
  String? currencyRepresentation;
  String? currencyDesc;
  int? orderProductStatusId;
  bool? allowBestReplacement;
  String? allowBestReplacementText;
  String? replacementProductId;
  String? replacementProductName;
  String? replacementOptionDescription;
  String? storeInstructions;
  String? productInstruction;
  String? shoppedProductId;
  double? shoppedQtyOrWeight;
  String? shoppedProductName;
  double? shopPrice;
  double? ourPrice;
  double? totalShoppingAmount;
  double? totalCustomerAmount;
  double? qtyCancelled;
  String? cancelledReason;
  String? shopperRemark;
  String? replacedProductImageUrl;
  double? shoppedItemSalePrice;
  String? shoppedProductImageUrl;
  double? shoppedItemMRP;
  double? shoppedItemPkgSize;
  String? shoppedItemPkgUnit;
  String? isNewlyAdded;

  bool? isedit;
  bool? isNewProduct;
  int? itemNotAvailableOption;

  OrderProductList({
    this.orderId,
    this.orderProductId,
    this.orderStoresId,
    this.productId,
    this.storeId,
    this.storeName,
    this.storeImagePath,
    this.storeAddress,
    this.cartOrderNumber,
    this.productName,
    this.productCode,
    this.productDesc,
    this.itemImagePath,
    this.itemMrp,
    this.qtyOrWeight,
    this.customerPrice,
    this.productSalePrice,
    this.pkgSize,
    this.pkgUnit,
    this.uomid,
    this.uomDesc,
    this.itemRate,
    this.uomIncrementByQuantity,
    this.minOrderQuantity,
    this.maxOrderQuantity,
    this.minOrderValue,
    this.maxOrderValue,
    this.isSpecialProduct,
    this.itemShippingWeight,
    this.freeDeliveryLimit,
    this.currencyRepresentation,
    this.currencyDesc,
    this.orderProductStatusId,
    this.allowBestReplacement,
    this.allowBestReplacementText,
    this.replacementProductId,
    this.replacementProductName,
    this.replacementOptionDescription,
    this.storeInstructions,
    this.productInstruction,
    this.shoppedProductId,
    this.shoppedQtyOrWeight,
    this.shoppedProductName,
    this.shopPrice,
    this.ourPrice,
    this.totalShoppingAmount,
    this.totalCustomerAmount,
    this.qtyCancelled,
    this.cancelledReason,
    this.shopperRemark,
    this.replacedProductImageUrl,
    this.shoppedItemSalePrice,
    this.shoppedProductImageUrl,
    this.shoppedItemMRP,
    this.shoppedItemPkgSize,
    this.shoppedItemPkgUnit,
    this.isNewlyAdded,
    this.isedit,
    this.isNewProduct,
    this.itemNotAvailableOption,
  });

  factory OrderProductList.fromJson(Map<String, dynamic> json) =>
      OrderProductList(
        orderId: json["OrderID"],
        orderProductId: json["OrderProductID"],
        orderStoresId: json["OrderStoresID"],
        productId: json["ProductID"],
        storeId: json["StoreID"],
        storeName: json["StoreName"],
        storeImagePath: json["StoreImagePath"],
        storeAddress: json["StoreAddress"],
        cartOrderNumber: json["CartOrderNumber"],
        productName: json["ProductName"],
        productCode: json["ProductCode"],
        productDesc: json["ProductDesc"],
        itemImagePath: json["ItemImagePath"],
        itemMrp: json["ItemMRP"].toDouble(),
        qtyOrWeight: json["QtyOrWeight"].toDouble(),
        customerPrice: json["CustomerPrice"].toDouble(),
        productSalePrice: json["ProductSalePrice"].toDouble(),
        pkgSize: json["PkgSize"].toDouble(),
        pkgUnit: json["PkgUnit"],
        uomid: json["UOMID"],
        uomDesc: json["UOMDesc"],
        itemRate: json["ItemRate"].toDouble(),
        uomIncrementByQuantity: json["UOMIncrementByQuantity"].toDouble(),
        minOrderQuantity: json["MinOrderQuantity"].toDouble(),
        maxOrderQuantity: json["MaxOrderQuantity"].toDouble(),
        minOrderValue: json["MinOrderValue"].toDouble(),
        maxOrderValue: json['MaxOrderValue'],
        isSpecialProduct: json["IsSpecialProduct"],
        itemShippingWeight: json["ItemShippingWeight"],
        freeDeliveryLimit: json["FreeDeliveryLimit"],
        currencyRepresentation: json["CurrencyRepresentation"],
        currencyDesc: json["CurrencyDesc"],
        orderProductStatusId: json["OrderProductStatusID"],
        allowBestReplacement: json["AllowBestReplacement"],
        allowBestReplacementText: json["AllowBestReplacementText"],
        replacementProductId: json["ReplacementProductID"],
        replacementProductName: json["ReplacementProductName"],
        replacementOptionDescription: json["ReplacementOptionDescription"],
        storeInstructions: json["StoreInstructions"],
        productInstruction: json["ProductInstruction"],
        shoppedProductId: json["ShoppedProductID"],
        shoppedQtyOrWeight: json["ShoppedQtyOrWeight"],
        shoppedProductName: json["ShoppedProductName"],
        shopPrice: json["ShopPrice"].toDouble(),
        ourPrice: json["OurPrice"].toDouble(),
        totalShoppingAmount: json["TotalShoppingAmount"].toDouble(),
        totalCustomerAmount: json["TotalCustomerAmount"].toDouble(),
        qtyCancelled: json["QtyCancelled"].toDouble(),
        cancelledReason: json["CancelledReason"],
        shopperRemark: json["ShopperRemark"],
        replacedProductImageUrl: json["ReplacedProductImageUrl"],
        shoppedItemSalePrice: json["ShoppedItemSalePrice"].toDouble(),
        shoppedProductImageUrl: json["ShoppedProductImageUrl"],
        shoppedItemMRP: json["ShoppedItemMRP"].toDouble(),
        shoppedItemPkgSize: json["ShoppedItemPkgSize"].toDouble(),
        shoppedItemPkgUnit: json["ShoppedItemPkgUnit"],
        isNewlyAdded: json["IsNewlyAdded"],
        isedit: false,
        isNewProduct: false,
        itemNotAvailableOption: json["ReplacementProductID"] !=
                "00000000-0000-0000-0000-000000000000"
            ? 3
            : json["ReplacementOptionDescription"] == "Do Not Replace"
                ? 2
                : 1,
      );

  Map<String, dynamic> toJson() => {
        "OrderID": orderId,
        "OrderProductID": orderProductId,
        "OrderStoresID": orderStoresId,
        "ProductID": productId,
        "StoreID": storeId,
        "StoreName": storeName,
        "StoreImagePath": storeImagePath,
        "StoreAddress": storeAddress,
        "CartOrderNumber": cartOrderNumber,
        "ProductName": productName,
        "ProductCode": productCode,
        "ProductDesc": productDesc,
        "ItemImagePath": itemImagePath,
        "ItemMRP": itemMrp,
        "QtyOrWeight": qtyOrWeight,
        "CustomerPrice": customerPrice,
        "ProductSalePrice": productSalePrice,
        "PkgSize": pkgSize,
        "PkgUnit": pkgUnit,
        "UOMID": uomid,
        "UOMDesc": uomDesc,
        "ItemRate": itemRate,
        "UOMIncrementByQuantity": uomIncrementByQuantity,
        "MinOrderQuantity": minOrderQuantity,
        "MaxOrderQuantity": maxOrderQuantity,
        "MinOrderValue": minOrderValue,
        "MaxOrderValue": maxOrderValue,
        "IsSpecialProduct": isSpecialProduct,
        "ItemShippingWeight": itemShippingWeight,
        "FreeDeliveryLimit": freeDeliveryLimit,
        "CurrencyRepresentation": currencyRepresentation,
        "CurrencyDesc": currencyDesc,
        "OrderProductStatusID": orderProductStatusId,
        "AllowBestReplacement": allowBestReplacement,
        "AllowBestReplacementText": allowBestReplacementText,
        "ReplacementProductID": replacementProductId,
        "ReplacementProductName": replacementProductName,
        "ReplacementOptionDescription": replacementOptionDescription,
        "StoreInstructions": storeInstructions,
        "ProductInstruction": productInstruction,
        "ShoppedProductID": shoppedProductId,
        "ShoppedQtyOrWeight": shoppedQtyOrWeight,
        "ShoppedProductName": shoppedProductName,
        "ShopPrice": shopPrice,
        "OurPrice": ourPrice,
        "TotalShoppingAmount": totalShoppingAmount,
        "TotalCustomerAmount": totalCustomerAmount,
        "QtyCancelled": qtyCancelled,
        "CancelledReason": cancelledReason,
        "ShopperRemark": shopperRemark,
        "ReplacedProductImageUrl": replacedProductImageUrl,
        "ShoppedItemSalePrice": shoppedItemSalePrice,
        "ShoppedProductImageUrl": shoppedProductImageUrl,
        "ShoppedItemMRP": shoppedItemMRP,
        "ShoppedItemPkgSize": shoppedItemPkgSize,
        "ShoppedItemPkgUnit": shoppedItemPkgUnit,
      };
}
