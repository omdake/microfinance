import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/logic/controller/loanApplication/loanApplicationController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class LoanApplicationViewOnlyScreen extends StatelessWidget {
  LoanApplicationViewOnlyScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final LoanApplicationController controller =
      Get.put(LoanApplicationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Loan Application Creation"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        }

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.white],
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
                  child: Column(
                    children: [
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
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
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
                              label: "Co-Borrower", isRequired: true),
                          TextFormField(
                            controller: controller.coBorrower.value,
                            enabled: controller.isFormEdit.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) => requiredValidator(value!),
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                    hint: "Co-Borrower")
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
                              label: "Loan Product", isRequired: true),
                          TextFormField(
                            controller: controller.loanProduct.value,
                            enabled: controller.isFormEdit.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) => requiredValidator(value!),
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                    hint: "Loan Product")
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
                              label: "Amount", isRequired: true),
                          TextFormField(
                            controller: controller.loanAmount.value,
                            enabled: controller.isFormEdit.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) => requiredValidator(value!),
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                    hint: "Amount")
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
                              label: "Period", isRequired: true),
                          TextFormField(
                            controller: controller.periods.value,
                            enabled: controller.isFormEdit.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyles.textfieldTextStyle,
                            validator: (value) => requiredValidator(value!),
                            decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Period",
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
                              label: "Nominee", isRequired: true),
                          TextFormField(
                            controller: controller.nominee.value,
                            enabled: controller.isFormEdit.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) => requiredValidator(value!),
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                    hint: "Nominee")
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
                              label: "Relation", isRequired: true),
                          TextFormField(
                            controller: controller.relation.value,
                            enabled: controller.isFormEdit.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) => requiredValidator(value!),
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                    hint: "Relation")
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
                          LabelsWithMark(label: "Description"),
                          TextFormField(
                            controller: controller.description.value,
                            enabled: controller.isFormEdit.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                    hint: "Description")
                                .copyWith(
                              filled: true,
                              fillColor: controller.isFormEdit.value
                                  ? Colors.white
                                  : Colors.grey.shade200,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
