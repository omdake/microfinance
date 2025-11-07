import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/models/group_list.model.dart';
import 'package:microfinance/models/loan_repayment_model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class LoanSummaryListController extends GetxController {
  RxBool isLoading = false.obs;
  RxString selectedGroup = "".obs;
  RxString selectedGroupId = ''.obs;
  RxList<GroupListMessage> groupList = <GroupListMessage>[].obs;
  RxList<RepaymentListResult> repaymentList = <RepaymentListResult>[].obs;
  Rx<TextEditingController> groupSearchController = TextEditingController().obs;
  RxInt page = 1.obs;
  RxBool hasNextPage = true.obs;

  @override
  void onInit() {
    super.onInit();
    getGroupList();
    getRepaymentList(page: page.value);
  }

  getloadData() async {
    page.value = 1;
    hasNextPage.value = true;
    repaymentList.clear();
    await getRepaymentList(page: page.value);
  }

  getLoadMoreData() async {
    if (isLoading.value || !hasNextPage.value) return;
    page.value += 1;
    await getRepaymentList(page: page.value);
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

  getRepaymentList({String? loanGroup, int? page}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl +
            AppURLs.getLoanRepayments(
                loanGroup: selectedGroup.value, page: page)),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final results = data['message']?['results'] as List<dynamic>;
        final newItems =
            results.map((e) => RepaymentListResult.fromJson(e)).toList();

        if (page == 1) {
          repaymentList.value = newItems;
        } else {
          repaymentList.addAll(newItems);
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
