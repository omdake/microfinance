class State {
  StateMessage? message;

  State({
    this.message,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
        message: StateMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class StateMessage {
  int? count;
  dynamic next;
  dynamic previous;
  List<StateResult>? results;

  StateMessage({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory StateMessage.fromJson(Map<String, dynamic> json) => StateMessage(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<StateResult>.from(json["results"].map((x) => StateResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class StateResult {
  String? name;
  String? stateCode;
  String? stateName;

  StateResult({
    this.name,
    this.stateCode,
    this.stateName,
  });

  factory StateResult.fromJson(Map<String, dynamic> json) => StateResult(
        name: json["name"],
        stateCode: json["state_code"],
        stateName: json["state_name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "state_code": stateCode,
        "state_name": stateName,
      };
}
