class Country {
  CountryMessage? message;

  Country({
    this.message,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        message: CountryMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class CountryMessage {
  int? count;
  String? next;
  dynamic previous;
  List<CountryResult>? results;

  CountryMessage({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory CountryMessage.fromJson(Map<String, dynamic> json) => CountryMessage(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<CountryResult>.from(json["results"].map((x) => CountryResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class CountryResult {
  String? name;
  String? countryName;
  String? code;

  CountryResult({
    this.name,
    this.countryName,
    this.code,
  });

  factory CountryResult.fromJson(Map<String, dynamic> json) =>CountryResult(
        name: json["name"],
        countryName: json["country_name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country_name": countryName,
        "code": code,
      };
}
