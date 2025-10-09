import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:microfinance/models/loan_disbursement.model.dart';

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
  Rx<TextEditingController> company = TextEditingController().obs;
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
  RxString user = "".obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      loanDisbursement.value = Get.arguments as LoanDisbursementResult;
    }
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
