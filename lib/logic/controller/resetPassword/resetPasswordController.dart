import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/api_status_code.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/routes/routes_string.dart';
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
    final uri = Uri.parse(AppEnvironment.baseUrl + AppURLs.resetPassword);
    final Map<String, dynamic> requestBody = {
      "previous_password": previousPassword.value.text,
      "new_password": newPassword.value.text,
      "confirm_password": confirmPassword.value.text,
    };

    try {
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
        body: jsonEncode(requestBody),
      );

      Map<String, dynamic> responseBody = {};
      try {
        responseBody = jsonDecode(response.body);
      } catch (_) {}

      if (response.statusCode == APIStatusCode.SUCCESS) {
        CustomSnackBar.show(
            isIssue: false, message: responseBody["message"]["msg"]);
        Get.until((route) => Get.currentRoute == Routes.homeScreen);
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
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
          data: requestBody,
          response: responseBody,
        ),
      );
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "POST",
          path: uri.toString(),
          dateTime: DateTime.now(),
          data: requestBody,
          response: {"error": e.toString()},
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
