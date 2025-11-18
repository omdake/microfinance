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
import 'package:microfinance/models/loan_emi.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class LoanEMIController extends GetxController {
  RxString selectedDate = ''.obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  RxBool isLoading = false.obs;
  RxList<LoanEmiListMessage> loanEMIList = <LoanEmiListMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    getLoanEMIList();
    selectedDate.value = DateFormat('dd-MM-yyyy').format(DateTime.now());
    dateController.value.text = selectedDate.value;
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
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked.first!);

      selectedDate.value = formattedDate;
      dateController.value.text = formattedDate;
    }
    getLoanEMIList(
      selectedDate: selectedDate.value,
      search: search.value.text,
    );
  }

  void onSearchChanged(String query) {
    //groupList.clear();
    getLoanEMIList(
      search: search.value.text,
      selectedDate: selectedDate.value,
    );
  }

  String convertToApiDate(String ddMMyyyy) {
    try {
      DateTime dt = DateFormat('dd-MM-yyyy').parse(ddMMyyyy);
      return DateFormat('yyyy-MM-dd').format(dt);
    } catch (_) {
      return ddMMyyyy;
    }
  }

  void resetSelectedDate() {
    selectedDate.value = DateFormat('dd-MM-yyyy').format(DateTime.now());
    dateController.value.text = selectedDate.value;
    getLoanEMIList(selectedDate: selectedDate.value, search: search.value.text);
  }

  Rx<TextEditingController> search = TextEditingController().obs;

  RxString token = ''.obs;
  getLoanEMIList({String? selectedDate, String? search}) async {
    token.value = await AppPreferences.getToken() ?? '';
    try {
      isLoading.value = true;
      final url = Uri.parse(AppEnvironment.baseUrl +
          AppURLs.LoanEmiList(
            selectedDate: convertToApiDate(selectedDate??''),
            searchText: search,
            sortBy: "",
            sortOrder: "",
            employee: "",
            loanGroup: "",
          ));
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token.value,
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final messages = responseBody['message'] as List<dynamic>;
        loanEMIList.value =
            messages.map((e) => LoanEmiListMessage.fromJson(e)).toList();
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
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
}
