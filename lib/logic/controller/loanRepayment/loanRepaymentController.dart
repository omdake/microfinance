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
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/models/get_Payable_Amount.model.dart';
import 'package:microfinance/models/mode_of_payment.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';
import 'package:microfinance/views/screens/LoanRepayment/loanRepaymentSuccess.dart';

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
  RxList<GetPayableAmountMessage> getPayableAmount = <GetPayableAmountMessage>[].obs;
  RxBool showError = false.obs;
  RxString selectedModeOfPayment = ''.obs;
  RxBool isLoading = false.obs;
  Rx<File?> paymentProofImage = Rx<File?>(null);
  RxBool isPaymentProofImageFocused = false.obs;
  RxString selectedValueDate = ''.obs;
  RxString selectedReferenceDate = ''.obs;
  RxString name = ''.obs;
  RxString loan = ''.obs;
  RxString loanidno = ''.obs;
  RxString applicantId = ''.obs;
  RxBool isFromEMI = false.obs;
  RxBool isFormEdit = false.obs;

  @override
  void onInit() {
    super.onInit();
    String today = DateFormat('dd-MM-yyyy').format(DateTime.now());
    referenceDate.value.text = today;
    selectedReferenceDate.value = today;
    final args = Get.arguments;
    if (args != null) {
      isFromEMI.value = true;
      isFormEdit.value = false;
      name.value = args['applicant'] ?? '';
      loanId.value.text = args['loanId'] ?? '';
      loan.value = args['loan'] ?? '';
      applicantName.value.text = args['memberName'] ?? '';
      //payableAmount.value.text = args['totalPayment']?.toString() ?? '';
      payableAmount.value.text = args['remainingAmount']?.toString() ?? '';
      valueDate.value.text = args['paymentDate'] ?? '';
      String today = DateFormat('dd-MM-yyyy').format(DateTime.now());
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
    RxString selectedDate, {
    DateTime? lastDate,
  }) async {
    DateTime now = DateTime.now();
     DateTime initialDate = now;
      if (controller.text.isNotEmpty) {
        try {
          initialDate = DateFormat('dd-MM-yyyy').parse(controller.text);
        } catch (_) {
          initialDate = now;
        }
      }

    final DateTime endDate =
        lastDate ?? (isFromEMI.value ? now : DateTime(2100));

    List<DateTime?>? picked = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        okButtonTextStyle: const TextStyle(color: Colors.black),
        cancelButtonTextStyle: const TextStyle(color: Colors.black),
        selectedDayHighlightColor: Colors.grey,
        dayTextStyle: const TextStyle(color: Colors.black),
        firstDate: DateTime(2000),
        lastDate: endDate,
        currentDate: initialDate,
      ),
      dialogSize: const Size(350, 400),
      borderRadius: BorderRadius.circular(15),
    );

    if (picked != null && picked.isNotEmpty && picked.first != null) {
      String formatted = DateFormat('dd-MM-yyyy').format(picked.first!);
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
      final url = Uri.parse(AppEnvironment.baseUrl + AppURLs.getmodeOfPayment);
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

        modeOfPaymentList.value =
            messages.map((e) => ModeOfPaymentMessage.fromJson(e)).toList();
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

  getRepaymentAmount() async {
    final token = await AppPreferences.getToken();
    final url = Uri.parse(AppEnvironment.baseUrl + AppURLs.getPayableAmount);
    final requestBody = {
      "against_loan": loanId.value.text,
      "posting_date": convertToApiDate(
        selectedValueDate.value,
      )
    };
    try {
      isLoading.value = true;
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
        body: jsonEncode(requestBody),
      );

      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final message =
            GetPayableAmountMessage.fromJson(responseBody['message']);
        getPayableAmount.value = [message];
        payableAmount.value.text = message.payableAmount?.toString() ?? '0';
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else {
        CustomSnackBar.show(
          isIssue: true,
          message: responseBody['message']['msg'] ?? "Error",
        );
      }
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "POST",
          path: url.toString(),
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
          path: url.toString(),
          dateTime: DateTime.now(),
          data: requestBody,
          response: {"error": e.toString()},
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  String convertToApiDate(String ddMMyyyy) {
    try {
      DateTime dt = DateFormat('dd-MM-yyyy').parse(ddMMyyyy);
      return DateFormat('yyyy-MM-dd').format(dt);
    } catch (_) {
      return ddMMyyyy;
    }
  }

  saveRepayments() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    final uri = Uri.parse(AppEnvironment.baseUrl + AppURLs.saveRepayments);
    final Map<String, String> fields = {
      "name": name.value,
      "against_loan": loan.value,
      "applicant": applicantId.value,
      "repayment_type": "",
      "loan_disbursement": "",
      "loan_adjustment": "",
      "custom_mode_of_payment": selectedModeOfPayment.value,
      "loan_product": "",
      "posting_date": selectedValueDate.value.isNotEmpty
          ? convertToApiDate(selectedValueDate.value)
          : valueDate.value.text,
      "amount_paid": amountPaid.value.text,
      "reference_number": utrNumber.value.text,
      "custom_manual_remarks": remark.value.text,
      "reference_date": convertToApiDate(selectedReferenceDate.value),
      "payable_amount": payableAmount.value.text,
    };

    final List<String> fileNames = [];
    if (paymentProofImage.value != null) {
      fileNames.add(paymentProofImage.value!.path.split('/').last);
    }

    try {
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = token!;
      request.fields.addAll(fields);
      if (paymentProofImage.value != null) {
        final file = await http.MultipartFile.fromPath(
          "custom_payment_proof",
          paymentProofImage.value!.path,
        );
        request.files.add(file);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == APIStatusCode.SUCCESS) {
        loanidno.value = loanId.value.text;
        Get.off(() => LoanRepaymentSuccessScreen(
              crNo: loanidno.value,
              applicantName: applicantName.value.text,
              amount: amountPaid.value.text,
            ));
        // CustomSnackBar.show(
        //     isIssue: false, message: responseBody["message"]["msg"]);
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else {
        final msg = responseBody['message']['msg'] ?? 'Something went wrong';
        CustomSnackBar.show(isIssue: true, message: msg);
      }

      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "POST",
          path: uri.toString(),
          dateTime: DateTime.now(),
          data: {
            ...fields,
            "files": fileNames,
          },
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
          data: {
            ...fields,
            "files": fileNames,
          },
          response: {"error": e.toString()},
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
