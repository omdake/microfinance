import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/uploadFile.dart';
import 'package:microfinance/logic/controller/loanSummary/loanSummaryViewController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class LoanRepaymentViewScreen extends StatelessWidget {
  LoanRepaymentViewScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final LoanSummaryViewController controller =
      Get.put(LoanSummaryViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarWithTitle(title: "Loan Repayment"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
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
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(children: [
                        paddingWidget([
                          const LabelsWithMark(
                              label: "Loan Id", isRequired: true),
                          TextFormField(
                            controller: controller.loanId.value,
                            cursorColor: AppColors.primary,
                            enabled: controller.isFormEdit.value,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) => requiredValidator(value!),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Loan ID",
                            ).copyWith(
                              filled: true,
                              fillColor: controller.isFormEdit.value
                                  ? Colors.white
                                  : Colors.grey.shade200,
                            ),
                          )
                        ]),
                        C10(),
                        paddingWidget(
                          [
                            const LabelsWithMark(
                                label: "Value Date", isRequired: true),
                            TextFormField(
                              controller: controller.valueDate.value,
                              cursorColor: AppColors.primary,
                              enabled: controller.isFormEdit.value,
                              validator: (value) => requiredValidator(value!),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecorationicon(
                                hint: "Value Date",
                                sufficIcon: Icons.calendar_today,
                              ).copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                        C10(),
                        paddingWidget(
                          [
                            const LabelsWithMark(
                                label: "Applicant Name", isRequired: true),
                            TextFormField(
                              controller: controller.applicantName.value,
                              enabled: controller.isFormEdit.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => requiredValidator(value!),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Applicant Name")
                                      .copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                        C10(),
                        paddingWidget(
                          [
                            const LabelsWithMark(
                                label: "Payable Amount", isRequired: true),
                            TextFormField(
                              controller: controller.payableAmount.value,
                              cursorColor: AppColors.primary,
                              enabled: controller.isFormEdit.value,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => requiredValidator(value!),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Payable Amount")
                                      .copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                        C10(),
                        paddingWidget(
                          [
                            const LabelsWithMark(
                                label: "Mode Of Payment", isRequired: true),
                            TextFormField(
                              controller: controller.modeOfPayment.value,
                              enabled: controller.isFormEdit.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => requiredValidator(value!),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Mode Of Payment")
                                      .copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                        C10(),
                        paddingWidget(
                          [
                            const LabelsWithMark(
                                label: "Amount Paid", isRequired: true),
                            TextFormField(
                              controller: controller.amountPaid.value,
                              enabled: controller.isFormEdit.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => requiredValidator(value!),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Paid Amount")
                                      .copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                        C10(),
                        paddingWidget(
                          [
                            const LabelsWithMark(label: "Reference Date"),
                            TextFormField(
                              controller: controller.referenceDate.value,
                              cursorColor: AppColors.primary,
                              enabled: controller.isFormEdit.value,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecorationicon(
                                hint: "Reference Date",
                                sufficIcon: Icons.calendar_today,
                              ).copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                        C10(),
                        Obx(() {
                          final hasFile =
                              controller.paymentProofImage.value != null ||
                                  controller.paymentProofUrl.isNotEmpty;
                          if (!hasFile && controller.isReadOnly.value) {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            children: [
                              imagePickerField(
                                label: "Payment Proof",
                                readOnlyFlag: controller.isReadOnly,
                                imageFile: controller.paymentProofImage,
                                imageUrl: controller.paymentProofUrl,
                                isFocused:
                                    controller.isPaymentProofImageFocused,
                                onTap: () => controller
                                    .pickImage(controller.paymentProofImage),
                              ),
                              C10(),
                            ],
                          );
                        }),
                        // paddingWidget(
                        //   [
                        //     LabelsWithMark(label: "UTR Number"),
                        //     TextFormField(
                        //       controller: controller.utrNumber.value,
                        //       enabled: controller.isFormEdit.value,
                        //       cursorColor: AppColors.primary,
                        //       textCapitalization: TextCapitalization.sentences,
                        //       keyboardType: TextInputType.name,
                        //       style: TextStyles.textfieldTextStyle,
                        //       decoration:
                        //           TextFieldDecoration.textfieldDecoration(
                        //                   hint: "UTR Number")
                        //               .copyWith(
                        //         filled: true,
                        //         fillColor: controller.isFormEdit.value
                        //             ? Colors.white
                        //             : Colors.grey.shade200,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        Obx(() {
                          final isCash = controller.modeOfPayment.value.text
                                  .trim()
                                  .toLowerCase() ==
                              'cash';

                          if (isCash) {
                            return const SizedBox.shrink();
                          }

                          return Column(
                            children: [
                              paddingWidget(
                                [
                                  LabelsWithMark(label: "UTR Number"),
                                  TextFormField(
                                    controller: controller.utrNumber.value,
                                    enabled: controller.isFormEdit.value,
                                    cursorColor: AppColors.primary,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    keyboardType: TextInputType.name,
                                    style: TextStyles.textfieldTextStyle,
                                    decoration:
                                        TextFieldDecoration.textfieldDecoration(
                                      hint: "UTR Number",
                                    ).copyWith(
                                      filled: true,
                                      fillColor: controller.isFormEdit.value
                                          ? Colors.white
                                          : Colors.grey.shade200,
                                    ),
                                  )
                                ],
                              ),
                              C10(),
                            ],
                          );
                        }),

                        paddingWidget(
                          [
                            LabelsWithMark(label: "Remark"),
                            TextFormField(
                              controller: controller.remark.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.characters,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                hint: "Remark",
                              ).copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                      ])),
                ),
              ),
            ),
          ),
        ));
  }
}
