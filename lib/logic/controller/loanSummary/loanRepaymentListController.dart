import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/models/group_list.model.dart';
import 'package:microfinance/models/loan_repayment_model.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class LoanSummaryListController extends GetxController {
  RxBool isLoading = false.obs;
  RxString selectedGroup = "".obs;
  RxString selectedGroupId = ''.obs;
  RxList<GroupListMessage> groupList = <GroupListMessage>[].obs;
  RxList<RepaymentListResult> repaymentList = <RepaymentListResult>[].obs;

  RxInt page = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getGroupList();
    getRepaymentList();
  }

  getloadData() {
    page.value = 1;
    repaymentList.value = [];
    getRepaymentList(page: page.value);
  }

  getLoadMoreData() {
    page.value = page.value + 1;
    getRepaymentList(page: page.value);
  }

  getGroupList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.groupList),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> messages = data['message'];
        groupList.value =
            messages.map((e) => GroupListMessage.fromJson(e)).toList();
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  getRepaymentList({String? loanGroup, int? page}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl +
            AppURLs.getLoanRepayments(
                loanGroup: selectedGroup.value, page: page)),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> messages = data['message']?['results'] ?? [];
        repaymentList.value =
            messages.map((e) => RepaymentListResult.fromJson(e)).toList();
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
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
