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

class AddressDocPopup extends StatelessWidget {
  AddressDocPopup({super.key});

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
                        child: Text(addressDocType,
                            style: TextStyles.textfieldTextStyle),
                      );
                    }).toList(),
                    value: controller.addressDocTypeList
                            .contains(controller.selectedAddressDocType.value)
                        ? controller.selectedAddressDocType.value
                        : null,
                    onChanged: isEnabled
                        ? (value) {
                            if (value != null) {
                              controller.addressImage.value = null;
                              controller.addressImageUrl.value = '';
                              if (controller.loanMember.isNotEmpty) {
                                controller.loanMember[0].addressImage = '';
                                controller.loanMember.refresh();
                              }
                              controller.selectedAddressDocType.value = value;
                              controller.showConsumerNumber.value =
                                  value == "ELECTRICITY BILL";
                            }
                          }
                        : null,
                    disabledHint:
                        controller.selectedAddressDocType.value.isNotEmpty
                            ? Text(
                                controller.selectedAddressDocType.value,
                                style: TextStyles.textfieldTextStyle,
                              )
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
              Obx(() {
                if (!controller.showConsumerNumber.value) return SizedBox();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    C10(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Consumer Number", isRequired: true),
                        TextFormField(
                          controller: controller.consumerNumberController.value,
                          enabled: !controller.isReadOnly.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.characters,
                          validator: (value) {
                            if (controller.showConsumerNumber.value &&
                                (value == null || value.trim().isEmpty)) {
                              return "Consumer Number is required";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                            hint: "Enter Consumer Number",
                          ).copyWith(
                            filled: true,
                            fillColor: !controller.isReadOnly.value
                                ? Colors.white
                                : Colors.grey.shade200,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
              C10(),
              Obx(() {
                return imagePickerField1(
                  label: "Address Proof",
                  isRequired: true,
                  readOnlyFlag: controller.isReadOnly,
                  imageFile: controller.addressImage,
                  imageUrl: controller.addressImageUrl,
                  isFocused: controller.isAddressImageFocused,
                  onTap: () => controller.pickImage(controller.addressImage),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (file) => imageFileValidator(
                    localFile: file,
                    networkUrl: controller.addressImageUrl.value.isNotEmpty
                        ? controller.addressImageUrl.value
                        : null,
                    fieldName: 'Address Image',
                  ),
                );
              }),
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
