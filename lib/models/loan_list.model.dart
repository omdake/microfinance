class LoanList {
  List<LoanListMessage>? message;

  LoanList({
    this.message,
  });

  factory LoanList.fromJson(Map<String, dynamic> json) => LoanList(
        message: List<LoanListMessage>.from(
            json["message"].map((x) => LoanListMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class LoanListMessage {
  String? name;
  String? loanId;
  String? applicantType;
  String? applicant;
  String? applicantName;
  String? loanApplication;
  dynamic coBorrower;
  String? company;
  DateTime? postingDate;
  String? status;
  String? loanProduct;
  double? loanAmount;
  dynamic loanPartner;
  String? loanCategory;
  String? repaymentScheduleType;
  dynamic cancellationDate;
  dynamic settlementDate;
  double? rateOfInterest;
  double? penaltyChargesRate;
  DateTime? disbursementDate;
  double? disbursedAmount;
  DateTime? closureDate;
  double? maximumLoanAmount;
  int? isSecuredLoan;
  int? isTermLoan;
  DateTime? repaymentStartDate;
  String? repaymentMethod;
  int? repaymentPeriods;
  double? monthlyRepaymentAmount;
  String? moratoriumType;
  int? moratoriumTenure;
  String? repaymentFrequency;
  String? treatmentOfInterest;
  int? repaymentDays;
  dynamic limitApplicableStart;
  double? maximumLimitAmount;
  dynamic limitApplicableEnd;
  double? utilizedLimitAmount;
  double? availableLimitAmount;
  int? daysPastDue;
  int? loanRestructureCount;
  dynamic watchPeriodEndDate;
  int? tenurePostRestructure;
  String? costCenter;
  String? disbursementAccount;
  String? paymentAccount;
  String? loanAccount;
  String? interestIncomeAccount;
  String? penaltyIncomeAccount;
  double? totalPayment;
  double? totalInterestPayable;
  double? totalPrincipalPaid;
  double? totalAmountPaid;

  LoanListMessage({
    this.name,
    this.loanId,
    this.applicantType,
    this.applicant,
    this.applicantName,
    this.loanApplication,
    this.coBorrower,
    this.company,
    this.postingDate,
    this.status,
    this.loanProduct,
    this.loanAmount,
    this.loanPartner,
    this.loanCategory,
    this.repaymentScheduleType,
    this.cancellationDate,
    this.settlementDate,
    this.rateOfInterest,
    this.penaltyChargesRate,
    this.disbursementDate,
    this.disbursedAmount,
    this.closureDate,
    this.maximumLoanAmount,
    this.isSecuredLoan,
    this.isTermLoan,
    this.repaymentStartDate,
    this.repaymentMethod,
    this.repaymentPeriods,
    this.monthlyRepaymentAmount,
    this.moratoriumType,
    this.moratoriumTenure,
    this.repaymentFrequency,
    this.treatmentOfInterest,
    this.repaymentDays,
    this.limitApplicableStart,
    this.maximumLimitAmount,
    this.limitApplicableEnd,
    this.utilizedLimitAmount,
    this.availableLimitAmount,
    this.daysPastDue,
    this.loanRestructureCount,
    this.watchPeriodEndDate,
    this.tenurePostRestructure,
    this.costCenter,
    this.disbursementAccount,
    this.paymentAccount,
    this.loanAccount,
    this.interestIncomeAccount,
    this.penaltyIncomeAccount,
    this.totalPayment,
    this.totalInterestPayable,
    this.totalPrincipalPaid,
    this.totalAmountPaid,
  });

  factory LoanListMessage.fromJson(Map<String, dynamic> json) =>
      LoanListMessage(
        name: json["name"] ?? '',
        loanId: json["custom_loan_id"] ?? '',
        applicantType: json["applicant_type"] ?? '',
        applicant: json["applicant"] ?? '',
        applicantName: json["applicant_name"] ?? '',
        loanApplication: json["loan_application"], // keep dynamic, can be null
        coBorrower: json["co_borrower"],
        company: json["company"] ?? '',
        postingDate: json["posting_date"] != null
            ? DateTime.tryParse(json["posting_date"])
            : null,
        status: json["status"] ?? '',
        loanProduct: json["loan_product"] ?? '',
        loanAmount: (json["loan_amount"] != null)
            ? double.tryParse(json["loan_amount"].toString())
            : 0.0,
        loanPartner: json["loan_partner"],
        loanCategory: json["loan_category"] ?? '',
        repaymentScheduleType: json["repayment_schedule_type"] ?? '',
        cancellationDate: json["cancellation_date"],
        settlementDate: json["settlement_date"],
        rateOfInterest: (json["rate_of_interest"] != null)
            ? double.tryParse(json["rate_of_interest"].toString())
            : 0.0,
        penaltyChargesRate: (json["penalty_charges_rate"] != null)
            ? double.tryParse(json["penalty_charges_rate"].toString())
            : 0.0,
        disbursementDate: json["disbursement_date"] != null
            ? DateTime.tryParse(json["disbursement_date"])
            : null,
        disbursedAmount: (json["disbursed_amount"] != null)
            ? double.tryParse(json["disbursed_amount"].toString())
            : 0.0,
        closureDate: json["closure_date"] != null
            ? DateTime.tryParse(json["closure_date"])
            : null,
        maximumLoanAmount: (json["maximum_loan_amount"] != null)
            ? double.tryParse(json["maximum_loan_amount"].toString())
            : 0.0,
        isSecuredLoan: json["is_secured_loan"],
        isTermLoan: json["is_term_loan"],
        repaymentStartDate: json["repayment_start_date"] != null
            ? DateTime.tryParse(json["repayment_start_date"])
            : null,
        repaymentMethod: json["repayment_method"] ?? '',
        repaymentPeriods: json["repayment_periods"],
        monthlyRepaymentAmount: (json["monthly_repayment_amount"] != null)
            ? double.tryParse(json["monthly_repayment_amount"].toString())
            : 0.0,
        moratoriumType: json["moratorium_type"] ?? '',
        moratoriumTenure: json["moratorium_tenure"],
        repaymentFrequency: json["repayment_frequency"] ?? '',
        treatmentOfInterest: json["treatment_of_interest"] ?? '',
        repaymentDays: json["repayment_days"],
        limitApplicableStart: json["limit_applicable_start"],
        maximumLimitAmount: (json["maximum_limit_amount"] != null)
            ? double.tryParse(json["maximum_limit_amount"].toString())
            : 0.0,
        limitApplicableEnd: json["limit_applicable_end"],
        utilizedLimitAmount: (json["utilized_limit_amount"] != null)
            ? double.tryParse(json["utilized_limit_amount"].toString())
            : 0.0,
        availableLimitAmount: (json["available_limit_amount"] != null)
            ? double.tryParse(json["available_limit_amount"].toString())
            : 0.0,
        daysPastDue: json["days_past_due"],
        loanRestructureCount: json["loan_restructure_count"],
        watchPeriodEndDate: json["watch_period_end_date"],
        tenurePostRestructure: json["tenure_post_restructure"],
        costCenter: json["cost_center"] ?? '',
        disbursementAccount: json["disbursement_account"] ?? '',
        paymentAccount: json["payment_account"] ?? '',
        loanAccount: json["loan_account"] ?? '',
        interestIncomeAccount: json["interest_income_account"] ?? '',
        penaltyIncomeAccount: json["penalty_income_account"] ?? '',
        totalPayment: (json["total_payment"] != null)
            ? double.tryParse(json["total_payment"].toString())
            : 0.0,
        totalInterestPayable: (json["total_interest_payable"] != null)
            ? double.tryParse(json["total_interest_payable"].toString())
            : 0.0,
        totalPrincipalPaid: (json["total_principal_paid"] != null)
            ? double.tryParse(json["total_principal_paid"].toString())
            : 0.0,
        totalAmountPaid: (json["total_amount_paid"] != null)
            ? double.tryParse(json["total_amount_paid"].toString())
            : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "custom_loan_id": loanId,
        "applicant_type": applicantType,
        "applicant": applicant,
        "applicant_name": applicantName,
        "loan_application": loanApplication,
        "co_borrower": coBorrower,
        "company": company,
        "posting_date":
            "${postingDate!.year.toString().padLeft(4, '0')}-${postingDate!.month.toString().padLeft(2, '0')}-${postingDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "loan_product": loanProduct,
        "loan_amount": loanAmount,
        "loan_partner": loanPartner,
        "loan_category": loanCategory,
        "repayment_schedule_type": repaymentScheduleType,
        "cancellation_date": cancellationDate,
        "settlement_date": settlementDate,
        "rate_of_interest": rateOfInterest,
        "penalty_charges_rate": penaltyChargesRate,
        "disbursement_date":
            "${disbursementDate!.year.toString().padLeft(4, '0')}-${disbursementDate!.month.toString().padLeft(2, '0')}-${disbursementDate!.day.toString().padLeft(2, '0')}",
        "disbursed_amount": disbursedAmount,
        "closure_date":
            "${closureDate!.year.toString().padLeft(4, '0')}-${closureDate!.month.toString().padLeft(2, '0')}-${closureDate!.day.toString().padLeft(2, '0')}",
        "maximum_loan_amount": maximumLoanAmount,
        "is_secured_loan": isSecuredLoan,
        "is_term_loan": isTermLoan,
        "repayment_start_date":
            "${repaymentStartDate!.year.toString().padLeft(4, '0')}-${repaymentStartDate!.month.toString().padLeft(2, '0')}-${repaymentStartDate!.day.toString().padLeft(2, '0')}",
        "repayment_method": repaymentMethod,
        "repayment_periods": repaymentPeriods,
        "monthly_repayment_amount": monthlyRepaymentAmount,
        "moratorium_type": moratoriumType,
        "moratorium_tenure": moratoriumTenure,
        "repayment_frequency": repaymentFrequency,
        "treatment_of_interest": treatmentOfInterest,
        "repayment_days": repaymentDays,
        "limit_applicable_start": limitApplicableStart,
        "maximum_limit_amount": maximumLimitAmount,
        "limit_applicable_end": limitApplicableEnd,
        "utilized_limit_amount": utilizedLimitAmount,
        "available_limit_amount": availableLimitAmount,
        "days_past_due": daysPastDue,
        "loan_restructure_count": loanRestructureCount,
        "watch_period_end_date": watchPeriodEndDate,
        "tenure_post_restructure": tenurePostRestructure,
        "cost_center": costCenter,
        "disbursement_account": disbursementAccount,
        "payment_account": paymentAccount,
        "loan_account": loanAccount,
        "interest_income_account": interestIncomeAccount,
        "penalty_income_account": penaltyIncomeAccount,
        "total_payment": totalPayment,
        "total_interest_payable": totalInterestPayable,
        "total_principal_paid": totalPrincipalPaid,
        "total_amount_paid": totalAmountPaid,
      };
}
