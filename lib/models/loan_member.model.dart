class LoanMemberCount {
  Message? message;

  LoanMemberCount({this.message});

  factory LoanMemberCount.fromJson(Map<String, dynamic> json) => LoanMemberCount(
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class Message {
  int? loanMembers;
  int? verifiedCount;
  int? rejectedCount;
  int? nonVerifiedCount;
  int? withoutGroupCount;
  int? assignedMembers;

  Message({
    this.loanMembers,
    this.verifiedCount,
    this.rejectedCount,
    this.nonVerifiedCount,
    this.withoutGroupCount,
    this.assignedMembers,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        loanMembers: json["loan_members"] ?? 0,
        verifiedCount: json["verified_count"] ?? 0,
        rejectedCount: json["rejected_count"] ?? 0,
        nonVerifiedCount: json["non_verified_count"] ?? 0,
        withoutGroupCount: json["without_group_count"] ?? 0,
        assignedMembers: json["assigned_members"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "loan_members": loanMembers,
        "verified_count": verifiedCount,
        "rejected_count": rejectedCount,
        "non_verified_count": nonVerifiedCount,
        "without_group_count": withoutGroupCount,
        "assigned_members": assignedMembers,
      };
}
