import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/nav_bar.dart';
import 'package:microfinance/common_widgets/uploadFile.dart';

import 'package:microfinance/logic/controller/loanRepayment/loanRepaymentController.dart';
import 'package:microfinance/logic/controller/loanSummary/loanSummaryController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';
import 'package:microfinance/views/screens/LoanRepayment/loanRepaymentSuccess.dart';

class LoanRepaymentScreen extends StatelessWidget {
  LoanRepaymentScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final LoanRepaymentController controller = Get.put(LoanRepaymentController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          elevation: 0,
          title: Text(
            " Loan Summary",
            style: TextStyles.appbartitle,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.offAllNamed(Routes.loanSummaryScreen);
              },
              icon: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              )),
        ),
        bottomNavigationBar: const CustomBottomNavBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Center(
                    child: Text(
                      "NEW LOAN REPAYMENT",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Roboto-Regular",
                        color: Color(0xFF050708),
                      ),
                    ),
                  ),
                ),
                C10(),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    paddingWidget([
                                      const LabelsWithMark(
                                          label: "Loan Id", isRequired: true),
                                      Obx(() {
                                        final LoanSummaryController?
                                            loanSummaryController =
                                            Get.isRegistered<
                                                    LoanSummaryController>()
                                                ? Get.find<
                                                    LoanSummaryController>()
                                                : null;
                                        final loanlist =
                                            loanSummaryController?.loantList ??
                                                [];
                                        if (loanlist.isNotEmpty) {
                                          return DropdownButtonFormField2<
                                              String>(
                                            value: controller
                                                    .loanId.value.text.isEmpty
                                                ? null
                                                : controller.loanId.value.text,
                                            items: loanlist.map((loan) {
                                              return DropdownMenuItem<String>(
                                                value: loan.name!,
                                                child: Text(loan.name!),
                                              );
                                            }).toList(),
                                            dropdownSearchData:
                                                DropdownSearchData(
                                              searchController:
                                                  controller.groupSearch.value,
                                              searchInnerWidgetHeight: 50,
                                              searchInnerWidget: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: TextFormField(
                                                  cursorColor: Colors.black,
                                                  style: TextStyles
                                                      .textfieldTextStyle,
                                                  controller: controller
                                                      .groupSearch.value,
                                                  decoration:
                                                      TextFieldDecoration
                                                          .textfieldDecoration(
                                                    sufficIconOntap: () {},
                                                    sufficIcon: Icons.search,
                                                    hint: 'Search loan Id...',
                                                  ),
                                                ),
                                              ),
                                              searchMatchFn:
                                                  (item, searchValue) {
                                                if (searchValue.trim().length <
                                                    3) {
                                                  return true;
                                                }
                                                return (item.child is Text &&
                                                    (item.child as Text)
                                                        .data!
                                                        .toLowerCase()
                                                        .contains(searchValue
                                                            .toLowerCase()));
                                              },
                                            ),
                                            onMenuStateChange: (isOpen) {
                                              if (!isOpen) {
                                                controller.groupSearch.value
                                                    .clear();
                                              }
                                            },
                                            onChanged: (value) {
                                              for (var loan in loanlist) {
                                                if (loan.name == value) {
                                                  controller.applicantName.value
                                                          .text =
                                                      loan.applicantName!;
                                                  controller.loanId.value.text =
                                                      loan.name!;
                                                  controller.valueDate.value
                                                      .text = '';
                                                  controller.selectedValueDate
                                                      .value = '';
                                                  controller.payableAmount.value
                                                      .text = '';
                                                }
                                              }
                                            },
                                            hint: Text(
                                              "Select A Loan Id",
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontFamily: "Roboto-Regular",
                                                fontSize: 12,
                                              ),
                                            ),
                                            style:
                                                TextStyles.textfieldTextStyle,
                                            dropdownStyleData:
                                                DropdownStyleData(
                                                    maxHeight: 500),
                                            decoration: TextFieldDecoration
                                                    .textfieldDecoration(
                                                        hint: '')
                                                .copyWith(
                                              contentPadding:
                                                  EdgeInsets.all(-5),
                                            ),
                                            validator: (value) =>
                                                value == null ||
                                                        value.trim().isEmpty
                                                    ? 'Loan ID is required'
                                                    : null,
                                          );
                                        } else {
                                          return TextFormField(
                                            controller: controller.loanId.value,
                                            cursorColor: AppColors.primary,
                                            enabled:
                                                controller.isFormEdit.value,
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            validator: (value) =>
                                                requiredValidator(value!),
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            keyboardType: TextInputType.name,
                                            style:
                                                TextStyles.textfieldTextStyle,
                                            decoration: TextFieldDecoration
                                                .textfieldDecoration(
                                              hint: "Loan ID",
                                            ).copyWith(
                                              filled: true,
                                              fillColor:
                                                  controller.isFormEdit.value
                                                      ? Colors.white
                                                      : Colors.grey.shade200,
                                            ),
                                          );
                                        }
                                      }),
                                    ]),
                                    C10(),
                                    paddingWidget([
                                      const LabelsWithMark(
                                          label: "Value Date",
                                          isRequired: true),
                                      Obx(
                                        () => TextFormField(
                                          controller:
                                              controller.valueDate.value,
                                          cursorColor: AppColors.primary,
                                          readOnly: true,
                                          onTap: () async {
                                            await controller.selectDate(
                                                context,
                                                controller.valueDate.value,
                                                controller.selectedValueDate);
                                            if (controller.loanId.value.text
                                                    .isNotEmpty &&
                                                controller.selectedValueDate
                                                    .value.isNotEmpty) {
                                              controller.getRepaymentAmount();
                                            }
                                          },
                                          validator: (value) =>
                                              requiredValidator(value!),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style: TextStyles.textfieldTextStyle,
                                          decoration: TextFieldDecoration
                                              .textfieldDecorationicon(
                                            hint: "Value Date",
                                            sufficIcon: Icons.calendar_today,
                                            sufficIconOntap: () =>
                                                controller.selectDate(
                                                    context,
                                                    controller.valueDate.value,
                                                    controller
                                                        .selectedValueDate),
                                          ).copyWith(
                                            filled: true,
                                            fillColor:
                                                controller.isFormEdit.value
                                                    ? Colors.white
                                                    : Colors.grey.shade200,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    C10(),
                                    paddingWidget([
                                      const LabelsWithMark(
                                          label: "Applicant Name",
                                          isRequired: true),
                                      TextFormField(
                                        controller:
                                            controller.applicantName.value,
                                        enabled: controller.isFormEdit.value,
                                        cursorColor: AppColors.primary,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        validator: (value) =>
                                            requiredValidator(value!),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.name,
                                        style: TextStyles.textfieldTextStyle,
                                        decoration: TextFieldDecoration
                                            .textfieldDecoration(
                                          hint: "Applicant Name ",
                                        ).copyWith(
                                          filled: true,
                                          fillColor: controller.isFormEdit.value
                                              ? Colors.white
                                              : Colors.grey.shade200,
                                        ),
                                      ),
                                    ]),
                                    C10(),
                                    paddingWidget([
                                      const LabelsWithMark(
                                          label: "Payable Amount",
                                          isRequired: true),
                                      TextFormField(
                                        controller:
                                            controller.payableAmount.value,
                                        cursorColor: AppColors.primary,
                                        enabled: controller.isFormEdit.value,
                                        readOnly: true,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        validator: (value) =>
                                            requiredValidator(value!),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.name,
                                        style: TextStyles.textfieldTextStyle,
                                        decoration: TextFieldDecoration
                                            .textfieldDecoration(
                                          hint: "Payable Amount",
                                        ).copyWith(
                                          filled: true,
                                          fillColor: controller.isFormEdit.value
                                              ? Colors.white
                                              : Colors.grey.shade200,
                                        ),
                                      ),
                                    ]),
                                    C10(),
                                    paddingWidget([
                                      LabelsWithMark(
                                          label: "Mode Of Payment",
                                          isRequired: true),
                                      Obx(() {
                                        return DropdownButtonFormField<String>(
                                          value: controller
                                                  .selectedModeOfPayment
                                                  .value
                                                  .isEmpty
                                              ? null
                                              : controller
                                                  .selectedModeOfPayment.value,
                                          items: controller.modeOfPaymentList
                                              .map((e) {
                                            return DropdownMenuItem(
                                              value: e.name.toString(),
                                              child: Text(e.name.toString()),
                                            );
                                          }).toList(),
                                          style: TextStyles.textfieldTextStyle,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: TextFieldDecoration
                                              .textfieldDecoration(
                                                  hint:
                                                      "Select Mode Of Payment",
                                                  sufficIconOntap: () {},
                                                  sufficIcon: null),
                                          onChanged: (value) {
                                            controller.selectedModeOfPayment
                                                .value = value!;
                                            if (value.toLowerCase() == 'cash') {
                                              controller.utrNumber.value
                                                  .clear();
                                            }
                                          },
                                          validator: (value) => value == null ||
                                                  value.trim().isEmpty
                                              ? 'Mode of Payment is required'
                                              : null,
                                        );
                                      })
                                    ]),
                                    Obx(() {
                                      final isCash = controller
                                              .selectedModeOfPayment.value
                                              .toLowerCase() ==
                                          'cash';
                                      if (isCash) {
                                        return const SizedBox();
                                      }
                                      return Column(
                                        children: [
                                          C10(),
                                          paddingWidget([
                                            LabelsWithMark(
                                                label:
                                                    "UTR/Credit/Reference Number"),
                                            TextFormField(
                                              controller:
                                                  controller.utrNumber.value,
                                              cursorColor: AppColors.primary,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              keyboardType: TextInputType.name,
                                              style:
                                                  TextStyles.textfieldTextStyle,
                                              decoration: TextFieldDecoration
                                                  .textfieldDecoration(
                                                hint: "UTR Number",
                                              ),
                                            ),
                                          ]),
                                        ],
                                      );
                                    }),
                                    C10(),
                                    paddingWidget([
                                      const LabelsWithMark(
                                          label: "Amount Paid",
                                          isRequired: true),
                                      TextFormField(
                                        controller: controller.amountPaid.value,
                                        cursorColor: AppColors.primary,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        validator: (value) =>
                                            requiredValidator(value!),
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.name,
                                        style: TextStyles.textfieldTextStyle,
                                        decoration: TextFieldDecoration
                                            .textfieldDecoration(
                                          hint: "Paid Amount",
                                        ),
                                      ),
                                    ]),
                                    C10(),
                                    paddingWidget([
                                      const LabelsWithMark(
                                          label: "Reference Date"),
                                      Obx(
                                        () => TextFormField(
                                            controller:
                                                controller.referenceDate.value,
                                            cursorColor: AppColors.primary,
                                            readOnly: true,
                                            onTap: () => controller.selectDate(
                                                context,
                                                controller.referenceDate.value,
                                                controller
                                                    .selectedReferenceDate),
                                            style:
                                                TextStyles.textfieldTextStyle,
                                            decoration: TextFieldDecoration
                                                .textfieldDecorationicon(
                                              hint: "Reference Date",
                                              sufficIcon: Icons.calendar_today,
                                              sufficIconOntap: () =>
                                                  controller.selectDate(
                                                      context,
                                                      controller
                                                          .referenceDate.value,
                                                      controller
                                                          .selectedReferenceDate),
                                            )),
                                      ),
                                    ]),
                                    C10(),
                                    imagePickerField(
                                      label: "Payment Proof",
                                      imageFile: controller.paymentProofImage,
                                      isFocused:
                                          controller.isPaymentProofImageFocused,
                                      onTap: () => controller.pickImage(
                                          controller.paymentProofImage),
                                    ),
                                    C10(),
                                    paddingWidget([
                                      LabelsWithMark(label: "Remark"),
                                      TextFormField(
                                        controller: controller.remark.value,
                                        cursorColor: AppColors.primary,
                                        textCapitalization:
                                            TextCapitalization.none,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: TextStyles.textfieldTextStyle,
                                        decoration: TextFieldDecoration
                                            .textfieldDecoration(
                                          hint: "Remark",
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    controller.saveRepayments();
                                    Get.off(() => LoanRepaymentSuccessScreen(
                                          crNo: controller.loanId.value.text,
                                          applicantName: controller
                                              .applicantName.value.text,
                                          amount:
                                              controller.amountPaid.value.text,
                                        ));
                                  } else {
                                    AppTostMassage.showTostMassage(
                                      massage:
                                          "Please fill all required fields",
                                    );
                                  }
                                },
                                child: IntrinsicWidth(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryOrange,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
