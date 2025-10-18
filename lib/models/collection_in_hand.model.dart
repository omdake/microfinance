class CollectionInhand {
  CollectionInhandMessage? message;

  CollectionInhand({
    this.message,
  });

  factory CollectionInhand.fromJson(Map<String, dynamic> json) =>
      CollectionInhand(
        message: CollectionInhandMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class CollectionInhandMessage {
  int? count;
  dynamic next;
  dynamic previous;
  List<CollectionInhandResult>? results;

  CollectionInhandMessage({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory CollectionInhandMessage.fromJson(Map<String, dynamic> json) =>
      CollectionInhandMessage(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<CollectionInhandResult>.from(
            json["results"].map((x) => CollectionInhandResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class CollectionInhandResult {
  String? name;
  String? employee;
  String? loanRepayment;
  double? amount;
  String? givenTo;
  DateTime? postingDate;
  String? applicant;
  String? loan;
  String? paymentProof;
  String? amountGivenEmp;
  dynamic description;
  String? employeeEmployeeName;

  CollectionInhandResult({
    this.name,
    this.employee,
    this.loanRepayment,
    this.amount,
    this.givenTo,
    this.postingDate,
    this.applicant,
    this.loan,
    this.paymentProof,
    this.amountGivenEmp,
    this.employeeEmployeeName,
  });

  factory CollectionInhandResult.fromJson(Map<String, dynamic> json) =>
      CollectionInhandResult(
        name: json["name"],
        employee: json["employee"],
        loanRepayment: json["loan_repayment"],
        amount: (json["amount"] != null) ? json["amount"].toDouble() : null,
        givenTo: json["given_to"],
        postingDate: DateTime.parse(json["posting_date"]),
        applicant: json["applicant"],
        loan: json["loan"],
        paymentProof: json["payment_proof"],
        amountGivenEmp: json["amount_given_emp"],
        employeeEmployeeName: json["employee_employee_name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "employee": employee,
        "loan_repayment": loanRepayment,
        "amount": amount,
        "given_to": givenTo,
        "posting_date":
            "${postingDate!.year.toString().padLeft(4, '0')}-${postingDate!.month.toString().padLeft(2, '0')}-${postingDate!.day.toString().padLeft(2, '0')}",
        "applicant": applicant,
        "loan": loan,
        "payment_proof": paymentProof,
        "amount_given_emp": amountGivenEmp,
        "employee_employee_name": employeeEmployeeName,
      };
}
