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
import 'package:microfinance/models/employee.model.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class CollectionInHandController extends GetxController {
  Rx<TextEditingController> employee = TextEditingController().obs;
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> employeeName = TextEditingController().obs;
  Rx<TextEditingController> amount = TextEditingController().obs;
  Rx<TextEditingController> bankAmount = TextEditingController().obs;
  Rx<TextEditingController> bankName = TextEditingController().obs;
  Rx<TextEditingController> postingDate = TextEditingController(
          text: DateFormat('yyyy-MM-dd').format(DateTime.now()))
      .obs;
  Rx<TextEditingController> amountgivenTo = TextEditingController().obs;
  Rx<TextEditingController> givenTo = TextEditingController().obs;
  RxString status = ''.obs;

  Rx<File?> paymentProofImage = Rx<File?>(null);
  RxString paymentProofImageUrl = ''.obs;
  RxBool isPaymentProofImageFocused = false.obs;
  RxBool isLoading = false.obs;
  RxInt page = 1.obs;
  RxBool isFormEdit = false.obs;
  RxBool isReadOnly = false.obs;
  RxBool hasNextPage = true.obs;
  RxString selectedType = ''.obs;
  RxString loggedInUser = ''.obs;
  RxString paymentProofUrl = ''.obs;

  final List<String> giventoList = ["Employee", "Bank"];
  RxString selectedGivenTo = ''.obs;
  RxString selectedamountGivenTo = ''.obs;
  RxString selectedAmountGivenToEmployeeId = ''.obs;

  RxList<CollectionInhandResult> collectionInHandList =
      <CollectionInhandResult>[].obs;
  RxList<Employee> employeeList = <Employee>[].obs;
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
      loggedInUser.value = empId;
    }
    if (empName != null && empName.isNotEmpty) {
      employeeName.value.text = empName;
    }
    final args = Get.arguments;
    if (args != null && args['applicant'] != null) {
      getLoanDataFromArg(args['applicant'] as CollectionInhandResult,
          readOnly: args['isReadOnly'] ?? false);
    } else {
      resetForm();
    }
  }

  saveCollectionInHand() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    try {
      var uri =
          Uri.parse(AppEnvironment.baseUrl + AppURLs.saveCollectionInHand);
      var request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = token!;

      request.fields.addAll({
        "employee": employee.value.text,
        "given_to": selectedGivenTo.value,
        "amount": amount.value.text,
        "posting_date": postingDate.value.text,
      });
      if (selectedGivenTo.value == "Employee") {
        request.fields["amount_given_emp"] = selectedamountGivenTo.value;
      } else if (selectedGivenTo.value == "Bank") {
        request.fields["description"] = bankAmount.value.text;
      }

      Map<String, Rx<File?>> imageFields = {
        'payment_proof': paymentProofImage,
      };

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
        Get.offNamed(Routes.collectionInHand);
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
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

  // getLoanDataFromArg(CollectionInhandResult applicant,
  //     {bool readOnly = false}) async {
  //   isReadOnly.value = readOnly;
  //   status.value = applicant.status ?? '';
  //   name.value.text = applicant.name ?? '';
  //   employee.value.text = applicant.employee ?? '';
  //   employeeName.value.text = applicant.employeeEmployeeName ?? '';
  //   amount.value.text = applicant.amount?.toString() ?? '';
  //   givenTo.value.text = applicant.givenTo ?? '';
  //   amountgivenTo.value.text = applicant.amountGivenEmp ?? '';
  //   bankName.value.text = applicant.description ?? '';
  //   if (applicant.paymentProof != null && applicant.paymentProof!.isNotEmpty) {
  //     if (applicant.paymentProof!.startsWith('http')) {
  //       paymentProofUrl.value = applicant.paymentProof!;
  //       paymentProofImage.value = null;
  //     }
  //   } else {
  //     paymentProofImage.value = null;
  //     paymentProofUrl.value = '';
  //   }
  //   postingDate.value.text = applicant.postingDate != null
  //       ? DateFormat('yyyy-MM-dd').format(applicant.postingDate!)
  //       : '';
  // }

  getLoanDataFromArg(CollectionInhandResult applicant, {bool readOnly = false}) async {
  isReadOnly.value = readOnly;
  status.value = applicant.status ?? '';
  name.value.text = applicant.name ?? '';
  employee.value.text = applicant.employee ?? '';
  employeeName.value.text = applicant.employeeEmployeeName ?? '';
  amount.value.text = applicant.amount?.toString() ?? '';
  givenTo.value.text = applicant.givenTo ?? '';
  amountgivenTo.value.text = applicant.amountGivenEmp ?? '';
  bankName.value.text = applicant.description ?? '';

  if (applicant.paymentProof != null && applicant.paymentProof!.isNotEmpty) {
    if (applicant.paymentProof!.startsWith('http')) {
      paymentProofUrl.value = applicant.paymentProof!;
      paymentProofImage.value = null;
    }
  } else {
    paymentProofImage.value = null;
    paymentProofUrl.value = '';
  }

  postingDate.value.text = applicant.postingDate != null
      ? DateFormat('yyyy-MM-dd').format(applicant.postingDate!)
      : '';

  // ✅ Debug print everything clearly
  print("📋 --- Loan Data Loaded ---");
  print("Status: ${status.value}");
  print("Name: ${name.value.text}");
  print("Employee: ${employee.value.text}");
  print("Employee Name: ${employeeName.value.text}");
  print("Amount: ${amount.value.text}");
  print("Given To: ${givenTo.value.text}");
  print("Amount Given To Emp: ${amountgivenTo.value.text}");
  print("Bank Name / Description: ${bankName.value.text}");
  print("Payment Proof URL: ${paymentProofUrl.value}");
  print("Posting Date: ${postingDate.value.text}");
  print("Read Only: $readOnly");
  print("-----------------------------");
}


  getemployeeList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.getemployeeList),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final messages = data['message'] as List<dynamic>;
        employeeList.value = messages.map((e) => Employee.fromJson(e)).toList();
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

  approve() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    try {
      final requestBody = {"name": name.value.text, "status": "Approved"};
      final response = await http.post(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.approveRejecte),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        status.value = "Approved";
        CustomSnackBar.show(isIssue: false, message: json["message"]);
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
      } else {
        var json = jsonDecode(response.body);
        CustomSnackBar.show(isIssue: true, message: json["message"]["msg"]);
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  rejecte() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    try {
      final requestBody = {"name": name.value.text, "status": "Rejected"};
      final response = await http.post(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.approveRejecte),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        status.value = "Rejected";
        CustomSnackBar.show(isIssue: false, message: json["message"]);
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
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
    amount.value.clear();
    amountgivenTo.value.clear();
    postingDate.value.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    isReadOnly.value = false;
    isFormEdit.value = false;
  }
}
