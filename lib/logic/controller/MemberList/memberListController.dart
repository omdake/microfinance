import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/models/group_list.model.dart';
import 'package:microfinance/models/loan_memeber_list.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class MemberListController extends GetxController {
  RxList<GroupListMessage> groupList = <GroupListMessage>[].obs;
  RxList<LoanMemberListResult> loanMemberList = <LoanMemberListResult>[].obs;
  RxString selectedGroup = "".obs;
  RxBool isLoading = false.obs;
  RxString status = ''.obs;
  RxBool isGroup = true.obs;
  RxInt page = 1.obs;
  RxBool hasNextPage = true.obs;
  RxString screenTitle = ''.obs;
  Rx<TextEditingController> groupSearchController = TextEditingController().obs;
  Rx<TextEditingController> search = TextEditingController().obs;

  void onSearchChanged(String query) {
    if (isGroup.value == false) {
      page.value = 1;
      //loanMemberList.clear();
      getUngroupedLoanMemberList(
          isGroup: isGroup.value, search: search.value.text);
    }
  }

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      if (Get.arguments['title'] != null) {
        screenTitle.value = Get.arguments['title'];
      }
      if (Get.arguments['status'] != null) {
        status.value = Get.arguments['status'];
      }
      if (Get.arguments['group'] != null) {
        selectedGroup.value = Get.arguments['group'];
      }
      if (Get.arguments['is_group'] != null) {
        isGroup.value = Get.arguments['is_group'];

        if (isGroup.value) {
          getGroupList();
          totalLoanMemberList(Status: status.value, isGroup: isGroup.value);
        } else {
          getUngroupedLoanMemberList(
            isGroup: isGroup.value,
            search: search.value.text,
          );
        }
        return;
      }
    }
    getGroupList();
    getLoanMemberList(Status: status.value);
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
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
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

  getloadData() {
    page.value = 1;
    loanMemberList.value = [];
    getLoanMemberList(Status: status.value);
  }

  getLoadMoreData() async {
    if (!hasNextPage.value || isLoading.value) return;
    page.value += 1;
    if (isGroup.value) {
      await getLoanMemberList(Status: status.value);
    } else {
      await getUngroupedLoanMemberList(isGroup: isGroup.value);
    }
  }

  getUngroupedLoanMemberList({bool? isGroup, String? search}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl +
            AppURLs.unGroupedloanMemberList(
                search: search,
                country: "india",
                isPagination: true,
                page: page.value,
                pagesize: 10,
                isGroup: isGroup)),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final message = data['message'];
        final results = message['results'] as List<dynamic>;
        final members =
            results.map((e) => LoanMemberListResult.fromJson(e)).toList();

        final ungroupedMembers =
            members.where((m) => m.group == null || m.group!.isEmpty).toList();

        if (page.value == 1) {
          loanMemberList.value = ungroupedMembers;
        } else {
          loanMemberList.addAll(ungroupedMembers);
        }
        hasNextPage.value = message['next'] != null;
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
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

  getLoanMemberList({String? Status}) async {
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
              isPagination: true,
              page: page.value,
              pagesize: 10,
            )),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final message = data['message'];

        final results = message['results'] as List<dynamic>;

        final members =
            results.map((e) => LoanMemberListResult.fromJson(e)).toList();

        if (page.value == 1) {
          loanMemberList.value = members;
        } else {
          loanMemberList.addAll(members);
        }
        hasNextPage.value = message['next'] != null;
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
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

  totalLoanMemberList({String? Status, bool? isGroup}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl +
            AppURLs.totalLoanMemberList(
                country: "india",
                group: selectedGroup.value,
                search: "",
                Status: Status ?? "",
                isPagination: true,
                page: page.value,
                pagesize: 10,
                isGroup: isGroup)),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final message = data['message'];

        final results = message['results'] as List<dynamic>;

        final members =
            results.map((e) => LoanMemberListResult.fromJson(e)).toList();

        if (page.value == 1) {
          loanMemberList.value = members;
        } else {
          loanMemberList.addAll(members);
        }
        hasNextPage.value = message['next'] != null;
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
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
