
class StoreImageTable {
    String? storeImageId;
    String? storeId;
    String? storeImageDesc;
    String? storeImagePath;
    dynamic isLogo;

    StoreImageTable({
        this.storeImageId,
        this.storeId,
        this.storeImageDesc,
        this.storeImagePath,
        this.isLogo,
    });

    factory StoreImageTable.fromJson(Map<String, dynamic> json) => StoreImageTable(
        storeImageId: json["StoreImageID"],
        storeId: json["StoreID"],
        storeImageDesc: json["StoreImageDesc"],
        storeImagePath: json["StoreImagePath"],
        isLogo: json["IsLogo"],
    );

    Map<String, dynamic> toJson() => {
        "StoreImageID": storeImageId,
        "StoreID": storeId,
        "StoreImageDesc": storeImageDesc,
        "StoreImagePath": storeImagePath,
        "IsLogo": isLogo,
    };
}
