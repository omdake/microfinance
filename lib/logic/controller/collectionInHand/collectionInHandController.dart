import 'dart:convert';
import 'dart:io';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/api_status_code.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/models/collection_in_hand.model.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class CollectionInHandController extends GetxController {
  Rx<TextEditingController> employee = TextEditingController().obs;
  Rx<TextEditingController> employeeName = TextEditingController().obs;
  Rx<TextEditingController> amount = TextEditingController().obs;
  Rx<TextEditingController> postingDate = TextEditingController(
          text: DateFormat('yyyy-MM-dd').format(DateTime.now()))
      .obs;
  Rx<TextEditingController> amountgivenTo = TextEditingController().obs;
  Rx<File?> paymentProofImage = Rx<File?>(null);
  RxBool isPaymentProofImageFocused = false.obs;
  RxBool isLoading = false.obs;
  RxInt page = 1.obs;
  RxBool isFormEdit = false.obs;

  RxList<CollectionInhandResult> collectionInHandList =
      <CollectionInhandResult>[].obs;

  Future<void> pickImage(Rx<File?> imageHolder) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      imageHolder.value = File(result.files.single.path!);
    }
  }

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime today = DateTime.now();

    DateTime initialDate = today;
    if (controller.text.isNotEmpty) {
      initialDate = DateTime.tryParse(controller.text) ?? today;
    }

    List<DateTime?>? picked = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        okButtonTextStyle: const TextStyle(color: Colors.black),
        cancelButtonTextStyle: const TextStyle(color: Colors.black),
        selectedDayHighlightColor: Colors.grey,
        dayTextStyle: const TextStyle(color: Colors.black),
        selectableDayPredicate: (day) => !day.isAfter(today),
      ),
      value: [initialDate],
      dialogSize: const Size(350, 400),
      borderRadius: BorderRadius.circular(15),
    );

    if (picked != null && picked.isNotEmpty && picked.first != null) {
      String formatted = DateFormat('yyyy-MM-dd').format(picked.first!);
      controller.text = formatted;
    }
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
    getCollectionInHandList(page: page.value, empName: employee.value.text);
  }

  getCollectionInHandList({required int page, String? empName}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl +
            AppURLs.getCollectionInHandlist(page: page, employee: empName)),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['message']['results'] as List<dynamic>;

        collectionInHandList.value =
            results.map((e) => CollectionInhandResult.fromJson(e)).toList();
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

  saveCollectionInHand() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    try {
      final requestBody = {
        "employee": employee.value.text,
        "given_to": amountgivenTo.value.text,
        "amount": amount.value.text,
        "posting_date": postingDate.value.text,
      };
      final response = await http.post(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.saveCollectionInHand),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
        body: jsonEncode(requestBody),
      );
      print("......................${requestBody}");
      print(">>>>>>>>>>>>>>>>>>>>${response.body}");
      if (response.statusCode == APIStatusCode.SUCCESS) {
        var json = jsonDecode(response.body);
        CustomSnackBar.show(isIssue: false, message: json["message"]["msg"]);
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
