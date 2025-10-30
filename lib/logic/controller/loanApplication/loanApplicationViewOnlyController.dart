import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/models/loan_applicant_list.model.dart';

class LoanApplicationViewOnlyController extends GetxController {
  Rx<TextEditingController> applicantName = TextEditingController().obs;
  Rx<TextEditingController> coBorrower = TextEditingController().obs;
  Rx<TextEditingController> loanProduct = TextEditingController().obs;
  Rx<TextEditingController> period = TextEditingController().obs;
  Rx<TextEditingController> nominee = TextEditingController().obs;
  Rx<TextEditingController> relation = TextEditingController().obs;
  Rx<TextEditingController> loanAmount = TextEditingController().obs;
  Rx<TextEditingController> periods = TextEditingController().obs;
  Rx<TextEditingController> description = TextEditingController().obs;
  Rx<TextEditingController> group = TextEditingController().obs;
  RxBool isLoading = false.obs;
  RxBool isFormEdit = false.obs;
  @override
  void onInit() async {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args['applicant'] != null) {
      final applicant = args['applicant'];
      final readOnly = args['isReadOnly'] ?? false;
      getLoanDataFromArg(applicant as LoanApplicantListResult,
          readOnly: readOnly);
    }
  }

  getLoanDataFromArg(LoanApplicantListResult applicant,
      {bool readOnly = true}) async {
    loanAmount.value.text = applicant.loanAmount?.toString() ?? '';
    periods.value.text = applicant.repaymentPeriods?.toString() ?? '';
    description.value.text = applicant.description ?? '';
    applicantName.value.text = applicant.applicantName ?? '';
    coBorrower.value.text = applicant.coBorrowerMemberName ?? '';
    loanProduct.value.text = applicant.loanProduct ?? '';
    nominee.value.text = applicant.nomineeMemberName ?? '';
    relation.value.text = applicant.nomineeRelation ?? '';
    group.value.text = applicant.group ?? '';
  }
}
