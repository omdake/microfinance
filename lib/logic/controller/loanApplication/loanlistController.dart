import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';

import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/models/group_list.model.dart';
import 'package:microfinance/models/loan_applicant_list.model.dart';

import 'package:microfinance/utils/snackbar_widget.dart';

class LoanApplicationListController extends GetxController {
  Rx<TextEditingController> groupSearchController = TextEditingController().obs;

  RxList<LoanApplicantListResult> loanApplicantList =
      <LoanApplicantListResult>[].obs;
  RxList<GroupListMessage> groupList = <GroupListMessage>[].obs;
  RxBool isLoading = false.obs;
  RxString selectedGroup = "".obs;
  RxBool hasNextPage = true.obs;
  RxInt page = 1.obs;
  @override
  void onInit() async {
    super.onInit();
    getGroupList();
    getAplicantList(page: page.value, loanGroup: selectedGroup.value);
  }

  getloadData() {
    page.value = 1;
    loanApplicantList.clear();
    getAplicantList(page: page.value, loanGroup: selectedGroup.value);
  }

  getLoadMoreData() {
    if (!hasNextPage.value) return;
    page.value += 1;
    getAplicantList(page: page.value, loanGroup: selectedGroup.value);
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

  getAplicantList({int? page, String? loanGroup}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl +
            AppURLs.getApplicantList(
                page: page,
                loanGroup: selectedGroup.value,
                pageSize: 10,
                isPagination: true)),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final results = data['message']?['results'] as List<dynamic>;
        final newItems =
            results.map((e) => LoanApplicantListResult.fromJson(e)).toList();

        if (page == 1) {
          loanApplicantList.value = newItems;
        } else {
          loanApplicantList.addAll(newItems);
        }

        hasNextPage.value = data['message']?['next'] != null;
      } else {
        final err = jsonDecode(response.body);
        CustomSnackBar.show(
            isIssue: true, message: err['message']['msg'] ?? "Error");
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }
}
