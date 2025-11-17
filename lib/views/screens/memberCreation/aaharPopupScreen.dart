import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/uploadFile.dart';
import 'package:microfinance/logic/controller/memberCreation/memberCreationController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class AadharPopup extends StatelessWidget {
  AadharPopup({super.key});

  final _formKey = GlobalKey<FormState>();
  final MemberCreationController controller =
      Get.find<MemberCreationController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              paddingWidget([
                const LabelsWithMark(
                    label: "Aadhar Card Number", isRequired: true),
                TextFormField(
                  enabled: !controller.isReadOnly.value,
                  controller: controller.aadharNumber.value,
                  cursorColor: AppColors.primary,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  validator: (value) => aadharValidator(value!.trim()),
                  style: TextStyles.textfieldTextStyle,
                  onChanged: (value) {
                    controller.aadharNumber.refresh();
                  },
                  decoration: TextFieldDecoration.textfieldDecoration(
                    hint: "Aadhar Card Number",
                  ).copyWith(
                      filled: true,
                      fillColor: !controller.isReadOnly.value
                          ? Colors.white
                          : Colors.grey.shade200),
                ),
              ]),
              C10(),
              Row(
                children: [
                  Expanded(
                    child: imagePickerField1(
                      label: "Aadhar Card Front Image",
                      isRequired: true,
                      imageFile: controller.aadharImage,
                      imageUrl: RxString(controller.loanMember.isNotEmpty
                          ? controller.loanMember[0].aadharImage ?? ''
                          : ''),
                      isFocused: controller.isAadharImageFocused,
                      onTap: () => controller.pickImage(controller.aadharImage),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (file) => imageFileValidator(
                        localFile: file,
                        networkUrl: controller.loanMember.isNotEmpty
                            ? controller.loanMember[0].aadharImage
                            : null,
                        fieldName: 'Aadhar Card Front Image',
                      ),
                    ),
                  ),
                  C10(),
                  Expanded(
                    child: imagePickerField1(
                      label: "Aadhar Card Back Image",
                      isRequired: true,
                      imageFile: controller.aadharbackImage,
                      imageUrl: RxString(controller.loanMember.isNotEmpty
                          ? controller.loanMember[0].aadharImageBack ?? ''
                          : ''),
                      isFocused: controller.isAadharbackImageFocused,
                      onTap: () =>
                          controller.pickImage(controller.aadharbackImage),
                    ),
                  ),
                ],
              ),
              C30(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.back();
                    }
                  },
                  child: const Text(
                    "UPLOAD DOCUMENT",
                    style: TextStyle(fontSize: 14, fontFamily: "Roboto-Medium"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
