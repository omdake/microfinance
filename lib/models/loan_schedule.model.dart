class Schedule {
  ScheduleMessage? message;

  Schedule({
    this.message,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        message: ScheduleMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class ScheduleMessage {
  int? count;
  dynamic next;
  dynamic previous;
  List<ScheduleResult>? results;

  ScheduleMessage({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory ScheduleMessage.fromJson(Map<String, dynamic> json) =>
      ScheduleMessage(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<ScheduleResult>.from(
            json["results"].map((x) => ScheduleResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class ScheduleResult {
  String? name;
  String? loan;
  String? loanDisbursement;
  double? loanAmount; // changed
  double? currentPrincipalAmount; // changed
  double? rateOfInterest; // changed
  String? company;
  DateTime? postingDate;
  String? repaymentFrequency;
  DateTime? repaymentStartDate;
  DateTime? maturityDate;
  int? repaymentDays;
  int? totalInstallmentsPaid;
  int? totalInstallmentsRaised;
  int? totalInstallmentsOverdue;
  String? loanProduct;
  String? repaymentMethod;
  int? repaymentPeriods;
  String? repaymentScheduleType;
  String? repaymentDateOn;
  double? disbursedAmount; // changed
  double? monthlyRepaymentAmount;
  double? partnerMonthlyRepaymentAmount; // changed
  dynamic loanRestructure;
  String? restructureType;
  double? brokenPeriodInterest; // changed
  String? status;
  dynamic amendedFrom;
  String? moratoriumType;
  int? moratoriumTenure;
  String? treatmentOfInterest;
  dynamic moratoriumEndDate;
  double? adjustedInterest; // changed
  int? brokenPeriodInterestDays;
  List<RepaymentSchedule>? repaymentSchedule;

  ScheduleResult({
    this.name,
    this.loan,
    this.loanDisbursement,
    this.loanAmount,
    this.currentPrincipalAmount,
    this.rateOfInterest,
    this.company,
    this.postingDate,
    this.repaymentFrequency,
    this.repaymentStartDate,
    this.maturityDate,
    this.repaymentDays,
    this.totalInstallmentsPaid,
    this.totalInstallmentsRaised,
    this.totalInstallmentsOverdue,
    this.loanProduct,
    this.repaymentMethod,
    this.repaymentPeriods,
    this.repaymentScheduleType,
    this.repaymentDateOn,
    this.disbursedAmount,
    this.monthlyRepaymentAmount,
    this.partnerMonthlyRepaymentAmount,
    this.loanRestructure,
    this.restructureType,
    this.brokenPeriodInterest,
    this.status,
    this.amendedFrom,
    this.moratoriumType,
    this.moratoriumTenure,
    this.treatmentOfInterest,
    this.moratoriumEndDate,
    this.adjustedInterest,
    this.brokenPeriodInterestDays,
    this.repaymentSchedule,
  });

  factory ScheduleResult.fromJson(Map<String, dynamic> json) => ScheduleResult(
        name: json["name"],
        loan: json["loan"],
        loanDisbursement: json["loan_disbursement"],
        loanAmount: (json["loan_amount"] ?? 0).toDouble(),
        currentPrincipalAmount:
            (json["current_principal_amount"] ?? 0).toDouble(),
        rateOfInterest: (json["rate_of_interest"] ?? 0).toDouble(),
        company: json["company"],
        postingDate: DateTime.parse(json["posting_date"]),
        repaymentFrequency: json["repayment_frequency"],
        repaymentStartDate: DateTime.parse(json["repayment_start_date"]),
        maturityDate: DateTime.parse(json["maturity_date"]),
        repaymentDays: json["repayment_days"],
        totalInstallmentsPaid: json["total_installments_paid"],
        totalInstallmentsRaised: json["total_installments_raised"],
        totalInstallmentsOverdue: json["total_installments_overdue"],
        loanProduct: json["loan_product"],
        repaymentMethod: json["repayment_method"],
        repaymentPeriods: json["repayment_periods"],
        repaymentScheduleType: json["repayment_schedule_type"],
        repaymentDateOn: json["repayment_date_on"],
        disbursedAmount: (json["disbursed_amount"] ?? 0).toDouble(),
        monthlyRepaymentAmount:
            (json["monthly_repayment_amount"] ?? 0).toDouble(),
        partnerMonthlyRepaymentAmount:
            (json["partner_monthly_repayment_amount"] ?? 0).toDouble(),
        loanRestructure: json["loan_restructure"],
        restructureType: json["restructure_type"],
        brokenPeriodInterest: (json["broken_period_interest"] ?? 0).toDouble(),
        status: json["status"],
        amendedFrom: json["amended_from"],
        moratoriumType: json["moratorium_type"],
        moratoriumTenure: json["moratorium_tenure"],
        treatmentOfInterest: json["treatment_of_interest"],
        moratoriumEndDate: json["moratorium_end_date"],
        adjustedInterest: (json["adjusted_interest"] ?? 0).toDouble(),
        brokenPeriodInterestDays: json["broken_period_interest_days"],
        repaymentSchedule: List<RepaymentSchedule>.from(
            json["repayment_schedule"]
                .map((x) => RepaymentSchedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "loan": loan,
        "loan_disbursement": loanDisbursement,
        "loan_amount": loanAmount,
        "current_principal_amount": currentPrincipalAmount,
        "rate_of_interest": rateOfInterest,
        "company": company,
        "posting_date": postingDate!.toIso8601String(),
        "repayment_frequency": repaymentFrequency,
        "repayment_start_date":
            "${repaymentStartDate!.year.toString().padLeft(4, '0')}-${repaymentStartDate!.month.toString().padLeft(2, '0')}-${repaymentStartDate!.day.toString().padLeft(2, '0')}",
        "maturity_date":
            "${maturityDate!.year.toString().padLeft(4, '0')}-${maturityDate!.month.toString().padLeft(2, '0')}-${maturityDate!.day.toString().padLeft(2, '0')}",
        "repayment_days": repaymentDays,
        "total_installments_paid": totalInstallmentsPaid,
        "total_installments_raised": totalInstallmentsRaised,
        "total_installments_overdue": totalInstallmentsOverdue,
        "loan_product": loanProduct,
        "repayment_method": repaymentMethod,
        "repayment_periods": repaymentPeriods,
        "repayment_schedule_type": repaymentScheduleType,
        "repayment_date_on": repaymentDateOn,
        "disbursed_amount": disbursedAmount,
        "monthly_repayment_amount": monthlyRepaymentAmount,
        "partner_monthly_repayment_amount": partnerMonthlyRepaymentAmount,
        "loan_restructure": loanRestructure,
        "restructure_type": restructureType,
        "broken_period_interest": brokenPeriodInterest,
        "status": status,
        "amended_from": amendedFrom,
        "moratorium_type": moratoriumType,
        "moratorium_tenure": moratoriumTenure,
        "treatment_of_interest": treatmentOfInterest,
        "moratorium_end_date": moratoriumEndDate,
        "adjusted_interest": adjustedInterest,
        "broken_period_interest_days": brokenPeriodInterestDays,
        "repayment_schedule":
            List<dynamic>.from(repaymentSchedule!.map((x) => x.toJson())),
      };
}

class RepaymentSchedule {
  String? parent;
  DateTime? paymentDate;
  int? numberOfDays;
  double? principalAmount;
  double? interestAmount;
  double? totalPayment;
  double? balanceLoanAmount;
  int? demandGenerated;
  int? idx;

  RepaymentSchedule({
    this.parent,
    this.paymentDate,
    this.numberOfDays,
    this.principalAmount,
    this.interestAmount,
    this.totalPayment,
    this.balanceLoanAmount,
    this.demandGenerated,
    this.idx,
  });

  factory RepaymentSchedule.fromJson(Map<String, dynamic> json) =>
      RepaymentSchedule(
        parent: json["parent"],
        paymentDate: DateTime.parse(json["payment_date"]),
        numberOfDays: json["number_of_days"],
        principalAmount: json["principal_amount"].toDouble(),
        interestAmount: json["interest_amount"].toDouble(),
        totalPayment: json["total_payment"].toDouble(),
        balanceLoanAmount: json["balance_loan_amount"].toDouble(),
        demandGenerated: json["demand_generated"],
        idx: json["idx"],
      );

  Map<String, dynamic> toJson() => {
        "parent": parent,
        "payment_date":
            "${paymentDate!.year.toString().padLeft(4, '0')}-${paymentDate!.month.toString().padLeft(2, '0')}-${paymentDate!.day.toString().padLeft(2, '0')}",
        "number_of_days": numberOfDays,
        "principal_amount": principalAmount,
        "interest_amount": interestAmount,
        "total_payment": totalPayment,
        "balance_loan_amount": balanceLoanAmount,
        "demand_generated": demandGenerated,
        "idx": idx,
      };
}
