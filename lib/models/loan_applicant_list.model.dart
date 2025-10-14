class LoanApplicantList {
  LoanApplicantListMessage? message;

  LoanApplicantList({
    this.message,
  });

  factory LoanApplicantList.fromJson(Map<String, dynamic> json) =>
      LoanApplicantList(
        message: LoanApplicantListMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class LoanApplicantListMessage {
  int? count;
  String? next;
  dynamic previous;
  List<LoanApplicantListResult>? results;

  LoanApplicantListMessage({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory LoanApplicantListMessage.fromJson(Map<String, dynamic> json) =>
      LoanApplicantListMessage(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<LoanApplicantListResult>.from(
            json["results"].map((x) => LoanApplicantListResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class LoanApplicantListResult {
  String? name;
  String? applicantType;
  String? applicant;
  String? applicantName;
  String? coBorrower;
  String? company;
  DateTime? postingDate;
  String? status;
  String? loanProduct;
  int? isTermLoan;
  double? loanAmount;
  double? rateOfInterest;
  String? description;
  double? maximumLoanAmount;
  String? repaymentMethod;
  double? totalPayableAmount;
  int? repaymentPeriods;
  double? repaymentAmount;
  double? totalPayableInterest;
  dynamic amendedFrom;

  LoanApplicantListResult({
    this.name,
    this.applicantType,
    this.applicant,
    this.applicantName,
    this.coBorrower,
    this.company,
    this.postingDate,
    this.status,
    this.loanProduct,
    this.isTermLoan,
    this.loanAmount,
    this.rateOfInterest,
    this.description,
    this.maximumLoanAmount,
    this.repaymentMethod,
    this.totalPayableAmount,
    this.repaymentPeriods,
    this.repaymentAmount,
    this.totalPayableInterest,
    this.amendedFrom,
  });

  factory LoanApplicantListResult.fromJson(Map<String, dynamic> json) =>
      LoanApplicantListResult(
        name: json["name"],
        applicantType: json["applicant_type"],
        applicant: json["applicant"],
        applicantName: json["applicant_name"],
        coBorrower: json["co_borrower"],
        company: json["company"],
        postingDate: DateTime.parse(json["posting_date"]),
        status: json["status"],
        loanProduct: json["loan_product"],
        isTermLoan: json["is_term_loan"],
        description: json["description"],
        repaymentMethod: json["repayment_method"],
        repaymentPeriods: json["repayment_periods"],
        amendedFrom: json["amended_from"],
        loanAmount: (json["loan_amount"] as num?)?.toDouble(),
        rateOfInterest: (json["rate_of_interest"] as num?)?.toDouble(),
        maximumLoanAmount: (json["maximum_loan_amount"] as num?)?.toDouble(),
        totalPayableAmount: (json["total_payable_amount"] as num?)?.toDouble(),
        repaymentAmount: (json["repayment_amount"] as num?)?.toDouble(),
        totalPayableInterest:
            (json["total_payable_interest"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "applicant_type": applicantType,
        "applicant": applicant,
        "applicant_name": applicantName,
        "co_borrower": coBorrower,
        "company": company,
        "posting_date":
            "${postingDate!.year.toString().padLeft(4, '0')}-${postingDate!.month.toString().padLeft(2, '0')}-${postingDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "loan_product": loanProduct,
        "is_term_loan": isTermLoan,
        "loan_amount": loanAmount,
        "rate_of_interest": rateOfInterest,
        "description": description,
        "maximum_loan_amount": maximumLoanAmount,
        "repayment_method": repaymentMethod,
        "total_payable_amount": totalPayableAmount,
        "repayment_periods": repaymentPeriods,
        "repayment_amount": repaymentAmount,
        "total_payable_interest": totalPayableInterest,
        "amended_from": amendedFrom,
      };
}
