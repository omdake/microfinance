class Occupation {
  OccupationMessage? message;

  Occupation({
    this.message,
  });

  factory Occupation.fromJson(Map<String, dynamic> json) => Occupation(
        message: OccupationMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class OccupationMessage {
  int? count;
  dynamic next;
  dynamic previous;
  List<OccupationResult>? results;

  OccupationMessage({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory OccupationMessage.fromJson(Map<String, dynamic> json) => OccupationMessage(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<OccupationResult>.from(json["results"].map((x) => OccupationResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class OccupationResult {
  String? name;
  String? occupation;

  OccupationResult({
    this.name,
    this.occupation,
  });

  factory OccupationResult.fromJson(Map<String, dynamic> json) => OccupationResult(
        name: json["name"],
        occupation: json["occupation"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "occupation": occupation,
      };
}
