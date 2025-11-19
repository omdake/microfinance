import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
  Rx<File?> paymentProofImage = Rx<File?>(null);
   RxString paymentProofUrl = ''.obs;
  RxString paymentProofImageUrl = ''.obs;
  RxBool isPaymentProofImageFocused = false.obs;
  RxString selectedApplicantId = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isFormEdit = false.obs;
  RxList<LoanListMessage> loantList = <LoanListMessage>[].obs;
  Future<void> pickImage(Rx<File?> imageHolder) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      imageHolder.value = File(result.files.single.path!);
    }
  }

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
     if (applicant.paymentProof != null && applicant.paymentProof!.isNotEmpty) {
      if (applicant.paymentProof!.startsWith('http')) {
        paymentProofUrl.value = applicant.paymentProof!;
        paymentProofImage.value = null;
      }
    } else {
      paymentProofImage.value = null;
      paymentProofUrl.value = '';
    }
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
