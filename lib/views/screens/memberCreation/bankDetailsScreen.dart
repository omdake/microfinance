import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/logic/controller/memberCreation/memberCreationController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class BankDetailscSreen extends StatelessWidget {
  BankDetailscSreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final MemberCreationController controller =
      Get.put(MemberCreationController());
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
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(children: [
                          paddingWidget(
                            [
                              const LabelsWithMark(
                                  label: "Bank Name", isRequired: true),
                              TextFormField(
                                enabled: !controller.isReadOnly.value,
                                controller: controller.bankName.value,
                                cursorColor: AppColors.primary,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                validator: (value) => requiredValidator(value!),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.name,
                                style: TextStyles.textfieldTextStyle,
                                decoration:
                                    TextFieldDecoration.textfieldDecoration(
                                            hint: "Bank Name")
                                        .copyWith(
                                            filled: true,
                                            fillColor:
                                                !controller.isReadOnly.value
                                                    ? Colors.white
                                                    : Colors.grey.shade200),
                              ),
                            ],
                          ),
                          C10(),
                          paddingWidget(
                            [
                              const LabelsWithMark(
                                  label: "Account Number", isRequired: true),
                              TextFormField(
                                  enabled: !controller.isReadOnly.value,
                                  controller: controller.accountNumber.value,
                                  cursorColor: AppColors.primary,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (value) =>
                                      requiredValidator(value!),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.name,
                                  style: TextStyles.textfieldTextStyle,
                                  decoration:
                                      TextFieldDecoration.textfieldDecoration(
                                              hint: "Account Number")
                                          .copyWith(
                                              filled: true,
                                              fillColor:
                                                  !controller.isReadOnly.value
                                                      ? Colors.white
                                                      : Colors.grey.shade200)),
                            ],
                          ),
                          C10(),
                          paddingWidget(
                            [
                              const LabelsWithMark(
                                  label: "Holder Name", isRequired: true),
                              TextFormField(
                                enabled: !controller.isReadOnly.value,
                                controller: controller.holderName.value,
                                cursorColor: AppColors.primary,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                validator: (value) => requiredValidator(value!),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.name,
                                style: TextStyles.textfieldTextStyle,
                                decoration:
                                    TextFieldDecoration.textfieldDecoration(
                                            hint: "Holder Name")
                                        .copyWith(
                                            filled: true,
                                            fillColor:
                                                !controller.isReadOnly.value
                                                    ? Colors.white
                                                    : Colors.grey.shade200),
                              ),
                            ],
                          ),
                          C10(),
                          paddingWidget(
                            [
                              const LabelsWithMark(
                                  label: "Branch", isRequired: true),
                              TextFormField(
                                enabled: !controller.isReadOnly.value,
                                controller: controller.branch.value,
                                cursorColor: AppColors.primary,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                validator: (value) => requiredValidator(value!),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.name,
                                style: TextStyles.textfieldTextStyle,
                                decoration:
                                    TextFieldDecoration.textfieldDecoration(
                                            hint: "Branch")
                                        .copyWith(
                                            filled: true,
                                            fillColor:
                                                !controller.isReadOnly.value
                                                    ? Colors.white
                                                    : Colors.grey.shade200),
                              ),
                            ],
                          ),
                          C10(),
                          paddingWidget(
                            [
                              const LabelsWithMark(
                                  label: "Ifsc Code", isRequired: true),
                              TextFormField(
                                enabled: !controller.isReadOnly.value,
                                controller: controller.ifscCode.value,
                                cursorColor: AppColors.primary,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                validator: (value) => requiredValidator(value!),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.name,
                                style: TextStyles.textfieldTextStyle,
                                decoration:
                                    TextFieldDecoration.textfieldDecoration(
                                            hint: "Ifsc Code")
                                        .copyWith(
                                            filled: true,
                                            fillColor:
                                                !controller.isReadOnly.value
                                                    ? Colors.white
                                                    : Colors.grey.shade200),
                              ),
                            ],
                          ),
                          C10(),
                          paddingWidget(
                            [
                              const LabelsWithMark(label: "Bank Address"),
                              TextFormField(
                                enabled: !controller.isReadOnly.value,
                                controller: controller.bankAddress.value,
                                cursorColor: AppColors.primary,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                keyboardType: TextInputType.name,
                                style: TextStyles.textfieldTextStyle,
                                decoration:
                                    TextFieldDecoration.textfieldDecoration(
                                            hint: "Bank Address")
                                        .copyWith(
                                            filled: true,
                                            fillColor:
                                                !controller.isReadOnly.value
                                                    ? Colors.white
                                                    : Colors.grey.shade200),
                              ),
                            ],
                          ),
                        ])),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.selectedIndex.value = 1;
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.primaryOrange,
                          shape: BoxShape.circle,
                        ),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (controller.isReadOnly.value) {
                          controller.selectedIndex.value = 3;
                          return;
                        }
                        if (_formKey.currentState!.validate()) {
                          controller.updateLoanMember();
                        } else {
                          AppTostMassage.showTostMassage(
                            massage: "Please fill all required fields",
                          );
                        }
                        controller.selectedIndex.value = 3;
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.primaryOrange,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
