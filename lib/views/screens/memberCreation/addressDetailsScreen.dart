import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
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
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  /// Scrollable form content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            paddingWidget(
                              [
                                const LabelsWithMark(
                                    label: "Address Line 1", isRequired: true),
                                TextFormField(
                                  enabled: !controller.isReadOnly.value,
                                  controller: controller.address.value,
                                  cursorColor: AppColors.primary,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (value) =>
                                      requiredValidator(value!),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.name,
                                  style: TextStyles.textfieldTextStyle,
                                  decoration:
                                      TextFieldDecoration.textfieldDecoration(
                                              hint: "Address Line 1")
                                          .copyWith(
                                              filled: true,
                                              fillColor:
                                                  !controller.isReadOnly.value
                                                      ? Colors.white
                                                      : Colors.grey.shade200),
                                ),
                              ],
                            ),
                            C10(),
                            paddingWidget(
                              [
                                const LabelsWithMark(
                                  label: "Address Line 2",
                                  isRequired: true,
                                ),
                                TextFormField(
                                  enabled: !controller.isReadOnly.value,
                                  controller: controller.addressLineTwo.value,
                                  cursorColor: AppColors.primary,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.name,
                                  validator: (value) =>
                                      requiredValidator(value!),
                                  style: TextStyles.textfieldTextStyle,
                                  decoration:
                                      TextFieldDecoration.textfieldDecoration(
                                              hint: "Address line 2")
                                          .copyWith(
                                              filled: true,
                                              fillColor:
                                                  !controller.isReadOnly.value
                                                      ? Colors.white
                                                      : Colors.grey.shade200),
                                ),
                              ],
                            ),
                            C10(),
                            paddingWidget([
                              LabelsWithMark(
                                label: "State",
                                isRequired: true,
                              ),
                              Obx(() {
                                final isEnabled = !controller.isReadOnly.value;

                                return DropdownButtonFormField<String>(
                                  value: controller.selectedState.value.isEmpty
                                      ? null
                                      : controller.selectedState.value,
                                  items: controller.stateList.map((e) {
                                    return DropdownMenuItem(
                                      value: e.stateCode,
                                      child: Text(e.stateName.toString()),
                                    );
                                  }).toList(),
                                  style: TextStyles.textfieldTextStyle,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration:
                                      TextFieldDecoration.textfieldDecoration(
                                    hint: "Select State",
                                  ).copyWith(
                                    filled: true,
                                    fillColor: !controller.isReadOnly.value
                                        ? Colors.white
                                        : Colors.grey.shade200,
                                  ),
                                  onChanged: isEnabled
                                      ? (value) {
                                          controller.selectedState.value =
                                              value!;
                                        }
                                      : null,
                                  disabledHint:
                                      controller.selectedState.value.isNotEmpty
                                          ? Text(controller.stateList
                                                  .firstWhereOrNull(
                                                    (e) =>
                                                        e.stateCode ==
                                                        controller.selectedState
                                                            .value,
                                                  )
                                                  ?.stateName ??
                                              '')
                                          : const Text("Select State"),
                                  validator: (value) {
                                    if (controller
                                        .selectedState.value.isEmpty) {
                                      return 'This field can\'t be empty';
                                    }
                                    return null;
                                  },
                                );
                              }),
                            ]),
                            C10(),
                            paddingWidget(
                              [
                                const LabelsWithMark(
                                    label: "Country", isRequired: true),
                                TextFormField(
                                  enabled: !controller.isReadOnly.value,
                                  controller: controller.country.value,
                                  readOnly: true,
                                  cursorColor: AppColors.primary,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.name,
                                  style: TextStyles.textfieldTextStyle,
                                  decoration:
                                      TextFieldDecoration.textfieldDecoration(
                                    hint: "Country",
                                  ).copyWith(
                                          filled: true,
                                          fillColor:
                                              !controller.isReadOnly.value
                                                  ? Colors.white
                                                  : Colors.grey.shade200),
                                ),
                              ],
                            ),
                            C10(),
                            paddingWidget(
                              [
                                const LabelsWithMark(
                                    label: "City", isRequired: true),
                                TextFormField(
                                  enabled: !controller.isReadOnly.value,
                                  controller: controller.city.value,
                                  cursorColor: AppColors.primary,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (value) =>
                                      requiredValidator(value!),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.name,
                                  style: TextStyles.textfieldTextStyle,
                                  decoration:
                                      TextFieldDecoration.textfieldDecoration(
                                              hint: "City")
                                          .copyWith(
                                              filled: true,
                                              fillColor:
                                                  !controller.isReadOnly.value
                                                      ? Colors.white
                                                      : Colors.grey.shade200),
                                ),
                              ],
                            ),
                            C10(),
                            paddingWidget(
                              [
                                const LabelsWithMark(
                                    label: "Pin Code", isRequired: true),
                                TextFormField(
                                  enabled: !controller.isReadOnly.value,
                                  controller: controller.pincode.value,
                                  cursorColor: AppColors.primary,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (value) =>
                                      pincodeValidator(value!.trim()),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.name,
                                  style: TextStyles.textfieldTextStyle,
                                  decoration:
                                      TextFieldDecoration.textfieldDecoration(
                                              hint: "Pin Code")
                                          .copyWith(
                                              filled: true,
                                              fillColor:
                                                  !controller.isReadOnly.value
                                                      ? Colors.white
                                                      : Colors.grey.shade200),
                                ),
                              ],
                            ),
                            C30(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.selectedIndex.value = 0;
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.primaryOrange,
                            shape: BoxShape.circle,
                          ),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            controller.updateLoanMember();
                            controller.selectedIndex.value = 2;
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.primaryOrange,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
