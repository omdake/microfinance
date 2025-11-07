import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/models/loan_disbursement.model.dart';
import 'package:microfinance/models/loan_schedule.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class LoanDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isFormEdit = false.obs;
  RxInt selectedIndex = 0.obs;

  Rx<LoanDisbursementResult> loanDisbursement = LoanDisbursementResult().obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  RxBool get isSelected => (selectedIndex.value == 0).obs;

  Rx<TextEditingController> againstLoan = TextEditingController().obs;
  Rx<TextEditingController> applicant = TextEditingController().obs;
  Rx<TextEditingController> sanctionedLoanAmount = TextEditingController().obs;
  Rx<TextEditingController> currentDisbursedAmount =
      TextEditingController().obs;
  Rx<TextEditingController> repaymentFrequency = TextEditingController().obs;
  Rx<TextEditingController> applicantType = TextEditingController().obs;
  Rx<TextEditingController> repaymentMethod = TextEditingController().obs;
  Rx<TextEditingController> monthlyRepaymentAmount =
      TextEditingController().obs;
  Rx<TextEditingController> repaymentStartDate = TextEditingController().obs;
  Rx<TextEditingController> disbursementDate = TextEditingController().obs;
  Rx<TextEditingController> disbursedAmount = TextEditingController().obs;
  Rx<TextEditingController> brokenPeriodInterestDays =
      TextEditingController().obs;
  Rx<TextEditingController> brokenPeriodInterest = TextEditingController().obs;
  Rx<TextEditingController> bPIAmountDifference = TextEditingController().obs;
  Rx<TextEditingController> principalAmountPaid = TextEditingController().obs;
  Rx<TextEditingController> disbursementAccount = TextEditingController().obs;
  Rx<TextEditingController> loanAccount = TextEditingController().obs;
  Rx<TextEditingController> costCenter = TextEditingController().obs;
  Rx<TextEditingController> daysPastDue = TextEditingController().obs;
  Rx<TextEditingController> status = TextEditingController().obs;
  RxString loanId = "".obs;
  RxList<RepaymentSchedule> repaymentSchedule = <RepaymentSchedule>[].obs;
  RxList<ScheduleResult> repaymentSchedulecard = <ScheduleResult>[].obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      final loanData = Get.arguments as LoanDisbursementResult;
      loanDisbursement.value = loanData;
      if (loanData.againstLoan != null) {
        getLoanScheduleList(loanId: loanData.againstLoan!);
      }
    }
  }

  getLoanScheduleList({required String loanId}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;

      final url = Uri.parse(AppEnvironment.baseUrl +
          AppURLs.getLoanPaymentSchedule(loanId: loanId));

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        //final Map<String, dynamic> data = jsonDecode(response.body);
        final messages = responseBody['message'] as List<dynamic>;

        if (messages.isNotEmpty) {
          final repaymentList =
              messages[0]['repayment_schedule'] as List<dynamic>;
          repaymentSchedule.value =
              repaymentList.map((e) => RepaymentSchedule.fromJson(e)).toList();

          repaymentSchedulecard.value = [ScheduleResult.fromJson(messages[0])];
        }
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
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

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    List<DateTime?>? picked = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        okButtonTextStyle: const TextStyle(color: Colors.black),
        cancelButtonTextStyle: const TextStyle(color: Colors.black),
        selectedDayHighlightColor: Colors.grey,
        dayTextStyle: const TextStyle(color: Colors.black),
      ),
      dialogSize: const Size(350, 400),
      borderRadius: BorderRadius.circular(15),
    );

    if (picked != null && picked.isNotEmpty && picked.first != null) {
      String formatted = DateFormat('yyyy-MM-dd').format(picked.first!);
      controller.text = formatted;
    }
  }
}
