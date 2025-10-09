import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/buttons.dart';
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
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Bank Name", isRequired: true),
                        TextFormField(
                          controller: controller.bankName.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => requiredValidator(value!),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Bank Name"),
                        ),
                      ],
                    ),
                    C10(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Account Number", isRequired: true),
                        TextFormField(
                            controller: controller.accountNumber.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) => requiredValidator(value!),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                hint: "Account Number")),
                      ],
                    ),
                    C10(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Holder Name", isRequired: true),
                        TextFormField(
                          controller: controller.holderName.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => requiredValidator(value!),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Holder Name"),
                        ),
                      ],
                    ),
                    C10(),
                    paddingWidget(
                      [
                        const LabelsWithMark(label: "Branch", isRequired: true),
                        TextFormField(
                          controller: controller.branch.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => requiredValidator(value!),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Branch"),
                        ),
                      ],
                    ),
                    C10(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Ifsc Code", isRequired: true),
                        TextFormField(
                          controller: controller.ifscCode.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => requiredValidator(value!),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Ifsc Code"),
                        ),
                      ],
                    ),
                    C10(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Bank Address", isRequired: true),
                        TextFormField(
                          controller: controller.bankAddress.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => requiredValidator(value!),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Bank Address"),
                        ),
                      ],
                    ),
                    C10(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Cibil Score", isRequired: true),
                        TextFormField(
                          controller: controller.cibilScore.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => requiredValidator(value!),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Cibil Score"),
                        ),
                      ],
                    ),C10(),
                    // paddingWidget(
                    //   [
                    //     const LabelsWithMark(
                    //         label: "Cibil Date"),
                    //     TextFormField(
                    //       controller: controller.cibilDate.value,
                    //       cursorColor: AppColors.primary,
                    //       textCapitalization: TextCapitalization.sentences,
                    //       // validator: (value) => requiredValidator(value!),
                    //       // autovalidateMode: AutovalidateMode.onUserInteraction,
                    //       keyboardType: TextInputType.name,
                    //       style: TextStyles.textfieldTextStyle,
                    //       decoration: TextFieldDecoration.textfieldDecoration(
                    //           hint: "Cibil Date"),
                    //     ),
                    //   ],
                   // ),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Cibil Date", isRequired: true),
                        Obx(
                          () => TextFormField(
                            controller: controller.cibilDate.value,
                            cursorColor: AppColors.primary,
                            readOnly: true,
                            onTap: () => controller.selectDate(context,controller.cibilDate.value),
                            validator: (value) => requiredValidator(value!),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TextStyles.textfieldTextStyle,
                            decoration:
                                TextFieldDecoration.textfieldDecorationicon(
                              hint: "Cibil Date",
                              sufficIcon: Icons.calendar_today,
                              sufficIconOntap: () =>
                                  controller.selectDate(context,controller.cibilDate.value),
                            ),
                          ),
                        ),
                      ],
                    ),
                    C20(),
                    AppButton(
                        title: "save",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            controller.updateLoanMember();
                          } else {
                            AppTostMassage.showTostMassage(
                              massage: "Please fill all required fields",
                            );
                          }
                        })
                  ])),
            ),
          ),
        ));
  }
}
