import 'dart:convert';
import 'dart:io';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/models/collection_in_hand.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class CollectionInHandListController extends GetxController {
  Rx<TextEditingController> employee = TextEditingController().obs;
  Rx<TextEditingController> employeeName = TextEditingController().obs;
  Rx<TextEditingController> amount = TextEditingController().obs;
  Rx<TextEditingController> postingDate = TextEditingController(
          text: DateFormat('yyyy-MM-dd').format(DateTime.now()))
      .obs;
  Rx<TextEditingController> amountgivenTo = TextEditingController().obs;
  Rx<TextEditingController> Status = TextEditingController().obs;
  Rx<File?> paymentProofImage = Rx<File?>(null);
  RxBool isPaymentProofImageFocused = false.obs;
  RxBool isLoading = false.obs;
  RxInt page = 1.obs;
  RxBool isFormEdit = false.obs;
  RxBool isReadOnly = false.obs;
  RxBool hasNextPage = true.obs;
  RxString selectedDateText = ''.obs;
  RxInt selectedIndex = 0.obs;
  final ScrollController scrollController = ScrollController();
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  RxBool isStatusSearching = false.obs;
  RxList<CollectionInhandResult> collectionInHandList =
      <CollectionInhandResult>[].obs;
  Rx<TextEditingController> selectedDateController =
      TextEditingController().obs;

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
      selectedDateController.value.text = formattedDate;
      selectedDateText.value = formattedDate;

      page.value = 1;
      collectionInHandList.clear();
      getpendingRequestList(
        page: page.value,
        empId: employee.value.text,
      );
    }
  }

  void clearSelectedDate() {
    selectedDateText.value = '';
    selectedDateController.value.clear();
    page.value = 1;
    collectionInHandList.clear();
    getpendingRequestList(
      page: page.value,
      empId: employee.value.text,
    );
  }

  void onSearchChanged(String query) {
    page.value = 1;
    collectionInHandList.clear();
    getpendingRequestList(page: page.value, empId: employee.value.text);
  }

  @override
  void onInit() async {
    super.onInit();
    final empId = await AppPreferences.getEmpId();
    final empName = await AppPreferences.getEmpName();
    if (empId != null && empId.isNotEmpty) {
      employee.value.text = empId;
    }
    if (empName != null && empName.isNotEmpty) {
      employeeName.value.text = empName;
    }
    getpendingRequestList(page: page.value, empId: employee.value.text);
  }

  getloadData() {
    page.value = 1;
    collectionInHandList.clear();
    getpendingRequestList(page: page.value, empId: employee.value.text);
  }

  getLoadMoreData() {
    if (!hasNextPage.value) return;
    page.value += 1;
    getpendingRequestList(page: page.value, empId: employee.value.text);
  }

  getpendingRequestList({required int page, String? empId}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final url = Uri.parse(AppEnvironment.baseUrl +
          AppURLs.getCollectionInHandlist(
              page: page,
              employee: empId,
              pageSize: 10,
              isPagination: true,
              date: selectedDateController.value.text,
              status: Status.value.text));
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final results = responseBody['message']?['results'] as List<dynamic>;
        final newItems =
            results.map((e) => CollectionInhandResult.fromJson(e)).toList();

        if (page == 1) {
          collectionInHandList.value = newItems;
        } else {
          collectionInHandList.addAll(newItems);
        }

        hasNextPage.value = responseBody['message']?['next'] != null;
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
}
