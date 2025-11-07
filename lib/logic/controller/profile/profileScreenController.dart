import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/models/user_profile.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class ProfileScreenController extends GetxController {
  Rx<TextEditingController> empName = TextEditingController().obs;
  Rx<TextEditingController> gender = TextEditingController().obs;
  Rx<TextEditingController> dob = TextEditingController().obs;
  Rx<TextEditingController> dojoining = TextEditingController().obs;
  Rx<TextEditingController> status = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> company = TextEditingController().obs;
  Rx<TextEditingController> department = TextEditingController().obs;
  Rx<TextEditingController> designation = TextEditingController().obs;
  Rx<TextEditingController> bloodGroup = TextEditingController().obs;
  Rx<TextEditingController> bio = TextEditingController().obs;
  Rx<TextEditingController> maritalStatus = TextEditingController().obs;

  Rx<File?> memberImage = Rx<File?>(null);
  RxString memberImageUrl = ''.obs;

  RxBool isMemberImageFocused = false.obs;
  RxBool isLoading = false.obs;
  RxString token = ''.obs;
  RxList<UserProfileEmployee> userProfileList = <UserProfileEmployee>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
  }

  getUserProfile() async {
    token.value = await AppPreferences.getToken() ?? '';
    try {
      isLoading.value = true;

      final url = Uri.parse(AppEnvironment.baseUrl + AppURLs.getUserProfile);
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token.value,
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final employeeData = responseBody['message']['employee'];
        final userData = responseBody['message']['user'];
        empName.value.text = employeeData['employee_name'] ?? '';
        gender.value.text = employeeData['gender'] ?? '';
        dob.value.text = employeeData['date_of_birth'] ?? '';
        dojoining.value.text = employeeData['date_of_joining'] ?? '';
        status.value.text = employeeData['status'] ?? '';
        email.value.text = userData['email'] ?? '';
        company.value.text = employeeData['company'] ?? '';
        department.value.text = employeeData['department'] ?? '';
        designation.value.text = employeeData['designation'] ?? '';
        bloodGroup.value.text = employeeData['blood_group'] ?? '';
        maritalStatus.value.text = employeeData['marital_status'] ?? '';

        final imagePath = employeeData['image'];
        if (imagePath != null && imagePath.isNotEmpty) {
          memberImageUrl.value = "${AppEnvironment.baseUrl}$imagePath";
        } else {
          memberImageUrl.value = '';
        }
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
      } else {
        final err = jsonDecode(response.body);
        String msg = err['message']['msg'];
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
}
