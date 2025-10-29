import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/api_status_code.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class ResetPasswordController extends GetxController {
  Rx<TextEditingController> previousPassword = TextEditingController().obs;
  Rx<TextEditingController> newPassword = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  RxBool isLoading = false.obs;
  RxBool hidePassword = true.obs;
  RxBool confirmHidePassword = true.obs;

  resetPassword() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    try {
      final requestBody = {
        "previous_password": previousPassword.value.text,
        "new_password": newPassword.value.text,
        "confirm_password": confirmPassword.value.text
      };
      final response = await http.post(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.resetPassword),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == APIStatusCode.SUCCESS) {
        var json = jsonDecode(response.body);
        CustomSnackBar.show(isIssue: false, message: json["message"]["msg"]);
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
      }else {
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
}
