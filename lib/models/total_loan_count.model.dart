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
  int? remainingAmount;
  int? totalEmis;
  double? collectionInHand;
  int? todaysCollection;
  double? monthlyCollection;

  TotalLoanCountMessage({
    this.totalLoans,
    this.approvedLoans,
    this.rejectedLoans,
    this.remainingAmount,
    this.totalEmis,
    this.collectionInHand,
    this.todaysCollection,
    this.monthlyCollection,
  });

  factory TotalLoanCountMessage.fromJson(Map<String, dynamic> json) => TotalLoanCountMessage(
        totalLoans: json["total_loans"],
        approvedLoans: json["approved_loans"],
        rejectedLoans: json["rejected_loans"],
        remainingAmount: json["remaining_amount"],
        totalEmis: json["total_emis"],
        collectionInHand: json["collection_in_hand"],
        todaysCollection: json["todays_collection"],
        monthlyCollection: json["monthly_collection"],
      );

  Map<String, dynamic> toJson() => {
        "total_loans": totalLoans,
        "approved_loans": approvedLoans,
        "rejected_loans": rejectedLoans,
        "remaining_amount": remainingAmount,
        "total_emis": totalEmis,
        "collection_in_hand": collectionInHand,
        "todays_collection": todaysCollection,
        "monthly_collection": monthlyCollection,
      };
}
