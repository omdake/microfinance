import 'dart:convert';

import 'package:microfinance/utils/extension/extension/map_extensions.dart';

AuthUserDataModel authUserDataModelFromJson(String str) =>
    AuthUserDataModel.fromJson(json.decode(str));

String authUserDataModelToJson(AuthUserDataModel data) =>
    json.encode(data.toJson());

class AuthUserDataModel {
  String? userId;
  String? emailId;
  String? userName;
  String? roleName;
  String? name;
  String? zipCode;
  String? zipCodeId;
  String? clientId;
  bool? userActivated;
  String? sessionId;

  AuthUserDataModel({
    this.userId,
    this.emailId,
    this.userName,
    this.roleName,
    this.name,
    this.zipCode,
    this.zipCodeId,
    this.clientId,
    this.userActivated,
    this.sessionId,
  });

  factory AuthUserDataModel.fromJson(Map<String, dynamic> json) =>
      AuthUserDataModel(
        userId: json["UserID"],
        emailId: json["EmailID"],
        userName: json["UserName"],
        roleName: json["RoleName"],
        name: json["Name"],
        zipCode: json["ZipCode"],
        zipCodeId: json["ZipCodeId"],
        clientId: json["ClientID"],
        userActivated: json["UserActivated"],
        sessionId: json["SessionID"],
      );

  Map<String, dynamic> toJson() => {
        "UserID": userId,
        "EmailID": emailId,
        "UserName": userName,
        "RoleName": roleName,
        "Name": name,
        "ZipCode": zipCode,
        "ZipCodeId": zipCodeId,
        "ClientID": clientId,
        "UserActivated": userActivated,
        "SessionID": sessionId,
      };

  factory AuthUserDataModel.empty() => AuthUserDataModel(
        clientId: defaultString,
        userId: defaultString,
        emailId: defaultString,
        userName: defaultString,
        roleName: defaultString,
        name: defaultString,
        zipCode: defaultString,
        zipCodeId: defaultString,
        userActivated: false,
        sessionId: defaultString,
      );
}
