class TotalLoanCount {
  TotalLoanCountMessage? message;

  TotalLoanCount({this.message});

  factory TotalLoanCount.fromJson(Map<String, dynamic> json) => TotalLoanCount(
        message: json["message"] != null
            ? TotalLoanCountMessage.fromJson(json["message"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
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

  factory TotalLoanCountMessage.fromJson(Map<String, dynamic> json) =>
      TotalLoanCountMessage(
        totalLoans: (json["total_loans"] as num?)?.toInt(),
        approvedLoans: (json["approved_loans"] as num?)?.toInt(),
        rejectedLoans: (json["rejected_loans"] as num?)?.toInt(),
        remainingAmount: (json["remaining_amount"] as num?)?.toInt(),
        totalEmis: (json["total_emis"] as num?)?.toInt(),
        collectionInHand: (json["collection_in_hand"] as num?)?.toDouble(),
        todaysCollection: (json["todays_collection"] as num?)?.toInt(),
        monthlyCollection: (json["monthly_collection"] as num?)?.toDouble(),
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
