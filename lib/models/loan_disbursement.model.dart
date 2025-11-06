class LoanDisbursement {
  LoanDisbursementMessage? message;

  LoanDisbursement({
    this.message,
  });

  factory LoanDisbursement.fromJson(Map<String, dynamic> json) =>
      LoanDisbursement(
        message: LoanDisbursementMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class LoanDisbursementMessage {
  int? count;
  String? next;
  dynamic previous;
  List<LoanDisbursementResult>? results;

  LoanDisbursementMessage({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory LoanDisbursementMessage.fromJson(Map<String, dynamic> json) =>
      LoanDisbursementMessage(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<LoanDisbursementResult>.from(
            json["results"].map((x) => LoanDisbursementResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class LoanDisbursementResult {
  String? name;
  String? againstLoan;
  double? sanctionedLoanAmount;
  double? currentDisbursedAmount;
  DateTime? postingDate;
  String? applicantType;
  String? loanProduct;
  double? monthlyRepaymentAmount;
  dynamic loanPartner;
  String? company;
  String? applicant;
  String? repaymentScheduleType;
  String? repaymentFrequency;
  String? repaymentMethod;
  int? tenure;
  DateTime? repaymentStartDate;
  int? isTermLoan;
  int? withholdSecurityDeposit;
  int? repaymentDays;
  DateTime? disbursementDate;
  dynamic clearanceDate;
  dynamic bpiDifferenceDate;
  int? brokenPeriodInterestDays;
  double? disbursedAmount;
  double? brokenPeriodInterest;
  double? bpiAmountDifference;
  double? principalAmountPaid;
  String? modeOfPayment;
  String? disbursementAccount;
  dynamic refundAccount;
  String? loanAccount;
  dynamic bankAccount;
  String? costCenter;
  dynamic referenceDate;
  int? daysPastDue;
  String? status;
  dynamic referenceNumber;
  String? amendedFrom;
   String? applicantMemberName;
   String? applicantImage;

  LoanDisbursementResult({
    this.name,
    this.againstLoan,
    this.sanctionedLoanAmount,
    this.currentDisbursedAmount,
    this.postingDate,
    this.applicantType,
    this.loanProduct,
    this.monthlyRepaymentAmount,
    this.loanPartner,
    this.company,
    this.applicant,
    this.repaymentScheduleType,
    this.repaymentFrequency,
    this.repaymentMethod,
    this.tenure,
    this.repaymentStartDate,
    this.isTermLoan,
    this.withholdSecurityDeposit,
    this.repaymentDays,
    this.disbursementDate,
    this.clearanceDate,
    this.bpiDifferenceDate,
    this.brokenPeriodInterestDays,
    this.disbursedAmount,
    this.brokenPeriodInterest,
    this.bpiAmountDifference,
    this.principalAmountPaid,
    this.modeOfPayment,
    this.disbursementAccount,
    this.refundAccount,
    this.loanAccount,
    this.bankAccount,
    this.costCenter,
    this.referenceDate,
    this.daysPastDue,
    this.status,
    this.referenceNumber,
    this.amendedFrom,
    this.applicantMemberName,
    this.applicantImage,
  });

 factory LoanDisbursementResult.fromJson(Map<String, dynamic> json) =>
    LoanDisbursementResult(
      name: json["name"] ?? "",
      againstLoan: json["against_loan"] ?? "",
      sanctionedLoanAmount:
          (json["sanctioned_loan_amount"] ?? 0).toDouble(),
      currentDisbursedAmount:
          (json["current_disbursed_amount"] ?? 0).toDouble(),
      postingDate: json["posting_date"] != null
          ? DateTime.tryParse(json["posting_date"])
          : null,
      applicantType: json["applicant_type"] ?? "",
      loanProduct: json["loan_product"]?.toString() ?? "",
      monthlyRepaymentAmount:
          (json["monthly_repayment_amount"] ?? 0).toDouble(),
      loanPartner: json["loan_partner"],
      company: json["company"] ?? "",
      applicant: json["applicant"] ?? "",
      repaymentScheduleType: json["repayment_schedule_type"] ?? "",
      repaymentFrequency: json["repayment_frequency"] ?? "",
      repaymentMethod: json["repayment_method"] ?? "",
      tenure: json["tenure"] ?? 0,
      repaymentStartDate: json["repayment_start_date"] != null
          ? DateTime.tryParse(json["repayment_start_date"])
          : null,
      isTermLoan: json["is_term_loan"] ?? 0,
      withholdSecurityDeposit: json["withhold_security_deposit"] ?? 0,
      repaymentDays: json["repayment_days"] ?? 0,
      disbursementDate: json["disbursement_date"] != null
          ? DateTime.tryParse(json["disbursement_date"])
          : null,
      clearanceDate: json["clearance_date"],
      bpiDifferenceDate: json["bpi_difference_date"],
      brokenPeriodInterestDays: json["broken_period_interest_days"] ?? 0,
      disbursedAmount: (json["disbursed_amount"] ?? 0).toDouble(),
      brokenPeriodInterest: (json["broken_period_interest"] ?? 0).toDouble(),
      bpiAmountDifference: (json["bpi_amount_difference"] ?? 0).toDouble(),
      principalAmountPaid:
          (json["principal_amount_paid"] ?? 0).toDouble(),
      modeOfPayment: json["mode_of_payment"] ?? "",
      disbursementAccount: json["disbursement_account"] ?? "",
      refundAccount: json["refund_account"],
      loanAccount: json["loan_account"] ?? "",
      bankAccount: json["bank_account"],
      costCenter: json["cost_center"] ?? "",
      referenceDate: json["reference_date"],
      daysPastDue: json["days_past_due"] ?? 0,
      status: json["status"] ?? "",
      referenceNumber: json["reference_number"],
      amendedFrom: json["amended_from"] ?? "",
      applicantMemberName: json["applicant_member_name"] ?? "",
      applicantImage: json["applicant_image"],
    );


  Map<String, dynamic> toJson() => {
        "name": name,
        "against_loan": againstLoan,
        "sanctioned_loan_amount": sanctionedLoanAmount,
        "current_disbursed_amount": currentDisbursedAmount,
        "posting_date":
            "${postingDate!.year.toString().padLeft(4, '0')}-${postingDate!.month.toString().padLeft(2, '0')}-${postingDate!.day.toString().padLeft(2, '0')}",
        "applicant_type": applicantType,
        "loan_product": loanProduct,
        "monthly_repayment_amount": monthlyRepaymentAmount,
        "loan_partner": loanPartner,
        "company": company,
        "applicant": applicant,
        "repayment_schedule_type": repaymentScheduleType,
        "repayment_frequency": repaymentFrequency,
        "repayment_method": repaymentMethod,
        "tenure": tenure,
        "repayment_start_date":
            "${repaymentStartDate!.year.toString().padLeft(4, '0')}-${repaymentStartDate!.month.toString().padLeft(2, '0')}-${repaymentStartDate!.day.toString().padLeft(2, '0')}",
        "is_term_loan": isTermLoan,
        "withhold_security_deposit": withholdSecurityDeposit,
        "repayment_days": repaymentDays,
        "disbursement_date":
            "${disbursementDate!.year.toString().padLeft(4, '0')}-${disbursementDate!.month.toString().padLeft(2, '0')}-${disbursementDate!.day.toString().padLeft(2, '0')}",
        "clearance_date": clearanceDate,
        "bpi_difference_date": bpiDifferenceDate,
        "broken_period_interest_days": brokenPeriodInterestDays,
        "disbursed_amount": disbursedAmount,
        "broken_period_interest": brokenPeriodInterest,
        "bpi_amount_difference": bpiAmountDifference,
        "principal_amount_paid": principalAmountPaid,
        "mode_of_payment": modeOfPayment,
        "disbursement_account": disbursementAccount,
        "refund_account": refundAccount,
        "loan_account": loanAccount,
        "bank_account": bankAccount,
        "cost_center": costCenter,
        "reference_date": referenceDate,
        "days_past_due": daysPastDue,
        "status": status,
        "reference_number": referenceNumber,
        "amended_from": amendedFrom,
         "applicant_member_name": applicantMemberName,
         "applicant_image": applicantImage,
      };
}
