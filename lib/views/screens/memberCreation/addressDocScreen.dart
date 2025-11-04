import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/uploadFile.dart';
import 'package:microfinance/logic/controller/memberCreation/memberCreationController.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class AddressDocPopup extends StatelessWidget {
  AddressDocPopup({super.key});
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
            paddingWidget([
              const LabelsWithMark(
                label: "Address Document",
                isRequired: true,
              ),
              Obx(() {
                final isEnabled = !controller.isReadOnly.value;

                return DropdownButtonFormField<String>(
                  decoration: TextFieldDecoration.textfieldDecoration(
                    hint: "Select Address Document",
                  ).copyWith(
                      filled: true,
                      fillColor: !controller.isReadOnly.value
                          ? Colors.white
                          : Colors.grey.shade200),
                  style: TextStyles.textfieldTextStyle,
                  items: controller.addressDocTypeList.map((addressDocType) {
                    return DropdownMenuItem<String>(
                      value: addressDocType,
                      child: Text(addressDocType),
                    );
                  }).toList(),
                  value: controller.selectedAddressDocType.value.isNotEmpty
                      ? controller.selectedAddressDocType.value
                      : null,
                  onChanged: isEnabled
                      ? (value) {
                          if (value != null) {
                            controller.selectedAddressDocType.value = value;
                          }
                        }
                      : null,
                  disabledHint:
                      controller.selectedAddressDocType.value.isNotEmpty
                          ? Text(controller.selectedAddressDocType.value)
                          : const Text("Select Address Document"),
                  validator: (value) {
                    if (controller.selectedAddressDocType.value.isEmpty) {
                      return 'Address Document is required';
                    }
                    return null;
                  },
                );
              }),
            ]),
            C10(),
            imagePickerField1(
              label: "Address Image",
              isRequired: true,
              imageFile: controller.addressImage,
              imageUrl: RxString(controller.loanMember.isNotEmpty
                  ? controller.loanMember[0].addressImage ?? ''
                  : ''),
              isFocused: controller.isAddressImageFocused,
              onTap: () => controller.pickImage(controller.addressImage),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (file) => imageFileValidator(
                localFile: file,
                networkUrl: controller.loanMember.isNotEmpty
                    ? controller.loanMember[0].addressImage
                    : null,
                fieldName: 'Address Image',
              ),
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
