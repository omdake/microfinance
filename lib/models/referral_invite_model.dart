class ReferralInviteResponse {
  final bool success;
  final String message;
  final List<ReferralInviteTable> responseTable;

  ReferralInviteResponse({
    required this.success,
    required this.message,
    required this.responseTable,
  });

  factory ReferralInviteResponse.fromJson(Map<String, dynamic> json) {
    return ReferralInviteResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      responseTable: (json["response"]["Table"] as List)
          .map((e) => ReferralInviteTable.fromJson(e))
          .toList(),
    );
  }
}

class ReferralInviteTable {
  final String returnMsg;
  final int success;

  ReferralInviteTable({
    required this.returnMsg,
    required this.success,
  });

  factory ReferralInviteTable.fromJson(Map<String, dynamic> json) {
    return ReferralInviteTable(
      returnMsg: json["ReturnMsg"] ?? "",
      success: json["Success"] ?? 0,
    );
  }
}
