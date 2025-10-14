import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/buttons.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/uploadFile.dart';
import 'package:microfinance/logic/controller/memberCreation/memberCreationController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class UploadDcumentSreen extends StatelessWidget {
  UploadDcumentSreen({super.key});
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
                            label: "Aadhar Card Number", isRequired: true),
                        TextFormField(
                          controller: controller.aadharNumber.value,
                          cursorColor: AppColors.primary,
                          keyboardType: TextInputType.number,
                          validator: (value) => aadharValidator(value!.trim()),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Aadhar Number"),
                        ),
                      ],
                    ),
                    C10(),
                    imagePickerField(
                      label: "Aadhar Image",
                      imageFile: controller.aadharImage,
                      imageUrl: RxString(controller.loanMember.isNotEmpty
                          ? controller.loanMember[0].aadharImage ?? ''
                          : ''),
                      isFocused: controller.isAadharImageFocused,
                      onTap: () => controller.pickImage(controller.aadharImage),
                    ),
                    C10(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Pan Card", isRequired: true),
                        TextFormField(
                          controller: controller.panNumber.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.characters,
                          keyboardType: TextInputType.text,
                          validator: (value) => panValidator(value!.trim()),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Pan Card Number"),
                        ),
                      ],
                    ),
                    
                    C10(),
                    imagePickerField(
                      label: "Pan Image",
                      imageFile: controller.panImage,
                      imageUrl: RxString(controller.loanMember.isNotEmpty
                          ? controller.loanMember[0].pancardImage ?? ''
                          : ''),
                      isFocused: controller.isPanImageFocused,
                      onTap: () => controller.pickImage(controller.panImage),
                    ),
                    imagePickerField(
                      label: "Address Image",
                      imageFile: controller.addressImage,
                      imageUrl: RxString(controller.loanMember.isNotEmpty
                          ? controller.loanMember[0].addressImage ?? ''
                          : ''),
                      isFocused: controller.isAddressImageFocused,
                      onTap: () =>
                          controller.pickImage(controller.addressImage),
                    ),
                    C10(),
                    // imagePickerField(
                    //   label: "Address Proof Image",
                    //   imageFile: controller.addressProofImage,
                    //   imageUrl: RxString(controller.loanMember.isNotEmpty
                    //       ? controller.loanMember[0].addressProofImage ?? ''
                    //       : ''),
                    //   isFocused: controller.isAddressProofImageFocused,
                    //   onTap: () =>
                    //       controller.pickImage(controller.addressProofImage),
                    // ),
                    // C10(),
                 
                    imagePickerField(
                      label: "Home Image",
                      imageFile: controller.homeImage,
                      imageUrl: RxString(controller.loanMember.isNotEmpty
                          ? controller.loanMember[0].homeImage ?? ''
                          : ''),
                      isFocused: controller.ishomeImageFocused,
                      onTap: () => controller.pickImage(controller.homeImage),
                    ),
                    C10(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Voter Id", isRequired: true),
                        TextFormField(
                          controller: controller.voterId.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.characters,
                          keyboardType: TextInputType.text,
                          validator: (value) => voterIdValidator(value!.trim()),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                            hint: "Voter Id",
                          ),
                        ),
                      ],
                    ),
                    C10(),
                    imagePickerField(
                        label: "VoterId Image",
                        imageFile: controller.voterImage,
                        imageUrl: RxString(controller.loanMember.isNotEmpty
                            ? controller.loanMember[0].voterIdImage ?? ''
                            : ''),
                        isFocused: controller.isvoterImageFocused,
                        onTap: () {
                          controller.pickImage(controller.voterImage);
                        }),
                    C20(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppButton(
                              title: "Save",
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  controller.updateLoanMember();
                                } else {
                                  AppTostMassage.showTostMassage(
                                    massage: "Please fill all required fields",
                                  );
                                }
                              }),
                        ),
                        C10(),
                        Expanded(
                          child: AppButton(
                              title: "Submit",
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.submitLoanMember(
                                      memberName: controller.name.value);
                                } else {
                                  AppTostMassage.showTostMassage(
                                    massage: "Please fill all required fields",
                                  );
                                }
                              }),
                        ),
                      ],
                    )
                  ])),
            ),
          ),
        ));
  }
}
