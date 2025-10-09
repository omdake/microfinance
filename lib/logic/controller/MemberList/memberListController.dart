import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/models/group_list.model.dart';
import 'package:microfinance/models/loan_memeber_list.model.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class MemberListController extends GetxController {
  RxList<GroupListMessage> groupList = <GroupListMessage>[].obs;
  RxList<LoanMemberListMessage> loanMemberList = <LoanMemberListMessage>[].obs;
  RxString selectedGroup = "".obs;
  RxBool isLoading = false.obs;
  RxString status = ''.obs;
  RxBool isGroup = true.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments ?? {};
    status.value = args["status"] ?? "";
    selectedGroup.value = args["group"] ?? "";
    isGroup.value = args["isGroup"] ?? true;

    if (isGroup.value) {
      getGroupList();
    } else {
      getLoanMemberList(Status: status.value, isGroup: false);
    }
  }

  getGroupList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.groupList),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> messages = data['message'];
        groupList.value =
            messages.map((e) => GroupListMessage.fromJson(e)).toList();
        if (groupList.isNotEmpty) {
          if (selectedGroup.value.isEmpty) {
            selectedGroup.value = groupList.first.name ?? "";
          }

          getLoanMemberList(Status: status.value, isGroup: true);
        }
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  getLoanMemberList({String? Status, bool? isGroup}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl +
            AppURLs.loanMemberList(
              country: "india",
              group: selectedGroup.value,
              search: "",
              Status: Status ?? "",
              isGroup: isGroup ?? true,
            )),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final messages = data['message'] as List<dynamic>;

        final allMembers =
            messages.map((e) => LoanMemberListMessage.fromJson(e)).toList();

        if (selectedGroup.value.isNotEmpty) {
          loanMemberList.value =
              allMembers.where((m) => m.group == selectedGroup.value).toList();
        } else {
          loanMemberList.value = allMembers;
        }
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }
}
