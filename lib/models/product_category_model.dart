import 'dart:convert';

class ProductCategory {
  String? categoryID;
  String? name;
  String? code;
  String? companyID;
  String? status;
  String? categoryImageurl;
  String? categoryIconName;
  int? productCount;

  ProductCategory(
      {this.categoryID,
      this.name,
      this.code,
      this.companyID,
      this.status,
      this.categoryImageurl,
      this.categoryIconName,
      this.productCount});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    categoryID = json['CategoryID'];
    name = json['Name'];
    code = json['Code'];
    companyID = json['CompanyID'];
    status = json['Status'];
    categoryImageurl = json['CategoryImageurl'];
    categoryIconName = json['CategoryIconName'];
    productCount = json['ProductCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoryID'] = this.categoryID;
    data['Name'] = this.name;
    data['Code'] = this.code;
    data['CompanyID'] = this.companyID;
    data['Status'] = this.status;
    data['CategoryImageurl'] = this.categoryImageurl;
    data['CategoryIconName'] = this.categoryIconName;
    data['ProductCount'] = this.productCount;
    return data;
  }
}

List<SubCatModelModel> subCatModelModelFromJson(String str) =>
    List<SubCatModelModel>.from(
        json.decode(str).map((x) => SubCatModelModel.fromJson(x)));

String subCatModelModelToJson(List<SubCatModelModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCatModelModel {
  String? subCategoryId;
  String? categoryId;
  String? name;
  String? code;
  String? companyId;
  String? status;
  String? imageurl;
  String? iconName;

  SubCatModelModel({
    this.subCategoryId,
    this.categoryId,
    this.name,
    this.code,
    this.companyId,
    this.status,
    this.imageurl,
    this.iconName,
  });

  factory SubCatModelModel.fromJson(Map<String, dynamic> json) =>
      SubCatModelModel(
        subCategoryId: json["SubCategoryID"],
        categoryId: json["CategoryID"],
        name: json["Name"],
        code: json["Code"],
        companyId: json["CompanyID"],
        status: json["Status"],
        imageurl: json["Imageurl"],
        iconName: json["IconName"],
      );

  Map<String, dynamic> toJson() => {
        "SubCategoryID": subCategoryId,
        "CategoryID": categoryId,
        "Name": name,
        "Code": code,
        "CompanyID": companyId,
        "Status": status,
        "Imageurl": imageurl,
        "IconName": iconName,
      };
}
