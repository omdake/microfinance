import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/api_status_code.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/models/loan_memeber_list.model.dart';
import 'package:microfinance/models/nominee_relation.model.dart';
import 'package:microfinance/models/product_list.model.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class LoanApplicationController extends GetxController {
  RxList<LoanMemberListMessage> loanMemberList = <LoanMemberListMessage>[].obs;
  RxList<LoanMemberListMessage> coBorrowerList = <LoanMemberListMessage>[].obs;
  RxList<LoanMemberListMessage> nomineeList = <LoanMemberListMessage>[].obs;
  RxList<RelationListMessage> RelationList = <RelationListMessage>[].obs;
  RxList<ProductListResult> productList = <ProductListResult>[].obs;
  Rx<TextEditingController> loanAmount = TextEditingController().obs;
  Rx<TextEditingController> periods = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  RxString selectedMemberName = "".obs;
  RxString selectedCoBorrower = "".obs;
  RxString selectednominee = "".obs;
  RxString selectedGroup = "".obs;
  RxString selectedRelation = "".obs;
  RxString selectedProduct = "".obs;
  RxBool isLoading = false.obs;
  RxString saveROI = ''.obs;
  RxString saveIsTermLoan = ''.obs;
  RxString selectedCoBorrowerId = "".obs;
  RxString selectedApplicantId = "".obs;
  RxString selectedNomineeId = "".obs;
  RxString selectedproductId = "".obs;

  @override
  void onInit() async {
    super.onInit();
    await getLoanMemberList();
    getProductList();
  }

  getLoanMemberList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl +
            AppURLs.loanMemberList(
                country: "india",
                group: selectedGroup.value,
                search: "",
                Status: "verified",
                isGroup: true)),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final messages = data['message'] as List<dynamic>;
        loanMemberList.value =
            messages.map((e) => LoanMemberListMessage.fromJson(e)).toList();
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

  getCoBorrowerList(String group) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl +
            AppURLs.loanMemberList(
                country: "india",
                group: group,
                search: "",
                Status: "verified",
                isGroup: true)),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final messages = data['message'] as List<dynamic>;
        coBorrowerList.value = messages
            .map((e) => LoanMemberListMessage.fromJson(e))
            .where((m) =>
                m.group == selectedGroup.value &&
                m.memberName != selectedMemberName.value.trim())
            .toList();

        selectedCoBorrower.value = '';
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

  getNomineeList(String group) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl +
            AppURLs.loanMemberList(
                country: "india",
                group: group,
                search: "",
                Status: "verified",
                isGroup: true)),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final messages = data['message'] as List<dynamic>;

        nomineeList.value = messages
            .map((e) => LoanMemberListMessage.fromJson(e))
            .where((m) =>
                m.group == selectedGroup.value &&
                m.memberName != selectedMemberName.value.trim())
            .toList();

        selectednominee.value = '';
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

  getRelationList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.relation),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final messages = data['message'] as List<dynamic>;

        RelationList.value =
            messages.map((e) => RelationListMessage.fromJson(e)).toList();
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

  getProductList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.productList),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final messages = data['message'] as List<dynamic>;
        productList.value =
            messages.map((e) => ProductListResult.fromJson(e)).toList();
        if (productList.isNotEmpty) {
          saveROI.value = productList[0].rateOfInterest?.toString() ?? '';
          saveIsTermLoan.value = productList[0].isTermLoan?.toString() ?? '';
        }
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

  saveLoanMember() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    try {
      final requestBody = {
        "applicant": selectedApplicantId.value,
        "applicant_name": selectedMemberName.value,
        "co_borrower": selectedCoBorrowerId.value,
        "loan_product": selectedproductId.value,
        "loan_amount": double.tryParse(loanAmount.value.text) ?? 0,
        "is_term_loan": int.tryParse(saveIsTermLoan.value) ?? 0,
        "repayment_periods": int.tryParse(periods.value.text) ?? 0,
        "rate_of_interest": double.tryParse(saveROI.value) ?? 0,
        "nominee": selectedNomineeId.value,
        "nominee_relation": selectedRelation.value,
        "description": description.value.text
      };
      final response = await http.post(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.saveLoanCreationMember),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == APIStatusCode.SUCCESS) {
        var json = jsonDecode(response.body);
        CustomSnackBar.show(isIssue: false, message: json["message"]["msg"]);
        Future.delayed(const Duration(milliseconds: 300), () {
          resetForm();
          Get.toNamed(Routes.dashboardScreen);
        });
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

  void resetForm() {
    loanAmount.value.clear();
    periods.value.clear();
    description.value.clear();

    selectedMemberName.value = '';
    selectedCoBorrower.value = '';
    selectednominee.value = '';
    selectedGroup.value = '';
    selectedRelation.value = '';
    selectedProduct.value = '';
    saveROI.value = '';
    saveIsTermLoan.value = '';
    selectedCoBorrowerId.value = '';
    selectedApplicantId.value = '';
    selectedNomineeId.value = '';
  }
}
