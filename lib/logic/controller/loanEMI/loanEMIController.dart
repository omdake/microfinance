import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/models/loan_emi.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class LoanEMIController extends GetxController {
  RxString selectedDate = ''.obs;

  RxBool isLoading = false.obs;
  RxList<LoanEmiListMessage> loanEMIList = <LoanEmiListMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    selectedDate.value = DateFormat('yyyy-MM-dd').format(DateTime.now());
    getLoanEMIList();
  }

  Future<void> selectDate(BuildContext context,
      {required bool isSelectedDate}) async {
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
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked.first!);

      selectedDate.value = formattedDate;
    }

    getLoanEMIList(
      selectedDate: selectedDate.value,
    );
  }

  getLoanEMIList({
    String? selectedDate,
  }) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final url = AppEnvironment.baseUrl +
          AppURLs.LoanEmiList(
            selectedDate: selectedDate ?? "",
            searchText: "",
            sortBy: "",
            sortOrder: "",
            employee: "",
            loanGroup: "",
          );

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final messages = data['message'] as List<dynamic>;
        loanEMIList.value =
            messages.map((e) => LoanEmiListMessage.fromJson(e)).toList();
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
      }else {
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
