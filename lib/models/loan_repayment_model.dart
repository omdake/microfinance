class RepaymentList {
  RepaymentListMessage? message;

  RepaymentList({
    this.message,
  });

  factory RepaymentList.fromJson(Map<String, dynamic> json) => RepaymentList(
        message: RepaymentListMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class RepaymentListMessage {
  int? count;
  String? next;
  dynamic previous;
  List<RepaymentListResult>? results;

  RepaymentListMessage({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory RepaymentListMessage.fromJson(Map<String, dynamic> json) =>
      RepaymentListMessage(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<RepaymentListResult>.from(
            json["results"].map((x) => RepaymentListResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class RepaymentListResult {
  String? name;
  String? againstLoan;
  String? applicant;
  String? repaymentType;
  String? loanDisbursement;
  dynamic loanAdjustment;
  String? repaymentScheduleType;
  String? loanProduct;
  String? company;
  DateTime? valueDate;
  dynamic loanRestructure;
  dynamic clearanceDate;
  double? rateOfInterest;
  int? daysPastDue;
  dynamic modeOfPayment;
  int? isTermLoan;
  String? createdBy;
  DateTime? dueDate;
  double? pendingPrincipalAmount;
  double? interestPayable;
  double? payableAmount;
  double? totalChargesPayable;
  double? payablePrincipalAmount;
  double? penaltyAmount;
  double? amountPaid;
  dynamic referenceNumber;
  double? totalInterestPaid;
  double? totalPenaltyPaid;
  DateTime? referenceDate;
  double? principalAmountPaid;
  double? totalChargesPaid;
  double? excessAmount;
  dynamic manualRemarks;
  String? paymentAccount;
  String? applicantMemberName;
  String? workflowState;
  String? applicantImage;
  String? againstLoanLoanId;
  String? paymentProof;

  RepaymentListResult(
      {this.name,
      this.againstLoan,
      this.applicant,
      this.repaymentType,
      this.loanDisbursement,
      this.loanAdjustment,
      this.repaymentScheduleType,
      this.loanProduct,
      this.company,
      this.valueDate,
      this.loanRestructure,
      this.clearanceDate,
      this.rateOfInterest,
      this.daysPastDue,
      this.modeOfPayment,
      this.isTermLoan,
      this.createdBy,
      this.dueDate,
      this.pendingPrincipalAmount,
      this.interestPayable,
      this.payableAmount,
      this.totalChargesPayable,
      this.payablePrincipalAmount,
      this.penaltyAmount,
      this.amountPaid,
      this.referenceNumber,
      this.totalInterestPaid,
      this.totalPenaltyPaid,
      this.referenceDate,
      this.principalAmountPaid,
      this.totalChargesPaid,
      this.excessAmount,
      this.manualRemarks,
      this.paymentAccount,
      this.applicantMemberName,
      this.workflowState,
      this.applicantImage,
      this.againstLoanLoanId,
      this.paymentProof});

  factory RepaymentListResult.fromJson(Map<String, dynamic> json) =>
      RepaymentListResult(
        name: json["name"],
        againstLoan: json["against_loan"],
        applicant: json["applicant"],
        repaymentType: json["repayment_type"],
        loanDisbursement: json["loan_disbursement"] ?? "",
        loanAdjustment: json["loan_adjustment"],
        repaymentScheduleType: json["repayment_schedule_type"],
        loanProduct: json["loan_product"]?.toString(),
        company: json["company"],
        valueDate: json["posting_date"] != null && json["posting_date"] != ""
            ? DateTime.tryParse(json["posting_date"])
            : null,
        dueDate: json["due_date"] != null && json["due_date"] != ""
            ? DateTime.tryParse(json["due_date"])
            : null,
        referenceDate:
            (json["reference_date"] != null && json["reference_date"] != "")
                ? DateTime.tryParse(json["reference_date"])
                : null,
        loanRestructure: json["loan_restructure"],
        clearanceDate: json["clearance_date"],
        rateOfInterest: (json["rate_of_interest"] ?? 0).toDouble(),
        daysPastDue: json["days_past_due"] ?? 0,
        modeOfPayment: json["custom_mode_of_payment"],
        isTermLoan: json["is_term_loan"],
        createdBy: json["created_by"],
        pendingPrincipalAmount:
            (json["pending_principal_amount"] ?? 0).toDouble(),
        interestPayable: (json["interest_payable"] ?? 0).toDouble(),
        payableAmount: (json["payable_amount"] ?? 0).toDouble(),
        totalChargesPayable: (json["total_charges_payable"] ?? 0).toDouble(),
        payablePrincipalAmount:
            (json["payable_principal_amount"] ?? 0).toDouble(),
        penaltyAmount: (json["penalty_amount"] ?? 0).toDouble(),
        amountPaid: (json["amount_paid"] ?? 0).toDouble(),
        referenceNumber: json["reference_number"],
        totalInterestPaid: (json["total_interest_paid"] ?? 0).toDouble(),
        totalPenaltyPaid: (json["total_penalty_paid"] ?? 0).toDouble(),
        principalAmountPaid: (json["principal_amount_paid"] ?? 0).toDouble(),
        totalChargesPaid: (json["total_charges_paid"] ?? 0).toDouble(),
        excessAmount: (json["excess_amount"] ?? 0).toDouble(),
        manualRemarks: json["custom_manual_remarks"],
        paymentAccount: json["payment_account"]?.toString(),
        applicantMemberName: json["applicant_member_name"],
        workflowState: json["workflow_state"],
        applicantImage: json["applicant_image"],
        againstLoanLoanId: json["against_loan_custom_loan_id"],
        paymentProof: json["payment_proof"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "against_loan": againstLoan,
        "applicant": applicant,
        "repayment_type": repaymentType,
        "loan_disbursement": loanDisbursement,
        "loan_adjustment": loanAdjustment,
        "repayment_schedule_type": repaymentScheduleType,
        "loan_product": loanProduct,
        "company": company,
        "posting_date": valueDate!.toIso8601String(),
        "loan_restructure": loanRestructure,
        "clearance_date": clearanceDate,
        "rate_of_interest": rateOfInterest,
        "days_past_due": daysPastDue,
        "custom_mode_of_payment": modeOfPayment,
        "is_term_loan": isTermLoan,
        "created_by": createdBy,
        "due_date":
            "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
        "pending_principal_amount": pendingPrincipalAmount,
        "interest_payable": interestPayable,
        "payable_amount": payableAmount,
        "total_charges_payable": totalChargesPayable,
        "payable_principal_amount": payablePrincipalAmount,
        "penalty_amount": penaltyAmount,
        "amount_paid": amountPaid,
        "reference_number": referenceNumber,
        "total_interest_paid": totalInterestPaid,
        "total_penalty_paid": totalPenaltyPaid,
        "reference_date":
            "${referenceDate!.year.toString().padLeft(4, '0')}-${referenceDate!.month.toString().padLeft(2, '0')}-${referenceDate!.day.toString().padLeft(2, '0')}",
        "principal_amount_paid": principalAmountPaid,
        "total_charges_paid": totalChargesPaid,
        "excess_amount": excessAmount,
        "custom_manual_remarks": manualRemarks,
        "payment_account": paymentAccount,
        "applicant_member_name": applicantMemberName,
        "workflow_state": workflowState,
        "applicant_image": applicantImage,
        "against_loan_custom_loan_id": againstLoanLoanId,
        "payment_proof": paymentProof,
      };
}
