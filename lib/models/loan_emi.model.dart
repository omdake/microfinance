class LoanEmiList {
  List<LoanEmiListMessage>? message;

  LoanEmiList({this.message});

  factory LoanEmiList.fromJson(Map<String, dynamic> json) => LoanEmiList(
        message: List<LoanEmiListMessage>.from(
            json["message"].map((x) => LoanEmiListMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class LoanEmiListMessage {
  String? loanRepaymentSchedule;
  String? paymentDate;
  double? principalAmount;
  double? interestAmount;
  double? totalPayment;
  double? balanceLoanAmount;
  String? loan;
  String? loanId;
  String? applicantType;
  String? applicant;
  String? memberName;
  String? group;
  String? mobileNo;
  String? mobileNo2;
  double? amountPaid;
  String? paymentStatus;
  double? remainingAmount;
  String? memberImage;

  LoanEmiListMessage({
    this.loanRepaymentSchedule,
    this.paymentDate,
    this.principalAmount,
    this.interestAmount,
    this.totalPayment,
    this.balanceLoanAmount,
    this.loan,
    this.loanId,
    this.mobileNo,
    this.mobileNo2,
    this.applicantType,
    this.applicant,
    this.memberName,
    this.group,
    this.amountPaid,
    this.paymentStatus,
    this.remainingAmount,
    this.memberImage,
  });

  factory LoanEmiListMessage.fromJson(Map<String, dynamic> json) =>
      LoanEmiListMessage(
        loanRepaymentSchedule: json["loan_repayment_schedule"],
        paymentDate: (json["payment_date"] as String?)
            ?.split(' ')
            .first, // only date part
        principalAmount: (json["principal_amount"] as num?)?.toDouble(),
        interestAmount: (json["interest_amount"] as num?)?.toDouble(),
        totalPayment: (json["total_payment"] as num?)?.toDouble(),
        balanceLoanAmount: (json["balance_loan_amount"] as num?)?.toDouble(),
        loan: json["loan"],
        loanId: json["custom_loan_id"],
        applicantType: json["applicant_type"],
        applicant: json["applicant"],
        memberName: json["member_name"],
        group: json["group"],
        amountPaid: (json["amount_paid"] as num?)?.toDouble(),
        paymentStatus: json["payment_status"],
        remainingAmount: (json["remaining_amount"] as num?)?.toDouble(),
        mobileNo: json["mobile_no"],
        mobileNo2: json["mobile_no_2"],
        memberImage: json["member_image"],
      );

  Map<String, dynamic> toJson() => {
        "loan_repayment_schedule": loanRepaymentSchedule,
        "payment_date": paymentDate,
        "principal_amount": principalAmount,
        "interest_amount": interestAmount,
        "total_payment": totalPayment,
        "balance_loan_amount": balanceLoanAmount,
        "loan": loan,
        "custom_loan_id": loanId,
        "applicant_type": applicantType,
        "applicant": applicant,
        "member_name": memberName,
        "group": group,
        "amount_paid": amountPaid,
        "payment_status": paymentStatus,
        "remaining_amount": remainingAmount,
        "mobile_no": mobileNo,
        "mobile_no_2": mobileNo2,
        "member_image": memberImage,
      };
}
