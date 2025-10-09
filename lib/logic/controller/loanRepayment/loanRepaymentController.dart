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
import 'package:microfinance/models/mode_of_payment.model.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class LoanRepaymentController extends GetxController {
  Rx<TextEditingController> loanId = TextEditingController().obs;
  Rx<TextEditingController> modeOfPayment = TextEditingController().obs;
  Rx<TextEditingController> applicantName = TextEditingController().obs;
  Rx<TextEditingController> amountPaid = TextEditingController().obs;
  Rx<TextEditingController> valueDate = TextEditingController().obs;
  Rx<TextEditingController> referenceDate = TextEditingController().obs;
  Rx<TextEditingController> payableAmount = TextEditingController().obs;
  Rx<TextEditingController> utrNumber = TextEditingController().obs;
  Rx<TextEditingController> remark = TextEditingController().obs;
  RxList<ModeOfPaymentMessage> modeOfPaymentList = <ModeOfPaymentMessage>[].obs;
  RxString selectedModeOfPayment = ''.obs;
  RxBool isLoading = false.obs;
  Rx<File?> paymentProofImage = Rx<File?>(null);
  RxBool isPaymentProofImageFocused = false.obs;
  RxString selectedValueDate = ''.obs;
  RxString selectedReferenceDate = ''.obs;
  RxString name = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    selectedReferenceDate.value = today;
    referenceDate.value.text = today;
    final args = Get.arguments as Map<String, dynamic>?;
    print("Received arguments: $args");
    if (args != null) {
      loanId.value.text = args['loanId'] ?? "";
      payableAmount.value.text = (args['totalPayment'] ?? 0.0).toString();
      selectedValueDate.value = args['paymentDate'] ?? "";
      valueDate.value.text = selectedValueDate.value;
      applicantName.value.text = args['memberName'] ?? "";
      name.value = args['applicant'] ?? '';
    }

    getModeOfPaymentList();
  }

  Future<void> selectDate(BuildContext context,
      TextEditingController controller, RxString selectedDate) async {
    DateTime initialDate = controller.text.isNotEmpty
        ? DateTime.tryParse(controller.text) ?? DateTime.now()
        : DateTime.now();

    List<DateTime?>? picked = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        okButtonTextStyle: const TextStyle(color: Colors.black),
        cancelButtonTextStyle: const TextStyle(color: Colors.black),
        selectedDayHighlightColor: Colors.grey,
        dayTextStyle: const TextStyle(color: Colors.black),
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        currentDate: initialDate,
      ),
      dialogSize: const Size(350, 400),
      borderRadius: BorderRadius.circular(15),
    );

    if (picked != null && picked.isNotEmpty && picked.first != null) {
      String formatted = DateFormat('yyyy-MM-dd').format(picked.first!);
      controller.text = formatted;
      selectedDate.value = formatted;
    }
  }

  Future<void> pickImage(Rx<File?> imageHolder) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      imageHolder.value = File(result.files.single.path!);
    }
  }

  getModeOfPaymentList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.getmodeOfPayment),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final messages = data['message'] as List<dynamic>;

        modeOfPaymentList.value =
            messages.map((e) => ModeOfPaymentMessage.fromJson(e)).toList();
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

  saveRepayments() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    try {
      var uri = Uri.parse(AppEnvironment.baseUrl + AppURLs.saveRepayments);
      print("Request URL: $uri");
      print("Authorization Token: $token");

      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = token!;

      request.fields.addAll({
        "name": name.value,
        "against_loan": loanId.value.text,
        "applicant": applicantName.value.text,
        "repayment_type": "",
        "loan_disbursement": "",
        "loan_adjustment": "",
        "mode_of_payment": selectedModeOfPayment.value,
        "loan_product": "",
        "value_date": selectedValueDate.value,
        "amount_paid": amountPaid.value.text,
        "reference_number": utrNumber.value.text,
        "manual_remarks": remark.value.text,
        "reference_date": selectedReferenceDate.value,
        "payable_amount": payableAmount.value.text,
      });
      Map<String, Rx<File?>> imageFields = {"payment_proof": paymentProofImage};

      for (var entry in imageFields.entries) {
        if (entry.value.value != null) {
          var file = await http.MultipartFile.fromPath(
            entry.key,
            entry.value.value!.path,
          );
          request.files.add(file);
        }
      }
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

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
