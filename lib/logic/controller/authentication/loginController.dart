import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_urls.dart';
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
    try {
      http.Response response = await http.post(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.login),
        body: {
          "username": username.text,
          "password": password.text,
        },
      );

      if (response.statusCode == APIStatusCode.SUCCESS) {
        Map<String, dynamic> data = jsonDecode(response.body);
        final apiKey = data["message"]["token"]["api_key"];
        final apiSecret = data["message"]["token"]["api_secret"];
        final name = data["message"]["user"]["full_name"];
        final emailId = data["message"]["user"]["email"];
        final empId = data["message"]["user"]["emp_details"]["employee"];
        final empName = data["message"]["user"]["emp_details"]["employee_name"];
        final token = "token $apiKey:$apiSecret";
        await AppPreferences.setToken(token);
        await AppPreferences.setName(name);
        await AppPreferences.setEmailId(emailId);
        await AppPreferences.setEmpName(empName);
        await AppPreferences.setEmpId(empId);
        await Get.offAllNamed(Routes.dashboardScreen);
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

  sendOTP() async {
    isLoading.value = true;
    try {
      final requestBody = {
        "email": email.value.text,
      };
      if (requestBody["email"] == null || requestBody["email"]!.isEmpty) {
        CustomSnackBar.show(isIssue: true, message: "Please enter email");
        return;
      }
      final response = await http.post(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.forgotPasswordOtp),
        body: jsonEncode(requestBody),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == APIStatusCode.SUCCESS) {
        Map<String, dynamic> data = jsonDecode(response.body);
        CustomSnackBar.show(isIssue: false, message: data["message"]?["msg"]);
        verifyEmail.value = email.value.text;
        showOtpSection.value = true;
      } else {
        Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']?['msg'] ?? "Something went wrong";
        CustomSnackBar.show(isIssue: true, message: msg);
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  VerifyOTP() async {
    isLoading.value = true;
    try {
      final requestBody = {
        "email": verifyEmail.value.toString(),
        "otp": otp.value.text.toINT,
      };

      final response = await http.post(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.verifyOtp),
        body: jsonEncode(requestBody),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == APIStatusCode.SUCCESS) {
        Map<String, dynamic> data = jsonDecode(response.body);
        CustomSnackBar.show(isIssue: false, message: data["message"]?["msg"]);
        resetpasswordotp.value = otp.value.text.toINT;

        Get.toNamed(
          Routes.resetPasswordScreen,
          arguments: {
            'email': verifyEmail.value,
            'otp': resetpasswordotp.value,
          },
        );
      } else {
        Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']?['msg'] ?? "Something went wrong";
        CustomSnackBar.show(isIssue: true, message: msg);
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
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
    try {
      final requestBody = {
        "email": verifyEmail.value,
        "otp": resetpasswordotp.value,
        "new_password": newPassword.value.text,
        "confirm_password": ConfirmPassword.value.text,
      };
      final response = await http.post(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.resetPasswordWithOtp),
        body: jsonEncode(requestBody),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == APIStatusCode.SUCCESS) {
        Map<String, dynamic> data = jsonDecode(response.body);
        CustomSnackBar.show(isIssue: false, message: data["message"]?["msg"]);
        Get.toNamed(Routes.loginScreen);
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
}
