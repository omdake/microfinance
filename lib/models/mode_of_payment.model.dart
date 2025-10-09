class ModeOfPayment {
  List<ModeOfPaymentMessage>? message;

  ModeOfPayment({
    this.message,
  });

  factory ModeOfPayment.fromJson(Map<String, dynamic> json) => ModeOfPayment(
        message:
            List<ModeOfPaymentMessage>.from(json["message"].map((x) => ModeOfPaymentMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class ModeOfPaymentMessage {
  String? name;
  String? modeOfPayment;
  String? type;

  ModeOfPaymentMessage({
    this.name,
    this.modeOfPayment,
    this.type,
  });

  factory ModeOfPaymentMessage.fromJson(Map<String, dynamic> json) => ModeOfPaymentMessage(
        name: json["name"],
        modeOfPayment: json["mode_of_payment"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mode_of_payment": modeOfPayment,
        "type": type,
      };
}
