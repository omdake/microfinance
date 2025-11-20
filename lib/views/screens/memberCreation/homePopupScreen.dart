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

class HomePopup extends StatelessWidget {
  HomePopup({super.key});

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
              imagePickerField1(
                label: "Home Image",
                isRequired: true,
                imageFile: controller.homeImage,
                enableGeotag: true,
                readOnlyFlag: controller.isReadOnly,
                imageUrl: RxString(controller.loanMember.isNotEmpty
                    ? controller.loanMember[0].homeImage ?? ''
                    : ''),
                isFocused: controller.ishomeImageFocused,
                onGeotagCaptured: (position, address) {
                  controller.latitude.value = position.latitude;
                  controller.longitude.value = position.longitude;
                  controller.geoLocation.value = address;
                },
                onTap: () => controller.pickImage(controller.homeImage),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (file) => imageFileValidator(
                  localFile: file,
                  networkUrl: controller.loanMember.isNotEmpty
                      ? controller.loanMember[0].homeImage
                      : null,
                  fieldName: 'Home Image',
                ),
              ),
              C10(),
              Obx(() => Column(
                    children: [
                      if (controller.showOnlyGeoFields.value &&
                          controller.homelatitude.value.text.isNotEmpty &&
                          controller.homelatitude.value.text != '0.0') ...[
                        paddingWidget([
                          const LabelsWithMark(
                              label: "Latitude", isRequired: true),
                          TextFormField(
                            readOnly: true,
                            enabled: !controller.isReadOnly.value,
                            controller: controller.homelatitude.value,
                            cursorColor: AppColors.primary,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Latitude",
                            ).copyWith(
                              filled: true,
                              fillColor: controller.isFormEdit.value
                                  ? Colors.white
                                  : Colors.grey.shade200,
                            ),
                          ),
                        ]),
                        C10(),
                      ],
                      if (controller.showOnlyGeoFields.value &&
                          controller.homelongitude.value.text.isNotEmpty &&
                          controller.homelongitude.value.text != '0.0') ...[
                        paddingWidget([
                          const LabelsWithMark(
                              label: "Longitude", isRequired: true),
                          TextFormField(
                            enabled: !controller.isReadOnly.value,
                            readOnly: true,
                            controller: controller.homelongitude.value,
                            cursorColor: AppColors.primary,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Longitude",
                            ).copyWith(
                              filled: true,
                              fillColor: controller.isFormEdit.value
                                  ? Colors.white
                                  : Colors.grey.shade200,
                            ),
                          ),
                        ]),
                        C10(),
                      ],
                      if (controller.showOnlyGeoFields.value &&
                          controller.homeGeoLocation.value.text.isNotEmpty) ...[
                        paddingWidget([
                          const LabelsWithMark(
                              label: "Geo Location", isRequired: true),
                          TextFormField(
                            readOnly: true,
                            maxLines: null,
                            minLines: 1,
                            enabled: !controller.isReadOnly.value,
                            controller: controller.homeGeoLocation.value,
                            cursorColor: AppColors.primary,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Geo Location",
                            ).copyWith(
                              filled: true,
                              fillColor: controller.isFormEdit.value
                                  ? Colors.white
                                  : Colors.grey.shade200,
                            ),
                          ),
                        ]),
                        C10(),
                      ],
                    ],
                  )),
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
