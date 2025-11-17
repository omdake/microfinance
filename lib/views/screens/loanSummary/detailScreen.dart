import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/logic/controller/loanSummary/loanDetailsController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final LoanDetailsController controller = Get.put(LoanDetailsController());

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    try {
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (e) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.5),
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Applicant", isRequired: true),
                        TextFormField(
                          initialValue: controller
                              .loanDisbursement.value.applicantMemberName
                              .toString(),
                          enabled: controller.isFormEdit.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.characters,
                          validator: (value) => requiredValidator(value!),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                            hint: "Applicant".toUpperCase(),
                          ).copyWith(
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    C5(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Against Loan", isRequired: true),
                        TextFormField(
                          initialValue: controller
                                  .loanDisbursement.value.againstLoanLoanId ??
                              '',
                          enabled: controller.isFormEdit.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.characters,
                          validator: (value) => requiredValidator(value!),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                            hint: "Against loan".toUpperCase(),
                          ).copyWith(
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    C5(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Sanctioned Loan Amount", isRequired: true),
                        TextFormField(
                          initialValue: controller
                              .loanDisbursement.value.sanctionedLoanAmount
                              ?.toString(),
                          enabled: controller.isFormEdit.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => requiredValidator(value!),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                                  hint: "Sanctioned Loan Amount".toUpperCase())
                              .copyWith(
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    C5(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Current Disbursed Amount",
                            isRequired: true),
                        TextFormField(
                          initialValue: controller
                              .loanDisbursement.value.currentDisbursedAmount
                              .toString(),
                          enabled: controller.isFormEdit.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => requiredValidator(value!),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                                  hint: "Current Disbursed Amount".toUpperCase())
                              .copyWith(
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    C5(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Monthly Repayment Amount",
                            isRequired: true),
                        TextFormField(
                          initialValue: controller
                              .loanDisbursement.value.monthlyRepaymentAmount
                              .toString(),
                          enabled: controller.isFormEdit.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyles.textfieldTextStyle,
                          validator: (value) => commonValidator(value!.trim()),
                          decoration: TextFieldDecoration.textfieldDecoration(
                            hint: "Monthly Repayment Amount".toUpperCase(),
                          ).copyWith(
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    C5(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Disbursement Date", isRequired: true),
                        Obx(
                          () {
                            final formattedDate = _formatDate(
                              controller
                                  .loanDisbursement.value.disbursementDate,
                            );

                            return TextFormField(
                              enabled: controller.isFormEdit.value,
                              initialValue: formattedDate,
                              cursorColor: AppColors.primary,
                              validator: (value) => requiredValidator(value!),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecorationicon(
                                hint: "Disbursement Date".toUpperCase(),
                                sufficIconOntap: null,
                              ).copyWith(
                                filled: false,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    C5(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Repayment Start Date", isRequired: true),
                        Obx(
                          () {
                            final formattedDate = _formatDate(controller
                                .loanDisbursement.value.repaymentStartDate);

                            return TextFormField(
                              enabled: controller.isFormEdit.value,
                              initialValue: formattedDate,
                              cursorColor: AppColors.primary,
                              validator: (value) => requiredValidator(value!),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecorationicon(
                                hint: "Repayment Start Date".toUpperCase(),
                                sufficIconOntap: null,
                              ).copyWith(
                                filled: false,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    C5(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Disbursed Amount", isRequired: true),
                        TextFormField(
                          initialValue: controller
                              .loanDisbursement.value.disbursedAmount
                              .toString(),
                          enabled: controller.isFormEdit.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => requiredValidator(value!),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                                  hint: "Disbursed Amount".toUpperCase())
                              .copyWith(
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    C5(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Principal Amount Paid", isRequired: true),
                        TextFormField(
                          initialValue: controller
                              .loanDisbursement.value.principalAmountPaid
                              .toString(),
                          enabled: controller.isFormEdit.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyles.textfieldTextStyle,
                          validator: (value) => commonValidator(value!.trim()),
                          decoration: TextFieldDecoration.textfieldDecoration(
                            hint: "Principal Amount Paid".toUpperCase(),
                          ).copyWith(
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    C5(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Days Past Due", isRequired: true),
                        TextFormField(
                          initialValue: controller
                              .loanDisbursement.value.daysPastDue
                              .toString(),
                          enabled: controller.isFormEdit.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.phone,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyles.textfieldTextStyle,
                          validator: (value) =>
                              mobileNoValidator(value!.trim()),
                          decoration: TextFieldDecoration.textfieldDecoration(
                            hint: "Days Past Due".toUpperCase(),
                          ).copyWith(
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    C5(),
                    paddingWidget(
                      [
                        const LabelsWithMark(label: "Status", isRequired: true),
                        TextFormField(
                          initialValue: controller.loanDisbursement.value.status
                              .toString(),
                          enabled: controller.isFormEdit.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.characters,
                          keyboardType: TextInputType.phone,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyles.textfieldTextStyle,
                          validator: (value) =>
                              mobileNoValidator(value!.trim()),
                          decoration: TextFieldDecoration.textfieldDecoration(
                            hint: "Status".toUpperCase(),
                          ).copyWith(
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ])),
            ),
          ),
        ));
    // );
  }
}
