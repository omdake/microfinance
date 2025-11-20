class GetPayableAmount {
  GetPayableAmountMessage? message;

  GetPayableAmount({
    this.message,
  });

  factory GetPayableAmount.fromJson(Map<String, dynamic> json) =>
      GetPayableAmount(
        message: GetPayableAmountMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class GetPayableAmountMessage {
  double? penaltyAmount;
  double? interestAmount;
  double? pendingPrincipalAmount;
  double? payablePrincipalAmount;
  double? payableAmount;
  double? unaccruedInterest;
  double? unbookedInterest;
  double? unbookedPenalty;
  DateTime? dueDate;
  int? totalChargesPayable;
  double? availableSecurityDeposit;
  double? writtenOffAmount;
  List<dynamic>? unpaidDemands;
  double? excessAmountPaid;

  GetPayableAmountMessage({
    this.penaltyAmount,
    this.interestAmount,
    this.pendingPrincipalAmount,
    this.payablePrincipalAmount,
    this.payableAmount,
    this.unaccruedInterest,
    this.unbookedInterest,
    this.unbookedPenalty,
    this.dueDate,
    this.totalChargesPayable,
    this.availableSecurityDeposit,
    this.writtenOffAmount,
    this.unpaidDemands,
    this.excessAmountPaid,
  });

  factory GetPayableAmountMessage.fromJson(Map<String, dynamic> json) =>
      GetPayableAmountMessage(
        penaltyAmount: (json["penalty_amount"] ?? 0).toDouble(),
        interestAmount: (json["interest_amount"] ?? 0).toDouble(),
        pendingPrincipalAmount:
            (json["pending_principal_amount"] ?? 0).toDouble(),
        payablePrincipalAmount:
            (json["payable_principal_amount"] ?? 0).toDouble(),
        payableAmount: (json["payable_amount"] ?? 0).toDouble(),
        unaccruedInterest: (json["unaccrued_interest"] ?? 0).toDouble(),
        unbookedInterest: (json["unbooked_interest"] ?? 0).toDouble(),
        unbookedPenalty: (json["unbooked_penalty"] ?? 0).toDouble(),
        dueDate:
            json["due_date"] != null ? DateTime.parse(json["due_date"]) : null,
        totalChargesPayable: json["total_charges_payable"] ?? 0,
        availableSecurityDeposit:
            (json["available_security_deposit"] ?? 0).toDouble(),
        writtenOffAmount: (json["written_off_amount"] ?? 0).toDouble(),
        unpaidDemands: json["unpaid_demands"] != null
            ? List<dynamic>.from(json["unpaid_demands"].map((x) => x))
            : [],
        excessAmountPaid: (json["excess_amount_paid"] ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "penalty_amount": penaltyAmount,
        "interest_amount": interestAmount,
        "pending_principal_amount": pendingPrincipalAmount,
        "payable_principal_amount": payablePrincipalAmount,
        "payable_amount": payableAmount,
        "unaccrued_interest": unaccruedInterest,
        "unbooked_interest": unbookedInterest,
        "unbooked_penalty": unbookedPenalty,
        "due_date": dueDate != null
            ? "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}"
            : null,
        "total_charges_payable": totalChargesPayable,
        "available_security_deposit": availableSecurityDeposit,
        "written_off_amount": writtenOffAmount,
        "unpaid_demands": List<dynamic>.from(unpaidDemands!.map((x) => x)),
        "excess_amount_paid": excessAmountPaid,
      };
}
