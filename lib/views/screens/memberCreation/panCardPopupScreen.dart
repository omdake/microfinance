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

class PanCardPopup extends StatelessWidget {
  PanCardPopup({super.key});
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            paddingWidget(
              [
                const LabelsWithMark(
                    label: "Pan Card Number", isRequired: true),
                TextFormField(
                  enabled: !controller.isReadOnly.value,
                  controller: controller.panNumber.value,
                  cursorColor: AppColors.primary,
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.text,
                  validator: (value) => panValidator(value!.trim()),
                  style: TextStyles.textfieldTextStyle,
                  decoration: TextFieldDecoration.textfieldDecoration(
                    hint: "Pan Card Number",
                  ).copyWith(
                      filled: true,
                      fillColor: !controller.isReadOnly.value
                          ? Colors.white
                          : Colors.grey.shade200),
                ),
              ],
            ),
            C10(),
            Row(
              children: [
                Expanded(
                  child: imagePickerField1(
                    label: "Pan Card Front Image",
                    isRequired: true,
                    imageFile: controller.panImage,
                    imageUrl: RxString(controller.loanMember.isNotEmpty
                        ? controller.loanMember[0].pancardImage ?? ''
                        : ''),
                    isFocused: controller.isPanImageFocused,
                    onTap: () => controller.pickImage(controller.panImage),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (file) => imageFileValidator(
                      localFile: file,
                      networkUrl: controller.loanMember.isNotEmpty
                          ? controller.loanMember[0].pancardImage
                          : null,
                      fieldName: 'Pan Card Front Image',
                    ),
                  ),
                ),
                C10(),
                Expanded(
                  child: imagePickerField1(
                    label: "Pan Card Back Image",
                    isRequired: true,
                    imageFile: controller.panbackImage,
                    imageUrl: RxString(controller.loanMember.isNotEmpty
                        ? controller.loanMember[0].pancardImageBack ?? ''
                        : ''),
                    isFocused: controller.isAadharbackImageFocused,
                    onTap: () => controller.pickImage(controller.panbackImage),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (file) => imageFileValidator(
                      localFile: file,
                      networkUrl: controller.loanMember.isNotEmpty
                          ? controller.loanMember[0].pancardImageBack
                          : null,
                      fieldName: 'Pan Card Back Image',
                    ),
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
                  Get.back();
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
    );
  }
}
