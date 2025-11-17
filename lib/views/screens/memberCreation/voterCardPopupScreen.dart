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

class VoterIdPopup extends StatelessWidget {
  VoterIdPopup({super.key});

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
                    label: "Voter Id Number", isRequired: true),
                TextFormField(
                  enabled: !controller.isReadOnly.value,
                  controller: controller.voterId.value,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: AppColors.primary,
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.text,
                  validator: (value) => voterIdValidator(value!.trim()),
                  style: TextStyles.textfieldTextStyle,
                  onChanged: (value) {
                    controller.voterId.refresh();
                  },
                  decoration: TextFieldDecoration.textfieldDecoration(
                    hint: "Voter Id Number",
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
                      label: "Voter Id Front Image",
                      isRequired: true,
                      imageFile: controller.voterImage,
                      imageUrl: RxString(controller.loanMember.isNotEmpty
                          ? controller.loanMember[0].voterIdImage ?? ''
                          : ''),
                      isFocused: controller.isvoterImageFocused,
                      onTap: () {
                        controller.pickImage(controller.voterImage);
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (file) => imageFileValidator(
                        localFile: file,
                        networkUrl: controller.loanMember.isNotEmpty
                            ? controller.loanMember[0].voterIdImage
                            : null,
                        fieldName: 'Voter Id Front Image',
                      ),
                    ),
                  ),
                  C10(),
                  Expanded(
                    child: imagePickerField1(
                      label: "Voter Id Back Image",
                      isRequired: true,
                      imageFile: controller.voterbackImage,
                      imageUrl: RxString(controller.loanMember.isNotEmpty
                          ? controller.loanMember[0].voterIdImageBack ?? ''
                          : ''),
                      isFocused: controller.isvoterbackImageFocused,
                      onTap: () {
                        controller.pickImage(controller.voterbackImage);
                      },
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
