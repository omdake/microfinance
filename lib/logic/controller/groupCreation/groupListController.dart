import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/models/groupCreation.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class GroupListController extends GetxController {
  Rx<TextEditingController> search = TextEditingController().obs;

  RxBool isLoading = false.obs;
  RxInt page = 1.obs;
  RxBool isFormEdit = false.obs;
  RxBool isReadOnly = false.obs;
  RxBool hasNextPage = true.obs;
  Rx<File?> groupImage = Rx<File?>(null);
  RxString groupImageUrl = ''.obs;
  RxString token = ''.obs;
  RxBool isGroupImageFocused = false.obs;
  RxList<GroupCreationResult> groupList = <GroupCreationResult>[].obs;

  @override
  void onInit() async {
    super.onInit();

    getGroupList(page: page.value, search: search.value.text);
  }

  getloadData() {
    page.value = 1;
    groupList.clear();
    getGroupList(page: page.value, search: search.value.text);
  }

  void onSearchChanged(String query) {
    page.value = 1;
    groupList.clear();
    getGroupList(page: page.value, search: query);
  }

  getLoadMoreData() {
    if (!hasNextPage.value) return;
    page.value += 1;
    getGroupList(page: page.value, search: search.value.text);
  }

  getGroupList({required int page, String? search}) async {
    token.value = await AppPreferences.getToken() ?? '';
    try {
      isLoading.value = true;

      final url = Uri.parse(AppEnvironment.baseUrl +
          AppURLs.getGroupCreationList(
              page: page, search: search, pageSize: 10, isPagination: true));
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token.value,
        },
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final results = responseBody['message']?['results'] as List<dynamic>;
        final newItems =
            results.map((e) => GroupCreationResult.fromJson(e)).toList();

        if (page == 1) {
          groupList.value = newItems;
        } else {
          groupList.addAll(newItems);
        }

        hasNextPage.value = responseBody['message']?['next'] != null;
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
