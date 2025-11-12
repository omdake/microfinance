class GroupCreation {
  GroupCreationMessage? message;

  GroupCreation({
    this.message,
  });

  factory GroupCreation.fromJson(Map<String, dynamic> json) => GroupCreation(
        message: GroupCreationMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class GroupCreationMessage {
  int? count;
  dynamic next;
  dynamic previous;
  List<GroupCreationResult>? results;

  GroupCreationMessage({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory GroupCreationMessage.fromJson(Map<String, dynamic> json) =>
      GroupCreationMessage(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<GroupCreationResult>.from(
            json["results"].map((x) => GroupCreationResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class GroupCreationResult {
  String? name;
  String? groupName;
  String? groupHead;
  dynamic groupImage;
  String? groupHeadMemberName;
  String? workflowState;

  GroupCreationResult(
      {this.name,
      this.groupName,
      this.groupHead,
      this.groupImage,
      this.groupHeadMemberName,
      this.workflowState});

  factory GroupCreationResult.fromJson(Map<String, dynamic> json) =>
      GroupCreationResult(
        name: json["name"],
        groupName: json["group_name"],
        groupHead: json["group_head"],
        groupImage: json["group_image"],
        groupHeadMemberName: json["group_head_member_name"],
        workflowState: json["workflow_state"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "group_name": groupName,
        "group_head": groupHead,
        "group_image": groupImage,
        "group_head_member_name": groupHeadMemberName,
        "workflow_state": workflowState,
      };
}
