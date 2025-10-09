import 'dart:convert';

List<GetAppSettingsMoodel> getAppSettingsMoodelFromJson(String str) =>
    List<GetAppSettingsMoodel>.from(
        json.decode(str).map((x) => GetAppSettingsMoodel.fromJson(x)));

String getAppSettingsMoodelToJson(List<GetAppSettingsMoodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAppSettingsMoodel {
  String? appSettingKey;
  String? appSettingValue;

  GetAppSettingsMoodel({
    this.appSettingKey,
    this.appSettingValue,
  });

  factory GetAppSettingsMoodel.fromJson(Map<String, dynamic> json) =>
      GetAppSettingsMoodel(
        appSettingKey: json["AppSettingKey"],
        appSettingValue: json["AppSettingValue"],
      );

  Map<String, dynamic> toJson() => {
        "AppSettingKey": appSettingKey,
        "AppSettingValue": appSettingValue,
      };
}
