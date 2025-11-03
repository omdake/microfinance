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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
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
                  child: Column(
                    children: [
                      paddingWidget([
                        const LabelsWithMark(
                            label: "Aadhar Card Number", isRequired: true),
                        TextFormField(
                          enabled: !controller.isReadOnly.value,
                          controller: controller.aadharNumber.value,
                          cursorColor: AppColors.primary,
                          keyboardType: TextInputType.number,
                          validator: (value) => aadharValidator(value!.trim()),
                          style: TextStyles.textfieldTextStyle,
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
                      imagePickerField(
                        label: "Aadhar Card Front Image",
                        isRequired: true,
                        imageFile: controller.aadharImage,
                        imageUrl: RxString(controller.loanMember.isNotEmpty
                            ? controller.loanMember[0].aadharImage ?? ''
                            : ''),
                        isFocused: controller.isAadharImageFocused,
                        onTap: () =>
                            controller.pickImage(controller.aadharImage),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                           validator: (file) => imageFileValidator(
                          localFile: file,
                          networkUrl: controller.loanMember.isNotEmpty
                              ? controller.loanMember[0].aadharImage
                              : null,
                          fieldName: 'Aadhar Card Front Image',
                        ),
                      ),
                      C10(),
                      imagePickerField(
                        label: "Aadhar Card Back Image",
                        isRequired: true,
                        imageFile: controller.aadharbackImage,
                        imageUrl: RxString(controller.loanMember.isNotEmpty
                            ? controller.loanMember[0].aadharImageBack ?? ''
                            : ''),
                        isFocused: controller.isAadharbackImageFocused,
                        onTap: () =>
                            controller.pickImage(controller.aadharbackImage),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (file) => imageFileValidator(
                          localFile: file,
                          networkUrl: controller.loanMember.isNotEmpty
                              ? controller.loanMember[0].aadharImageBack
                              : null,
                          fieldName: 'Aadhar Card Back Image',
                        ),
                      ),
                      C10(),
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
                      imagePickerField(
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
                      C10(),
                      imagePickerField(
                        label: "Pan Card Back Image",
                        isRequired: true,
                        imageFile: controller.panbackImage,
                        imageUrl: RxString(controller.loanMember.isNotEmpty
                            ? controller.loanMember[0].pancardImageBack ?? ''
                            : ''),
                        isFocused: controller.isAadharbackImageFocused,
                        onTap: () =>
                            controller.pickImage(controller.panbackImage),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (file) => imageFileValidator(
                          localFile: file,
                          networkUrl: controller.loanMember.isNotEmpty
                              ? controller.loanMember[0].pancardImageBack
                              : null,
                          fieldName: 'Pan Card Back Image',
                        ),
                      ),
                      C10(),
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
                            items: controller.addressDocTypeList
                                .map((addressDocType) {
                              return DropdownMenuItem<String>(
                                value: addressDocType,
                                child: Text(addressDocType),
                              );
                            }).toList(),
                            value: controller
                                    .selectedAddressDocType.value.isNotEmpty
                                ? controller.selectedAddressDocType.value
                                : null,
                            onChanged: isEnabled
                                ? (value) {
                                    if (value != null) {
                                      controller.selectedAddressDocType.value =
                                          value;
                                    }
                                  }
                                : null,
                            disabledHint: controller
                                    .selectedAddressDocType.value.isNotEmpty
                                ? Text(controller.selectedAddressDocType.value)
                                : const Text("Select Address Document"),
                            validator: (value) {
                              if (controller
                                  .selectedAddressDocType.value.isEmpty) {
                                return 'Address Document is required';
                              }
                              return null;
                            },
                          );
                        }),
                      ]),
                      C10(),
                      imagePickerField(
                        label: "Address Image",
                        isRequired: true,
                        imageFile: controller.addressImage,
                        imageUrl: RxString(controller.loanMember.isNotEmpty
                            ? controller.loanMember[0].addressImage ?? ''
                            : ''),
                        isFocused: controller.isAddressImageFocused,
                        onTap: () =>
                            controller.pickImage(controller.addressImage),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (file) => imageFileValidator(
                          localFile: file,
                          networkUrl: controller.loanMember.isNotEmpty
                              ? controller.loanMember[0].addressImage
                              : null,
                          fieldName: 'Address Image',
                        ),
                      ),
                      C10(),
                      imagePickerField(
                        label: "Home Image",
                        isRequired: true,
                        imageFile: controller.homeImage,
                        enableGeotag: true,
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
                                  controller
                                      .homelatitude.value.text.isNotEmpty &&
                                  controller.homelatitude.value.text !=
                                      '0.0') ...[
                                paddingWidget([
                                  const LabelsWithMark(
                                      label: "Latitude", isRequired: true),
                                  TextFormField(
                                    readOnly: true,
                                    enabled: !controller.isReadOnly.value,
                                    controller: controller.homelatitude.value,
                                    cursorColor: AppColors.primary,
                                    style: TextStyles.textfieldTextStyle,
                                    decoration:
                                        TextFieldDecoration.textfieldDecoration(
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
                                  controller
                                      .homelongitude.value.text.isNotEmpty &&
                                  controller.homelongitude.value.text !=
                                      '0.0') ...[
                                paddingWidget([
                                  const LabelsWithMark(
                                      label: "Longitude", isRequired: true),
                                  TextFormField(
                                    enabled: !controller.isReadOnly.value,
                                    readOnly: true,
                                    controller: controller.homelongitude.value,
                                    cursorColor: AppColors.primary,
                                    style: TextStyles.textfieldTextStyle,
                                    decoration:
                                        TextFieldDecoration.textfieldDecoration(
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
                                  controller.homeGeoLocation.value.text
                                      .isNotEmpty) ...[
                                paddingWidget([
                                  const LabelsWithMark(
                                      label: "Geo Location", isRequired: true),
                                  TextFormField(
                                    readOnly: true,
                                    enabled: !controller.isReadOnly.value,
                                    controller:
                                        controller.homeGeoLocation.value,
                                    cursorColor: AppColors.primary,
                                    style: TextStyles.textfieldTextStyle,
                                    decoration:
                                        TextFieldDecoration.textfieldDecoration(
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
                      paddingWidget([
                        const LabelsWithMark(
                            label: "Voter Id Number", isRequired: true),
                        TextFormField(
                          enabled: !controller.isReadOnly.value,
                          controller: controller.voterId.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.characters,
                          keyboardType: TextInputType.text,
                          validator: (value) => voterIdValidator(value!.trim()),
                          style: TextStyles.textfieldTextStyle,
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
                      imagePickerField(
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
                      C20(),
                      imagePickerField(
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (file) => imageFileValidator(
                          localFile: file,
                          networkUrl: controller.loanMember.isNotEmpty
                              ? controller.loanMember[0].voterIdImageBack
                              : null,
                          fieldName: 'Voter Id Back Image',
                        ),
                      ),
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
                              },
                            ),
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
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white.withOpacity(0.3),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
