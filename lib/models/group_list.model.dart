import 'dart:convert';

GroupList groupListFromJson(String str) => GroupList.fromJson(json.decode(str));

String groupListToJson(GroupList data) => json.encode(data.toJson());

class GroupList {
    List<GroupListMessage>? message;

    GroupList({
        this.message,
    });

    factory GroupList.fromJson(Map<String, dynamic> json) => GroupList(
        message: List<GroupListMessage>.from(json["message"].map((x) => GroupListMessage.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message!.map((x) => x.toJson())),
    };
}

class GroupListMessage {
    String? name;
    String? groupName;
    String? groupHead;
    dynamic groupImage;
    String? groupHeadMemberName;

    GroupListMessage({
        this.name,
        this.groupName,
        this.groupHead,
        this.groupImage,
        this.groupHeadMemberName,
    });

    factory GroupListMessage.fromJson(Map<String, dynamic> json) => GroupListMessage(
        name: json["name"],
        groupName: json["group_name"],
        groupHead: json["group_head"],
        groupImage: json["group_image"],
        groupHeadMemberName: json["group_head_member_name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "group_name": groupName,
        "group_head": groupHead,
        "group_image": groupImage,
        "group_head_member_name": groupHeadMemberName,
    };
}
