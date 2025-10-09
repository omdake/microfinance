class CityList {
  String? cityId;
  String? cityName;

  CityList({this.cityId, this.cityName});

  factory CityList.fromJson(Map<String, dynamic> json) => CityList(
        cityId: json["CityID"] ?? "",
        cityName: json["CityName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "CityID": cityId,
        "CityName": cityName,
      };
}

class StateList {
  String? stateId;
  String? stateName;

  StateList({this.stateId, this.stateName});

  factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        stateId: json["StateID"] ?? "",
        stateName: json["StateName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "StateID": stateId,
        "StateName": stateName,
      };
}
