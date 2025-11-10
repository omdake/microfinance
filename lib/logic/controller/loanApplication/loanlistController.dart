import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/models/group_list.model.dart';
import 'package:microfinance/models/loan_applicant_list.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
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
  Rx<File?> loanApplicationImage = Rx<File?>(null);
  RxString loanApplicationImageUrl = ''.obs;
  RxString token = ''.obs;
  RxBool isloanApplicationFocused = false.obs;
  Rx<TextEditingController> search = TextEditingController().obs;

  void onSearchChanged(String query) {
    page.value = 1;
    groupList.clear();
    getAplicantList(page: page.value, loanGroup: selectedGroup.value,search:search.value.text);
  }
  @override
  void onInit() async {
    super.onInit();
    getGroupList();
    getAplicantList(page: page.value, loanGroup: selectedGroup.value,search:search.value.text);
  }

  getloadData() {
    page.value = 1;
    loanApplicantList.clear();
    getAplicantList(page: page.value, loanGroup: selectedGroup.value,search:search.value.text);
  }

  getLoadMoreData() {
    if (!hasNextPage.value) return;
    page.value += 1;
    getAplicantList(page: page.value, loanGroup: selectedGroup.value,search:search.value.text);
  }

  getGroupList() async {
    token.value = await AppPreferences.getToken() ?? '';
    try {
      isLoading.value = true;

      final url = Uri.parse(AppEnvironment.baseUrl + AppURLs.groupList);
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token.value,
        },
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> messages = responseBody['message'] ?? [];
        groupList.value = messages
            .map((e) => GroupListMessage.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
      } else {
        String msg = responseBody['message']?['msg'] ?? "Something went wrong";
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

  getAplicantList({int? page, String? loanGroup,String?search}) async {
    final token = await AppPreferences.getToken();
    try {
      final url = Uri.parse(
        "${AppEnvironment.baseUrl}${AppURLs.getApplicantList(
          page: page,
          loanGroup: selectedGroup.value,
          pageSize: 10,
          isPagination: true,
          search: search
        )}",
      );

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token ?? "",
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final results =
            responseBody['message']?['results'] as List<dynamic>? ?? [];

        final newItems = results
            .map((e) =>
                LoanApplicantListResult.fromJson(e as Map<String, dynamic>))
            .toList();

        if (page == 1) {
          loanApplicantList.value = newItems;
        } else {
          loanApplicantList.addAll(newItems);
        }

        hasNextPage.value = responseBody['message']?['next'] != null;
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
      } else {
        CustomSnackBar.show(
          isIssue: true,
          message: responseBody['message']?['msg'] ?? "Something went wrong",
        );
      }
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: url.toString(),
          dateTime: DateTime.now(),
          data: {},
          response: jsonDecode(response.body),
        ),
      );
    } catch (e) {
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: "${AppEnvironment.baseUrl}${AppURLs.getApplicantList()}",
          dateTime: DateTime.now(),
          data: {},
          response: {"error": e.toString()},
        ),
      );
    } finally {
      //isLoading.value = false;
    }
  }
}
