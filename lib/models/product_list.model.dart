class ProductList {
  ProductListMessage? message;

  ProductList({
    this.message,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        message: ProductListMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class ProductListMessage {
  int? count;
  dynamic next;
  dynamic previous;
  List<ProductListResult>? results;

  ProductListMessage({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory ProductListMessage.fromJson(Map<String, dynamic> json) =>
      ProductListMessage(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<ProductListResult>.from(
            json["results"].map((x) => ProductListResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class ProductListResult {
  String? name;
  String? productCode;
  String? productName;
  double? rateOfInterest; // changed to double
  String? loanCategory;
  double? maximumLoanAmount; // changed to double
  String? company;
  int? cyclicDayOfTheMonth;
  String? repaymentDateOn;
  String? repaymentScheduleType;
  int? isTermLoan; // 0 or 1
  int? validateNormalRepayment;
  int? minDaysBwDisbursementFirstRepayment;
  double? excessAmountAcceptanceLimit; // changed to double

  ProductListResult({
    this.name,
    this.productCode,
    this.productName,
    this.rateOfInterest,
    this.loanCategory,
    this.maximumLoanAmount,
    this.company,
    this.cyclicDayOfTheMonth,
    this.repaymentDateOn,
    this.repaymentScheduleType,
    this.isTermLoan,
    this.validateNormalRepayment,
    this.minDaysBwDisbursementFirstRepayment,
    this.excessAmountAcceptanceLimit,
  });

  factory ProductListResult.fromJson(Map<String, dynamic> json) =>
      ProductListResult(
        name: json["name"],
        productCode: json["product_code"],
        productName: json["product_name"],
        rateOfInterest: (json["rate_of_interest"] as num?)?.toDouble(),
        loanCategory: json["loan_category"],
        maximumLoanAmount: (json["maximum_loan_amount"] as num?)?.toDouble(),
        company: json["company"],
        cyclicDayOfTheMonth: (json["cyclic_day_of_the_month"] as num?)?.toInt(),
        repaymentDateOn: json["repayment_date_on"],
        repaymentScheduleType: json["repayment_schedule_type"],
        isTermLoan: (json["is_term_loan"] as num?)?.toInt(),
        validateNormalRepayment:
            (json["validate_normal_repayment"] as num?)?.toInt(),
        minDaysBwDisbursementFirstRepayment:
            (json["min_days_bw_disbursement_first_repayment"] as num?)?.toInt(),
        excessAmountAcceptanceLimit:
            (json["excess_amount_acceptance_limit"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "product_code": productCode,
        "product_name": productName,
        "rate_of_interest": rateOfInterest,
        "loan_category": loanCategory,
        "maximum_loan_amount": maximumLoanAmount,
        "company": company,
        "cyclic_day_of_the_month": cyclicDayOfTheMonth,
        "repayment_date_on": repaymentDateOn,
        "repayment_schedule_type": repaymentScheduleType,
        "is_term_loan": isTermLoan,
        "validate_normal_repayment": validateNormalRepayment,
        "min_days_bw_disbursement_first_repayment":
            minDaysBwDisbursementFirstRepayment,
        "excess_amount_acceptance_limit": excessAmountAcceptanceLimit,
      };
}
