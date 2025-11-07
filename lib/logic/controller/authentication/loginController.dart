import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/utils/extension/extension/string_extensions.dart';
import 'package:microfinance/utils/snackbar_widget.dart';
import '../../../api/api_status_code.dart';
import '../../../api/app_envirments.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final showOtpSection = false.obs;
  RxString verifyEmail = "".obs;
  RxInt resetpasswordotp = 0.obs;
  RxBool hidePassword = true.obs;
  RxBool hidenewPassword = true.obs;
  RxBool hideconfirmPassword = true.obs;
  final username = TextEditingController();
  final password = TextEditingController();
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> otp = TextEditingController().obs;
  Rx<TextEditingController> newPassword = TextEditingController().obs;
  Rx<TextEditingController> ConfirmPassword = TextEditingController().obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      verifyEmail.value = Get.arguments['email'] ?? "";
      resetpasswordotp.value = Get.arguments['otp'] ?? 0;
    }
  }

  login() async {
    if (username.text.isEmpty || password.text.isEmpty) {
      CustomSnackBar.show(isIssue: true, message: "Please fill all fields");
      return;
    }
    isLoading.value = true;
    final uri = Uri.parse(AppEnvironment.baseUrl + AppURLs.login);
    final Map<String, dynamic> requestData = {
      "username": username.text,
      "password": password.text,
    };
    try {
      final response = await http.post(
        uri,
        body: requestData,
      );
      Map<String, dynamic> responseBody = {};
      try {
        responseBody = jsonDecode(response.body);
      } catch (_) {}
      if (response.statusCode == APIStatusCode.SUCCESS) {
        final apiKey = responseBody["message"]["token"]["api_key"];
        final apiSecret = responseBody["message"]["token"]["api_secret"];
        final name = responseBody["message"]["user"]["full_name"] ?? '';
        final emailId = responseBody["message"]["user"]["email"] ?? '';
        final empId =
            responseBody["message"]["user"]["emp_details"]["employee"] ?? '';
        final empName = responseBody["message"]["user"]["emp_details"]
                ["employee_name"] ??
            '';
        final token = "token $apiKey:$apiSecret";

        await AppPreferences.setToken(token);
        await AppPreferences.setName(name);
        await AppPreferences.setEmailId(emailId);
        await AppPreferences.setEmpName(empName);
        await AppPreferences.setEmpId(empId);

        await Get.offAllNamed(Routes.homeScreen);
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
      CustomSnackBar.show(isIssue: true, message: "$e");
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

  sendOTP() async {
    isLoading.value = true;
    final uri = Uri.parse(AppEnvironment.baseUrl + AppURLs.forgotPasswordOtp);
    final Map<String, dynamic> requestBody = {
      "email": email.value.text,
    };

    if (requestBody["email"] == null || requestBody["email"]!.isEmpty) {
      CustomSnackBar.show(isIssue: true, message: "Please enter email");
      return;
    }

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(requestBody),
        headers: {"Content-Type": "application/json"},
      );

      Map<String, dynamic> responseBody = {};
      try {
        responseBody = jsonDecode(response.body);
      } catch (_) {}

      if (response.statusCode == APIStatusCode.SUCCESS) {
        CustomSnackBar.show(
            isIssue: false, message: responseBody["message"]?["msg"]);
        verifyEmail.value = email.value.text;
        showOtpSection.value = true;
      } else {
        final msg = responseBody['message']?['msg'] ?? "Something went wrong";
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

  VerifyOTP() async {
    isLoading.value = true;
    final uri = Uri.parse(AppEnvironment.baseUrl + AppURLs.verifyOtp);
    final Map<String, dynamic> requestBody = {
      "email": verifyEmail.value.toString(),
      "otp": otp.value.text.toINT,
    };

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(requestBody),
        headers: {"Content-Type": "application/json"},
      );

      Map<String, dynamic> responseBody = {};
      try {
        responseBody = jsonDecode(response.body);
      } catch (_) {}

      if (response.statusCode == APIStatusCode.SUCCESS) {
        CustomSnackBar.show(
            isIssue: false, message: responseBody["message"]?["msg"]);
        resetpasswordotp.value = otp.value.text.toINT;

        Get.toNamed(
          Routes.resetPasswordScreen,
          arguments: {
            'email': verifyEmail.value,
            'otp': resetpasswordotp.value,
          },
        );
      } else {
        final msg = responseBody['message']?['msg'] ?? "Something went wrong";
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

  ResetPassword() async {
    isLoading.value = true;
    if (newPassword.value.text.isEmpty || ConfirmPassword.value.text.isEmpty) {
      CustomSnackBar.show(
          isIssue: true, message: "Please fill both password fields");
      isLoading.value = false;
      return;
    }

    if (newPassword.value.text != ConfirmPassword.value.text) {
      CustomSnackBar.show(isIssue: true, message: "Passwords do not match");
      isLoading.value = false;
      return;
    }
    final uri =
        Uri.parse(AppEnvironment.baseUrl + AppURLs.resetPasswordWithOtp);
    final Map<String, dynamic> requestBody = {
      "email": verifyEmail.value,
      "otp": resetpasswordotp.value,
      "new_password": newPassword.value.text,
      "confirm_password": ConfirmPassword.value.text,
    };

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(requestBody),
        headers: {"Content-Type": "application/json"},
      );

      Map<String, dynamic> responseBody = {};
      try {
        responseBody = jsonDecode(response.body);
      } catch (_) {}

      if (response.statusCode == APIStatusCode.SUCCESS) {
        CustomSnackBar.show(
            isIssue: false, message: responseBody["message"]?["msg"]);
        Get.toNamed(Routes.loginScreen);
      } else {
        final msg = responseBody['message']?['msg'] ?? "Something went wrong";
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
