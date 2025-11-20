import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/uploadFile.dart';
import 'package:microfinance/logic/controller/memberCreation/memberCreationController.dart';
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
                    textCapitalization: TextCapitalization.characters,
                    keyboardType: TextInputType.text,
                    style: TextStyles.textfieldTextStyle,
                    onChanged: (value) {
                      controller.voterId.refresh();
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => requiredValidator(value!),
                    decoration: TextFieldDecoration.textfieldDecoration(
                      hint: "Voter Id Number",
                    ).copyWith(
                        filled: true,
                        fillColor: !controller.isReadOnly.value
                            ? Colors.white
                            : Colors.grey.shade200)),
              ]),
              C10(),
              Row(
                children: [
                  Expanded(
                    flex: controller.isReadOnly.value &&
                            controller.voterbackImage.value == null &&
                            (controller.loanMember.isNotEmpty &&
                                controller.loanMember[0].voterIdImageBack
                                        ?.isEmpty ==
                                    true)
                        ? 10
                        : 5,
                    child: imagePickerField1(
                      label: "Voter Id Front Image",
                      isRequired: true,
                      readOnlyFlag: controller.isReadOnly,
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
                          fieldName: 'Voter Id Front Image'),
                    ),
                  ),
                  Obx(() {
                    final hasFile = controller.voterbackImage.value != null ||
                        (controller.loanMember.isNotEmpty &&
                            controller.loanMember[0].voterIdImageBack
                                    ?.isNotEmpty ==
                                true);

                    if (!hasFile && controller.isReadOnly.value)
                      return SizedBox.shrink();

                    return Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: imagePickerField1(
                          label: "Voter Id Back Image",
                          readOnlyFlag: controller.isReadOnly,
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
                    );
                  })
                ],
              ),
              C30(),
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  final isReadOnly = controller.isReadOnly.value;

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isReadOnly ? Colors.grey : Colors.red.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () async {
                      if (isReadOnly) {
                        Get.back();
                      } else {
                        if (_formKey.currentState!.validate()) {
                          Get.back();
                          await controller.updateLoanMember();
                        }
                      }
                    },
                    child: Text(
                      isReadOnly ? "CLOSE" : "UPLOAD DOCUMENT",
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "Roboto-Medium",
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
