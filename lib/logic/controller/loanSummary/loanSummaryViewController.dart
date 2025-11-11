import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:microfinance/models/loan_list.model.dart';
import 'package:microfinance/models/loan_repayment_model.dart';

class LoanSummaryViewController extends GetxController {
  Rx<TextEditingController> loanId = TextEditingController().obs;
  Rx<TextEditingController> modeOfPayment = TextEditingController().obs;
  Rx<TextEditingController> applicantName = TextEditingController().obs;
  Rx<TextEditingController> amountPaid = TextEditingController().obs;
  Rx<TextEditingController> valueDate = TextEditingController().obs;
  Rx<TextEditingController> referenceDate = TextEditingController().obs;
  Rx<TextEditingController> payableAmount = TextEditingController().obs;
  Rx<TextEditingController> utrNumber = TextEditingController().obs;
  Rx<TextEditingController> remark = TextEditingController().obs;
  RxString selectedApplicantId = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isFormEdit = false.obs;
  RxList<LoanListMessage> loantList = <LoanListMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args['applicant'] != null) {
      final applicant = args['applicant'];
      final readOnly = args['isReadOnly'] ?? false;
      getLoanDataFromArg(applicant as RepaymentListResult, readOnly: readOnly);
    }
  }

  getLoanDataFromArg(RepaymentListResult applicant,
      {bool readOnly = false}) async {
    loanId.value.text = applicant.againstLoanLoanId ?? '';
    applicantName.value.text = applicant.applicantMemberName ?? '';
    valueDate.value.text = applicant.valueDate != null
        ? DateFormat('yyyy-MM-dd').format(applicant.valueDate!)
        : '';
    referenceDate.value.text = applicant.dueDate != null
        ? DateFormat('yyyy-MM-dd').format(applicant.valueDate!)
        : '';
    amountPaid.value.text = applicant.amountPaid?.toString() ?? '';
    payableAmount.value.text = applicant.payableAmount?.toString() ?? '';
    remark.value.text = applicant.manualRemarks?.toString() ?? '';
    selectedApplicantId.value = applicant.applicant ?? '';
    modeOfPayment.value.text = applicant.modeOfPayment?.toString() ?? '';
    utrNumber.value.text = applicant.referenceNumber?.toString() ?? '';
  }
}
