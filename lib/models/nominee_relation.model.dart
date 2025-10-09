class RelationList {
  List<RelationListMessage>? message;

  RelationList({
    this.message,
  });

  factory RelationList.fromJson(Map<String, dynamic> json) => RelationList(
        message:
            List<RelationListMessage>.from(json["message"].map((x) => RelationListMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class RelationListMessage {
  String? value;

  RelationListMessage({
    this.value,
  });

  factory RelationListMessage.fromJson(Map<String, dynamic> json) => RelationListMessage(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}
