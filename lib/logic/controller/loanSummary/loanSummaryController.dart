import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/models/group_list.model.dart';
import 'package:microfinance/models/loan_disbursement.model.dart';
import 'package:microfinance/models/loan_list.model.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class LoanSummaryController extends GetxController {
  RxBool isLoading = false.obs;
  RxString selectedGroup = "".obs;
  RxInt selectedIndex = 0.obs;
  RxString selectedGroupId = ''.obs;
  RxString selectedLoan = ''.obs;
  RxString selectedApplicantId = ''.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  RxBool get isSelected => (selectedIndex.value == 0).obs;
  final List<GlobalKey> itemKeys = [];
  final ScrollController scrollController = ScrollController();
  RxList<LoanDisbursementResult> loanDisbursementList =
      <LoanDisbursementResult>[].obs;
  RxList<LoanListMessage> loantList = <LoanListMessage>[].obs;
  RxString selecteddisbursementGroup = "".obs;
  RxList<GroupListMessage> groupList = <GroupListMessage>[].obs;

  RxInt page = 1.obs;
  void selectButton(
    int index,
  ) {
    selectedIndex.value = index;
    _scrollToIndex(index);
  }

  void _scrollToIndex(int index) {
    if (itemKeys.length > index) {
      final keyContext = itemKeys[index].currentContext;
      if (keyContext != null) {}
    }
  }

  @override
  void onInit() {
    super.onInit();
    getGroupList();
    getLoanDisbursementList();
    getLoanList();
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

  getLoanDisbursementList({String? loanGroup}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final url = AppEnvironment.baseUrl + AppURLs.getLoanDisbursementList(loanGroup: selecteddisbursementGroup.value);
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final messages = data['message'] as List<dynamic>;
        loanDisbursementList.value =
            messages.map((e) => LoanDisbursementResult.fromJson(e)).toList();
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

  getLoanList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.getLoanlist),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final messages = data['message'] as List<dynamic>;
        loantList.value =
            messages.map((e) => LoanListMessage.fromJson(e)).toList();
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
