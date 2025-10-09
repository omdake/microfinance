class TotalLoanCount {
  TotalLoanCountMessage? message;

  TotalLoanCount({
    this.message,
  });

  factory TotalLoanCount.fromJson(Map<String, dynamic> json) => TotalLoanCount(
        message: TotalLoanCountMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class TotalLoanCountMessage {
  int? totalLoans;
  int? approvedLoans;
  int? rejectedLoans;
  double? totalRepaymentAmount;
  int? totalEmis;

  TotalLoanCountMessage({
    this.totalLoans,
    this.approvedLoans,
    this.rejectedLoans,
    this.totalRepaymentAmount,
    this.totalEmis,
  });

  factory TotalLoanCountMessage.fromJson(Map<String, dynamic> json) =>
      TotalLoanCountMessage(
        totalLoans: json["total_loans"] ?? 0,
        approvedLoans: json["approved_loans"] ?? 0,
        rejectedLoans: json["rejected_loans"] ?? 0.0,
        totalRepaymentAmount: (json["total_repayment_amount"] is int)
            ? (json["total_repayment_amount"] as int).toDouble()
            : (json["total_repayment_amount"] ?? 0.0),
        totalEmis: json["total_emis"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "total_loans": totalLoans,
        "approved_loans": approvedLoans,
        "rejected_loans": rejectedLoans,
        "total_repayment_amount": totalRepaymentAmount,
        "total_emis": totalEmis,
      };
}
