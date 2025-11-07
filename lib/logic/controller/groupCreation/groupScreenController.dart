import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/api_status_code.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/models/loan_memeber_list.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class GroupScreenController extends GetxController {
  Rx<TextEditingController> groupSearchController = TextEditingController().obs;
  Rx<TextEditingController> groupCode = TextEditingController().obs;
  Rx<TextEditingController> groupName = TextEditingController().obs;
  RxString selectedGroupHead = "".obs;
  Rx<File?> groupImage = Rx<File?>(null);
  RxString groupImageUrl = ''.obs;
  RxBool isgroupImageFocused = false.obs;
  RxBool isLoading = false.obs;
  RxInt page = 1.obs;
  RxBool isReadOnly = false.obs;
  RxBool isFormEdit = false.obs;

  RxList<LoanMemberDropdownListMessage> groupheadList =
      <LoanMemberDropdownListMessage>[].obs;
  Future<void> pickImage(Rx<File?> imageHolder) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      imageHolder.value = File(result.files.single.path!);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    getheadList();
  }

  saveGroup() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    final uri = Uri.parse(AppEnvironment.baseUrl + AppURLs.saveCreatedGroup);
    final Map<String, dynamic> requestData = {
      "group_name": groupName.value.text,
      "group_head": selectedGroupHead.value,
      "group_code": groupCode.value.text,
    };
    try {
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = token!;
      request.fields
          .addAll(requestData.map((k, v) => MapEntry(k, v.toString())));

      Map<String, Rx<File?>> imageFields = {
        'group_image': groupImage,
      };
      for (var entry in imageFields.entries) {
        if (entry.value.value != null) {
          var file = await http.MultipartFile.fromPath(
              entry.key, entry.value.value!.path);
          request.files.add(file);
        }
      }
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      Map<String, dynamic> responseBody = {};
      try {
        responseBody = jsonDecode(response.body);
      } catch (_) {}

      if (response.statusCode == APIStatusCode.SUCCESS) {
        CustomSnackBar.show(
            isIssue: false, message: responseBody["message"]["msg"]);
        clearFields();
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
      } else {
        final msg = responseBody['message']?['msg'] ?? 'Something went wrong';
        CustomSnackBar.show(isIssue: true, message: msg);
      }
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "POST",
          path: uri.toString(),
          dateTime: DateTime.now(),
          data: requestData,
          response: responseBody,
        ),
      );
    } catch (e) {
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "POST",
          path: uri.toString(),
          dateTime: DateTime.now(),
          data: requestData,
          response: {"error": e.toString()},
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  getheadList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final url = Uri.parse(AppEnvironment.baseUrl +
          AppURLs.loanHeadList(
            country: "india",
            search: "",
            Status: "verified",
            isGroup: true,
          ));
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
        groupheadList.value = messages
            .map((e) => LoanMemberDropdownListMessage.fromJson(e))
            .toList();
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
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

  void clearFields() {
    groupCode.value.clear();
    groupName.value.clear();
    selectedGroupHead.value = '';
    groupImage.value = null;
    groupImageUrl.value = '';
    isgroupImageFocused.value = false;
  }
}
