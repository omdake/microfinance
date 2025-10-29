import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/models/loan_member.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:microfinance/models/total_loan_count.model.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class DashboardController extends GetxController {
  RxString lable = "DASHBOARD".obs;
  RxBool isLoading = false.obs;
  RxList<Message> messageList = <Message>[].obs;
  RxString selectedGroup = "".obs;

  RxInt totalMembers = 0.obs;
  RxInt verifiedMembers = 0.obs;
  RxInt ungroupedMembers = 0.obs;
  RxInt pendingVerification = 0.obs;

  RxInt todaysCollection = 0.obs;
  RxInt dueReport = 0.obs;
  RxInt assignedGroup = 0.obs;
  RxDouble collectionByCash = 0.0.obs;

  RxString fullName = "".obs;
  RxString email = "".obs;
  RxBool isLoader = true.obs;
  RxString appName = ''.obs;
  RxString version = ''.obs;
  RxString buildNumber = ''.obs;
  RxString packageName = ''.obs;
  RxInt currentIndex = 0.obs;
  RxInt selectedIndex = 0.obs;
  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() async {
    loadFullName();
    getLoanMemberCount();
    getTotalLoanCount();
    getAppInfo();
    super.onInit();
  }

  void loadFullName() async {
    final name = await AppPreferences.getName();
    final emailId = await AppPreferences.getEmailId();
    fullName.value = name ?? "-";
    email.value = emailId ?? "-";
  }

  Future<void> getAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      appName.value = packageInfo.appName;
      packageName.value = packageInfo.packageName;
      version.value = packageInfo.version;
      buildNumber.value = packageInfo.buildNumber;
    } catch (e) {
      debugPrint("Failed to get app info: $e");
    }
  }

  getLoanMemberCount() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.loanMemberCount),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final message = Message.fromJson(data['message']);

        totalMembers.value = message.loanMembers ?? 0;
        verifiedMembers.value = message.verifiedCount ?? 0;
        ungroupedMembers.value = message.withoutGroupCount ?? 0;
        pendingVerification.value = message.nonVerifiedCount ?? 0;
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
        if (response.statusCode == 401) {
          await oauthService.handleExceptionLogout('AuthenticationError');
        }
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  getTotalLoanCount() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.totalLoanCount),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final message = TotalLoanCountMessage.fromJson(data['message']);

        todaysCollection.value = message.todaysCollection ?? 0;
        dueReport.value = (message.remainingAmount ?? 0.0).toInt();
        assignedGroup.value = (message.monthlyCollection ?? 0.0).toInt();
        collectionByCash.value = message.collectionInHand ?? 0.0;
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
        if (response.statusCode == 401) {
          await oauthService.handleExceptionLogout('AuthenticationError');
        }
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }
}
