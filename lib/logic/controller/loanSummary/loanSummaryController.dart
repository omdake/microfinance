import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/models/group_list.model.dart';
import 'package:microfinance/models/loan_disbursement.model.dart';
import 'package:microfinance/models/loan_list.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class LoanSummaryController extends GetxController {
  RxBool isLoading = false.obs;
  RxString selectedGroup = "".obs;
  RxInt selectedIndex = 0.obs;
  RxString selectedGroupId = ''.obs;
  RxString selectedLoan = ''.obs;
  RxString selectedApplicantId = ''.obs;
  Rx<TextEditingController> groupSearchController = TextEditingController().obs;
  RxInt page = 1.obs;
  RxBool hasNextPage = true.obs;
  Rx<TextEditingController> search = TextEditingController().obs;

  void onSearchChanged(String query) {
    page.value = 1;
    //groupList.clear();
    getLoanDisbursementList(page: page.value, search: search.value.text);
  }

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
    if (Get.arguments != null && Get.arguments['selectedIndex'] != null) {
      selectedIndex.value = Get.arguments['selectedIndex'];
    } else {
      selectedIndex.value = 0;
    }
    getGroupList();
    getLoanDisbursementList(page: page.value, search: search.value.text);
    getLoanList();
  }

  getloadData() async {
    page.value = 1;
    hasNextPage.value = true;
    //loanDisbursementList.clear();
    await getLoanDisbursementList(page: page.value, search: search.value.text);
  }

  getLoadMoreData() async {
    if (isLoading.value || !hasNextPage.value) return;
    page.value += 1;
    await getLoanDisbursementList(page: page.value, search: search.value.text);
  }

  getGroupList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;

      final url = Uri.parse(AppEnvironment.baseUrl + AppURLs.groupList);

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> messages = responseBody['message'];
        groupList.value =
            messages.map((e) => GroupListMessage.fromJson(e)).toList();
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
      }
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: url.toString(),
          dateTime: DateTime.now(),
          data: {},
          response: responseBody,
        ),
      );
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: "${AppEnvironment.baseUrl}${AppURLs.groupList}",
          dateTime: DateTime.now(),
          data: {},
          response: {"error": e.toString()},
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  getLoanDisbursementList(
      {String? loanGroup, int? page, String? search}) async {
    final token = await AppPreferences.getToken();
    try {
      final url = Uri.parse(AppEnvironment.baseUrl +
          AppURLs.getLoanDisbursementList(
              loanGroup: selecteddisbursementGroup.value,
              page: page,
              pagesize: 10,
              isPagination: true,
              search: search));

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final results = responseBody['message']?['results'] as List<dynamic>;
        final newItems =
            results.map((e) => LoanDisbursementResult.fromJson(e)).toList();
        if (page == 1) {
          loanDisbursementList.value = newItems;
        } else {
          loanDisbursementList.addAll(newItems);
        }
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
      }
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: url.toString(),
          dateTime: DateTime.now(),
          data: {},
          response: responseBody,
        ),
      );
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: "${AppEnvironment.baseUrl}${AppURLs.groupList}",
          dateTime: DateTime.now(),
          data: {},
          response: {"error": e.toString()},
        ),
      );
    }
  }

  getLoanList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;

      final url = Uri.parse(AppEnvironment.baseUrl + AppURLs.getLoanlist);

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final messages = responseBody['message'] as List<dynamic>;
        loantList.value =
            messages.map((e) => LoanListMessage.fromJson(e)).toList();
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else {
        final err = jsonDecode(response.body);
        CustomSnackBar.show(
            isIssue: true, message: err['message']['msg'] ?? "Error");
      }
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: url.toString(),
          dateTime: DateTime.now(),
          data: {},
          response: responseBody,
        ),
      );
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: "${AppEnvironment.baseUrl}${AppURLs.groupList}",
          dateTime: DateTime.now(),
          data: {},
          response: {"error": e.toString()},
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
