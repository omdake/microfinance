import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_api.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/logic/controller/loanApplication/report_view_page.dart';
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
  RxBool isReadOnly = false.obs;
  RxString loanApplicationId = "".obs;
  RxString selectedPrintFormat = "".obs;
  RxString selectedPrintFormatLabel = "".obs;

  final List<Map<String, String>> printFormatStaticList = [
    {
      "value": "POLICY_APPLY_LETTER",
      "label": "Policy Apply Letter",
    },
    {
      "value": "GROUP_DECLARATION",
      "label": "Group Declaration",
    },
    {
      "value": "GROUP_LOAN_AGREEMENT",
      "label": "Group Loan Agreement",
    },
    {
      "value": "DEMAND_PROMISSORY_NOTE",
      "label": "Demand Promissory Note",
    },
    {
      "value": "SANCTION_LETTER",
      "label": "Sanction Letter",
    },
    {
      "value": "DP_NOTE_WAIVER_LETTER",
      "label": "DP Note Waiver Letter",
    },
    {
      "value": "FACT_SHEET",
      "label": "Fact Sheet",
    },
    {
      "value": "INDIVIDUAL_DECLARATION",
      "label": "Individual Declaration",
    },
    {
      "value": "INDIVIDUAL_LOAN_AGREMEENT",
      "label": "Individual Loan Agremeent For Borrower",
    },
    {
      "value": "INDIVIDUAL_LOAN_AGREMEENT_FOR_CO_BORROWER",
      "label": "Individual Loan Agremeent For Co Borrower",
    },
  ];

  @override
  void onInit() async {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args['applicant'] != null) {
      final applicant = args['applicant'];
      final readOnly = args['isReadOnly'] ?? false;
      isReadOnly.value = readOnly;
      getLoanDataFromArg(applicant as LoanApplicantListResult,
          readOnly: readOnly);
      loanApplicationId.value = applicant.name!;
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

  Future<void> viewReport() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;

    try {
      final url =
          "${AppEnvironment.baseUrl}api/method/ex_loan_management.api.loan_pdf.loan_application_print"
          "?loan_application=${loanApplicationId.value}"
          "&print_format=${Uri.encodeComponent(selectedPrintFormat.value)}";

      final response = await AppAPIs.dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            "Authorization": token!,
            "Accept": "application/pdf",
          },
        ),
      );

      Get.to(() => PdfPreviewPage(
            pdfBytes: response.data,
            fileName: "${loanApplicationId.value} ${selectedPrintFormatLabel.value}.pdf",
          ));
    } catch (e) {
      print("PDF Preview Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
