import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/api_status_code.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/models/loan_applicant_list.model.dart';
import 'package:microfinance/models/loan_memberList_aspergroup.model.dart';
import 'package:microfinance/models/loan_memeber_list.model.dart';
import 'package:microfinance/models/nominee_relation.model.dart';
import 'package:microfinance/models/product_list.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class LoanApplicationController extends GetxController {
  RxList<LoanMemberListResult> loanMemberList = <LoanMemberListResult>[].obs;
  RxList<LoanMemberListAsPerGroupMessage> loanMemberAsPerGroup =
      <LoanMemberListAsPerGroupMessage>[].obs;
  RxList<LoanMemberDropdownListMessage> coBorrowerList =
      <LoanMemberDropdownListMessage>[].obs;
  RxList<LoanMemberDropdownListMessage> nomineeList =
      <LoanMemberDropdownListMessage>[].obs;
  RxList<RelationListMessage> RelationList = <RelationListMessage>[].obs;
  RxList<ProductListResult> productList = <ProductListResult>[].obs;
  Rx<TextEditingController> loanAmount = TextEditingController().obs;
  Rx<TextEditingController> periods = TextEditingController().obs;
  Rx<TextEditingController> group = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  Rx<TextEditingController> loanApplicantSearchController =
      TextEditingController().obs;
  Rx<TextEditingController> coborrowerSearchController =
      TextEditingController().obs;
  Rx<TextEditingController> nomineeSearchController =
      TextEditingController().obs;
  RxList<LoanApplicantListResult> loanApplicantList =
      <LoanApplicantListResult>[].obs;
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
  RxString selectedApplicant = "".obs;
  RxBool isReadOnly = false.obs;
  RxBool isFormEdit = false.obs;

  @override
  void onInit() async {
    super.onInit();

    await getLoanMemberList();
    getProductList();
    getAplicantList();
  }

  getLoanMemberList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;

      final url = Uri.parse(AppEnvironment.baseUrl +
          AppURLs.getloanMemberListAsPerGroupAssignment);
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
        loanMemberAsPerGroup.value = messages
            .map((e) => LoanMemberListAsPerGroupMessage.fromJson(e))
            .toList();
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
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

  getCoBorrowerList(String group) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;

      final url = Uri.parse(AppEnvironment.baseUrl +
          AppURLs.loanMemberDropdownList(
            country: "india",
            group: group,
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
        coBorrowerList.value = messages
            .map((e) => LoanMemberDropdownListMessage.fromJson(e))
            .where((m) =>
                m.group == selectedGroup.value &&
                m.memberName != selectedMemberName.value.trim())
            .toList();

        selectedCoBorrower.value = '';
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
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
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  getNomineeList(
    String group,
  ) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;

      final url = Uri.parse(AppEnvironment.baseUrl +
          AppURLs.loanMemberDropdownList(
            country: "india",
            group: group,
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

        nomineeList.value = messages
            .map((e) => LoanMemberDropdownListMessage.fromJson(e))
            .where((m) =>
                m.group == selectedGroup.value &&
                m.memberName != selectedMemberName.value.trim())
            .toList();

        selectednominee.value = '';
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else {
        final err = jsonDecode(response.body);
        CustomSnackBar.show(isIssue: true, message: err['message']?['msg']);
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
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  getRelationList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final url = Uri.parse(AppEnvironment.baseUrl + AppURLs.relation);
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
        RelationList.value =
            messages.map((e) => RelationListMessage.fromJson(e)).toList();
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else {
        final err = jsonDecode(response.body);
        CustomSnackBar.show(isIssue: true, message: err['message']?['msg']);
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
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  getProductList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final url = Uri.parse(AppEnvironment.baseUrl + AppURLs.productList);
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
        productList.value =
            messages.map((e) => ProductListResult.fromJson(e)).toList();
        if (productList.isNotEmpty) {
          saveROI.value = productList[0].rateOfInterest?.toString() ?? '';
          saveIsTermLoan.value = productList[0].isTermLoan?.toString() ?? '';
        }
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
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
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  saveLoanMember() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    final uri =
        Uri.parse(AppEnvironment.baseUrl + AppURLs.saveLoanCreationMember);
    final Map<String, dynamic> requestBody = {
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
        // CustomSnackBar.show(
        //     isIssue: false, message: responseBody["message"]["msg"]);
        Future.delayed(const Duration(milliseconds: 300), () {
          resetForm();
        });
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
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

  getAplicantList({int? page}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;

      final url = Uri.parse(
          AppEnvironment.baseUrl + AppURLs.getApplicantList(page: page));
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final message = responseBody['message'];
        final results = message['results'] as List<dynamic>;

        loanApplicantList.value =
            results.map((e) => LoanApplicantListResult.fromJson(e)).toList();
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
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
