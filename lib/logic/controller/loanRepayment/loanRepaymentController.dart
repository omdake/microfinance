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
import 'package:microfinance/models/get_Payable_Amount.model.dart';
import 'package:microfinance/models/mode_of_payment.model.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
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
  Rx<TextEditingController> groupSearch = TextEditingController().obs;
  RxList<ModeOfPaymentMessage> modeOfPaymentList = <ModeOfPaymentMessage>[].obs;
  RxList<GetPayableAmountMessage> getPayableAmount =
      <GetPayableAmountMessage>[].obs;
  RxString selectedModeOfPayment = ''.obs;
  RxBool isLoading = false.obs;
  Rx<File?> paymentProofImage = Rx<File?>(null);
  RxBool isPaymentProofImageFocused = false.obs;
  RxString selectedValueDate = ''.obs;
  RxString selectedReferenceDate = ''.obs;
  RxString name = ''.obs;
  RxString applicantId = ''.obs;
  RxBool isFromEMI = false.obs;
  RxBool isFormEdit = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      isFromEMI.value = true;
      isFormEdit.value = false;
      name.value = args['applicant'] ?? '';
      loanId.value.text = args['loanId'] ?? '';
      applicantName.value.text = args['memberName'] ?? '';
      payableAmount.value.text = args['totalPayment']?.toString() ?? '';
      valueDate.value.text = args['paymentDate'] ?? '';
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      referenceDate.value.text = today;
      selectedReferenceDate.value = today;
    } else {
      isFromEMI.value = false;
      isFormEdit.value = true;
    }

    getModeOfPaymentList();
  }

  Future<void> selectDate(
    BuildContext context,
    TextEditingController controller,
    RxString selectedDate,
  ) async {
    DateTime now = DateTime.now();
    DateTime initialDate = controller.text.isNotEmpty
        ? DateTime.tryParse(controller.text) ?? now
        : now;

    DateTime lastDate = isFromEMI.value ? now : DateTime(2100);

    List<DateTime?>? picked = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        okButtonTextStyle: const TextStyle(color: Colors.black),
        cancelButtonTextStyle: const TextStyle(color: Colors.black),
        selectedDayHighlightColor: Colors.grey,
        dayTextStyle: const TextStyle(color: Colors.black),
        firstDate: DateTime(2000),
        lastDate: lastDate,
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
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
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

  getRepaymentAmount() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final requestBody = {
        "against_loan": loanId.value.text,
        "posting_date": selectedValueDate.value,
      };
      final response = await http.post(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.getPayableAmount),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final message = GetPayableAmountMessage.fromJson(data['message']);
        getPayableAmount.value = [message];
        payableAmount.value.text = message.payableAmount?.toString() ?? '0';
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
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
    try {
      var uri = Uri.parse(AppEnvironment.baseUrl + AppURLs.saveRepayments);
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = token!;

      request.fields.addAll({
        "name": name.value,
        "against_loan": loanId.value.text,
        "applicant": applicantId.value,
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
        final json = jsonDecode(response.body);
        CustomSnackBar.show(isIssue: false, message: json["message"]["msg"]);
        Get.until((route) => Get.currentRoute == Routes.loanSummaryScreen);
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
      } else {
        final errorJson = jsonDecode(response.body);
        final msg = errorJson['message']['msg'] ?? 'Something went wrong';
        CustomSnackBar.show(isIssue: true, message: msg);
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }
}
