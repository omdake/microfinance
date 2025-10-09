import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/buttons.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/uploadFile.dart';
import 'package:microfinance/logic/controller/memberCreation/memberCreationController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class AddressDetailsScreen extends StatelessWidget {
  AddressDetailsScreen({super.key});
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
                            label: "Address", isRequired: true),
                        TextFormField(
                          controller: controller.address.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => requiredValidator(value!),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Address"),
                        ),
                      ],
                    ),
                    C10(),
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
                            label: "Address Doc Type", isRequired: true),
                        Obx(() {
                          return DropdownButtonFormField<String>(
                            decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Select Address Doc Type",
                            ),
                            style: TextStyles.textfieldTextStyle,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            onChanged: (value) {
                              if (value != null) {
                                controller.selectedAddressDocType.value = value;
                              }
                            },
                            validator: (value) {
                              if (controller
                                  .selectedAddressDocType.value.isEmpty) {
                                return 'Address Doc Type is required';
                              }
                              return null;
                            },
                          );
                        }),
                      ],
                    ),
                    C10(),
                    paddingWidget([
                      LabelsWithMark(label: "State"),
                      Obx(() {
                        return DropdownButtonFormField<String>(
                          value: controller.selectedState.value.isEmpty
                              ? null
                              : controller.selectedState.value,
                          items: controller.stateList.map((e) {
                            return DropdownMenuItem(
                              value: e.stateCode.toString(),
                              child: Text(e.stateName.toString()),
                            );
                          }).toList(),
                          style: TextStyles.textfieldTextStyle,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Select State",
                              sufficIconOntap: () {},
                              sufficIcon: null),
                          onChanged: (value) {
                            controller.selectedState.value = value!;
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'This field can\'t be empty';
                            }
                            return null;
                          },
                        );
                      })
                    ]),
                    C10(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Country", isRequired: true),
                        TextFormField(
                          controller: controller.country.value,
                          readOnly: true,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                            hint: "Country",
                          ),
                        ),
                      ],
                    ),
                    C10(),
                    paddingWidget(
                      [
                        const LabelsWithMark(label: "City", isRequired: true),
                        TextFormField(
                          controller: controller.city.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => requiredValidator(value!),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "City"),
                        ),
                      ],
                    ),
                    C10(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                            label: "Pin Code", isRequired: true),
                        TextFormField(
                          controller: controller.pincode.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) => pincodeValidator(value!.trim()),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Pin Code"),
                        ),
                      ],
                    ),
                    C20(),
                    AppButton(
                        title: "save",
                        onTap: () async {
                          controller.updateLoanMember();
                        })
                  ])),
            ),
          ),
        ));
  }
}
