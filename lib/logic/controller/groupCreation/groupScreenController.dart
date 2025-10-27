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
import 'package:microfinance/models/loan_memeber_list.model.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class GroupScreenController extends GetxController {
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
    try {
      var uri = Uri.parse(AppEnvironment.baseUrl + AppURLs.saveCreatedGroup);
      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = token!;
      request.fields.addAll({
        "group_name": groupName.value.text,
        "group_head": selectedGroupHead.value,
        "group_code": groupCode.value.text,
      });
      Map<String, Rx<File?>> imageFields = {
        'group_image': groupImage,
      };
      for (var entry in imageFields.entries) {
        if (entry.value.value != null) {
          var file = await http.MultipartFile.fromPath(
            entry.key,
            entry.value.value!.path,
          );
          request.files.add(file);
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == APIStatusCode.SUCCESS) {
        var json = jsonDecode(response.body);
        CustomSnackBar.show(isIssue: false, message: json["message"]["msg"]);
      } else {
        Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  getheadList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl +
            AppURLs.loanHeadList(
              country: "india",
              search: "",
              Status: "verified",
              isGroup: true,
            )),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final messages = data['message'] as List<dynamic>;
        groupheadList.value = messages
            .map((e) => LoanMemberDropdownListMessage.fromJson(e))
            .toList();
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
