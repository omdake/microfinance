import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/mobileFormatter_widget.dart';
import 'package:microfinance/common_widgets/uploadFile.dart';
import 'package:microfinance/logic/controller/memberCreation/memberCreationController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class PersonalDetailsScreen extends StatelessWidget {
  PersonalDetailsScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final MemberCreationController controller =
      Get.put(MemberCreationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              if (controller.isMemberId.value) ...[
                                paddingWidget(
                                  [
                                    const LabelsWithMark(
                                        label: "MemberId", isRequired: true),
                                    TextFormField(
                                      enabled: controller.isFormEdit.value,
                                      controller: controller.memberId.value,
                                      cursorColor: AppColors.primary,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      keyboardType: TextInputType.name,
                                      style: TextStyles.textfieldTextStyle,
                                      decoration: TextFieldDecoration
                                          .textfieldDecoration(
                                        hint: "memberId",
                                      ).copyWith(
                                        filled: true,
                                        fillColor: controller.isFormEdit.value
                                            ? Colors.white
                                            : Colors.grey.shade200,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              C10(),
                              paddingWidget(
                                [
                                  const LabelsWithMark(
                                      label: "First Name", isRequired: true),
                                  TextFormField(
                                    controller: controller.firstName.value,
                                    cursorColor: AppColors.primary,
                                    enabled: !controller.isReadOnly.value,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    validator: (value) =>
                                        requiredValidator(value!),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.name,
                                    style: TextStyles.textfieldTextStyle,
                                    decoration:
                                        TextFieldDecoration.textfieldDecoration(
                                      hint: "First Name",
                                    ).copyWith(
                                      filled: true,
                                      fillColor: !controller.isReadOnly.value
                                          ? Colors.white
                                          : Colors.grey.shade200,
                                    ),
                                  ),
                                ],
                              ),
                              C10(),
                              paddingWidget(
                                [
                                  const LabelsWithMark(
                                      label: "Middle Name", isRequired: true),
                                  TextFormField(
                                    controller: controller.middleName.value,
                                    enabled: !controller.isReadOnly.value,
                                    cursorColor: AppColors.primary,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    validator: (value) =>
                                        requiredValidator(value!),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.name,
                                    style: TextStyles.textfieldTextStyle,
                                    decoration:
                                        TextFieldDecoration.textfieldDecoration(
                                      hint: "Middle Name",
                                    ).copyWith(
                                      filled: true,
                                      fillColor: !controller.isReadOnly.value
                                          ? Colors.white
                                          : Colors.grey.shade200,
                                    ),
                                  ),
                                ],
                              ),
                              C10(),
                              paddingWidget(
                                [
                                  const LabelsWithMark(
                                      label: "Last Name", isRequired: true),
                                  TextFormField(
                                    controller: controller.lastName.value,
                                    enabled: !controller.isReadOnly.value,
                                    cursorColor: AppColors.primary,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    validator: (value) =>
                                        requiredValidator(value!),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.name,
                                    style: TextStyles.textfieldTextStyle,
                                    decoration:
                                        TextFieldDecoration.textfieldDecoration(
                                      hint: "Last Name",
                                    ).copyWith(
                                      filled: true,
                                      fillColor: !controller.isReadOnly.value
                                          ? Colors.white
                                          : Colors.grey.shade200,
                                    ),
                                  ),
                                ],
                              ),
                              C10(),
                              paddingWidget(
                                [
                                  const LabelsWithMark(label: "Email"),
                                  TextFormField(
                                    controller: controller.email.value,
                                    enabled: !controller.isReadOnly.value,
                                    cursorColor: AppColors.primary,
                                    textCapitalization: TextCapitalization.none,
                                    keyboardType: TextInputType.emailAddress,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: TextStyles.textfieldTextStyle,
                                    decoration:
                                        TextFieldDecoration.textfieldDecoration(
                                      hint: "Email",
                                    ).copyWith(
                                      filled: true,
                                      fillColor: !controller.isReadOnly.value
                                          ? Colors.white
                                          : Colors.grey.shade200,
                                    ),
                                  ),
                                ],
                              ),
                              C10(),
                              paddingWidget(
                                [
                                  const LabelsWithMark(
                                      label: "Gender", isRequired: true),
                                  Obx(() {
                                    final isEnabled =
                                        !controller.isReadOnly.value;

                                    return DropdownButtonFormField<String>(
                                      decoration: TextFieldDecoration
                                          .textfieldDecoration(
                                        hint: "",
                                      ).copyWith(
                                          filled: true,
                                          fillColor:
                                              !controller.isReadOnly.value
                                                  ? Colors.white
                                                  : Colors.grey.shade200),
                                      hint: Text(
                                        "Select Gender",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontFamily: "Roboto-Regular",
                                        ),
                                      ),
                                      style: TextStyles.textfieldTextStyle,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      items:
                                          controller.genderList.map((gender) {
                                        return DropdownMenuItem<String>(
                                          value: gender,
                                          child: Text(
                                            gender,
                                            style:
                                                TextStyles.textfieldTextStyle,
                                          ),
                                        );
                                      }).toList(),
                                      value: controller.genderList.contains(
                                              controller.selectedGender.value)
                                          ? controller.selectedGender.value
                                          : null,
                                      onChanged: isEnabled
                                          ? (value) {
                                              if (value != null) {
                                                controller.selectedGender
                                                    .value = value;
                                              }
                                            }
                                          : null,
                                      disabledHint: controller
                                              .selectedGender.value.isNotEmpty
                                          ? Text(
                                              controller.selectedGender.value)
                                          : Text("Select Gender"),
                                      validator: (value) {
                                        if (controller
                                            .selectedGender.value.isEmpty) {
                                          return 'Gender is required';
                                        }
                                        return null;
                                      },
                                    );
                                  }),
                                ],
                              ),
                              C10(),
                              paddingWidget(
                                [
                                  const LabelsWithMark(
                                      label: "Date Of Birth", isRequired: true),
                                  Obx(
                                    () => TextFormField(
                                      enabled: !controller.isReadOnly.value,
                                      controller: controller.dob.value,
                                      cursorColor: AppColors.primary,
                                      validator: (value) =>
                                          requiredValidator(value!),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      keyboardType: TextInputType.number,
                                      style: TextStyles.textfieldTextStyle,
                                      decoration: TextFieldDecoration
                                          .datePickerDecoration(
                                        hint: "Enter DOB (DD-MM-YYYY)",
                                        onCalendarTap: () =>
                                            controller.selectDate(
                                          context,
                                          controller.dob.value,
                                        ),
                                        isReadOnly: controller.isReadOnly.value,
                                      ),
                                      onChanged: (value) {
                                        controller.updateAgesFromDOB(value);
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9\-]')),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Obx(() {
                                if (!controller.isDobSelected.value)
                                  return SizedBox();
                                return Column(
                                  children: [
                                    C10(),
                                    paddingWidget(
                                      [
                                        const LabelsWithMark(
                                            label: "Entry Age",
                                            isRequired: true),
                                        TextFormField(
                                          enabled: controller.isFormEdit.value,
                                          controller: controller.entryAge.value,
                                          cursorColor: AppColors.primary,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          validator: (value) =>
                                              requiredValidator(value!),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.number,
                                          style: TextStyles.textfieldTextStyle,
                                          decoration: TextFieldDecoration
                                                  .textfieldDecoration(
                                                      hint: "Entry Age")
                                              .copyWith(
                                            filled: true,
                                            fillColor:
                                                controller.isFormEdit.value
                                                    ? Colors.white
                                                    : Colors.grey.shade200,
                                          ),
                                        ),
                                      ],
                                    ),
                                    C10(),
                                    paddingWidget(
                                      [
                                        const LabelsWithMark(
                                            label: "Completed Age",
                                            isRequired: true),
                                        TextFormField(
                                          enabled: controller.isFormEdit.value,
                                          controller:
                                              controller.completedAge.value,
                                          cursorColor: AppColors.primary,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          validator: (value) =>
                                              requiredValidator(value!),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.number,
                                          style: TextStyles.textfieldTextStyle,
                                          decoration: TextFieldDecoration
                                                  .textfieldDecoration(
                                                      hint: "Completed Age")
                                              .copyWith(
                                            filled: true,
                                            fillColor:
                                                controller.isFormEdit.value
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
                              paddingWidget([
                                const LabelsWithMark(
                                    label: "Mobile Number", isRequired: true),
                                TextFormField(
                                  enabled: !controller.isReadOnly.value,
                                  controller: controller.mobileNo.value,
                                  cursorColor: AppColors.primary,
                                  keyboardType: TextInputType.phone,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: TextStyles.textfieldTextStyle,
                                  validator: (value) =>
                                      mobileNoValidator(value!.trim()),
                                  decoration:
                                      TextFieldDecoration.textfieldDecoration(
                                    hint: "Mobile Number",
                                  ).copyWith(
                                          filled: true,
                                          fillColor:
                                              !controller.isReadOnly.value
                                                  ? Colors.white
                                                  : Colors.grey.shade200),
                                  inputFormatters: [
                                    MobileNumberPrefixFormatter(),
                                  ],
                                ),
                              ]),
                              C10(),
                              paddingWidget(
                                [
                                  const LabelsWithMark(
                                    label: "Alternate Mobile Number",
                                  ),
                                  TextFormField(
                                    enabled: !controller.isReadOnly.value,
                                    controller:
                                        controller.alternateMobileNo.value,
                                    cursorColor: AppColors.primary,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyles.textfieldTextStyle,
                                    decoration:
                                        TextFieldDecoration.textfieldDecoration(
                                      hint: "Alternate Mobile Number",
                                    ).copyWith(
                                            filled: true,
                                            fillColor:
                                                !controller.isReadOnly.value
                                                    ? Colors.white
                                                    : Colors.grey.shade200),
                                    inputFormatters: [
                                      MobileNumberPrefixFormatter(),
                                    ],
                                  ),
                                ],
                              ),
                              C10(),
                              imagePickerField(
                                label: "Member Image",
                                showError: controller.memberError,
                                isRequired: true,
                                imageFile: controller.memberImage,
                                imageUrl: RxString(controller
                                        .loanMember.isNotEmpty
                                    ? controller.loanMember[0].memberImage ?? ''
                                    : ''),
                                isFocused: controller.isMemberImageFocused,
                                onTap: () => controller
                                    .pickImage(controller.memberImage),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (file) => imageFileValidator(
                                  localFile: file,
                                  networkUrl: controller.loanMember.isNotEmpty
                                      ? controller.loanMember[0].memberImage
                                      : null,
                                  fieldName: 'Member Image',
                                ),
                              ),
                              C10(),
                              paddingWidget([
                                LabelsWithMark(label: "Group"),
                                Obx(() {
                                  final selectedValue =
                                      controller.selectedGroup.value;
                                  final isValidValue = controller.groupList.any(
                                    (e) => e.name.toString() == selectedValue,
                                  );
                                  final isEnabled =
                                      !controller.isReadOnly.value;

                                  return DropdownButtonFormField2<String>(
                                    isExpanded: true,
                                    value: isValidValue ? selectedValue : null,
                                    hint: Text(
                                      "Select Group",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontFamily: "Roboto-Regular",
                                      ),
                                    ),
                                    items: controller.groupList.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e.name.toString(),
                                        child: Text(
                                          e.groupName.toString(),
                                          style: TextStyles.textfieldTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }).toList(),
                                    style: TextStyles.textfieldTextStyle,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 14),
                                      suffixIcon: (isEnabled &&
                                              selectedValue.isNotEmpty)
                                          ? GestureDetector(
                                              onTap: () {
                                                controller.selectedGroup.value =
                                                    "";
                                              },
                                              child: const Icon(
                                                Icons.close,
                                                size: 18,
                                                color: Colors.grey,
                                              ),
                                            )
                                          : null,
                                      filled: true,
                                      fillColor: isEnabled
                                          ? Colors.white
                                          : Colors.grey.shade200,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade600,
                                          width: 1.2,
                                        ),
                                      ),
                                    ).copyWith(
                                      contentPadding: EdgeInsets.all(-5),
                                    ),
                                    onChanged: isEnabled
                                        ? (value) {
                                            controller.selectedGroup.value =
                                                value ?? '';
                                          }
                                        : null,
                                    disabledHint: isValidValue
                                        ? Text(
                                            controller.groupList
                                                    .firstWhereOrNull((e) =>
                                                        e.name.toString() ==
                                                        selectedValue)
                                                    ?.groupName ??
                                                '',
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : const Text("Select Group"),
                                  );
                                }),
                              ]),
                              C10(),
                              paddingWidget([
                                LabelsWithMark(
                                  label: "Occupation",
                                  isRequired: true,
                                ),
                                Obx(() {
                                  final isEnabled =
                                      !controller.isReadOnly.value;

                                  return DropdownButtonFormField<String>(
                                    value: controller
                                            .selectedOccupation.value.isEmpty
                                        ? null
                                        : controller.selectedOccupation.value,
                                    items: controller.occupationList.map((e) {
                                      return DropdownMenuItem(
                                        value: e.name.toString(),
                                        child: Text(
                                          e.occupation.toString(),
                                          style: TextStyles.textfieldTextStyle
                                        ),
                                      );
                                    }).toList(),
                                    style: TextStyles.textfieldTextStyle,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    hint: Text(
                                      "Select Occupation",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontFamily: "Roboto-Regular",
                                      ),
                                    ),
                                    decoration:
                                        TextFieldDecoration.textfieldDecoration(
                                      hint: "",
                                      sufficIconOntap: () {},
                                      sufficIcon: null,
                                    ).copyWith(
                                            filled: true,
                                            fillColor:
                                                !controller.isReadOnly.value
                                                    ? Colors.white
                                                    : Colors.grey.shade200),
                                    onChanged: isEnabled
                                        ? (value) {
                                            controller.selectedOccupation
                                                .value = value ?? '';
                                          }
                                        : null,
                                    disabledHint: controller
                                            .selectedOccupation.value.isNotEmpty
                                        ? Text(
                                            controller.occupationList
                                                    .firstWhereOrNull(
                                                      (e) =>
                                                          e.name.toString() ==
                                                          controller
                                                              .selectedOccupation
                                                              .value,
                                                    )
                                                    ?.occupation ??
                                                '',
                                          )
                                        : const Text("Select Occupation"),
                                    validator: (value) {
                                      if (controller
                                          .selectedOccupation.value.isEmpty) {
                                        return 'This field can\'t be empty';
                                      }
                                      return null;
                                    },
                                  );
                                }),
                              ]),
                              if (controller.isMemberId.value) ...[
                                C10(),
                                paddingWidget([
                                  const LabelsWithMark(label: "Created By"),
                                  TextFormField(
                                    enabled: !controller.isCreatedBy.value,
                                    controller: controller.createdBy.value,
                                    cursorColor: AppColors.primary,
                                    keyboardType: TextInputType.phone,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: TextStyles.textfieldTextStyle,
                                    decoration:
                                        TextFieldDecoration.textfieldDecoration(
                                      hint: "Created By",
                                    ).copyWith(
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                    ),
                                    inputFormatters: [
                                      MobileNumberPrefixFormatter(),
                                    ],
                                  ),
                                ]),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (controller.isReadOnly.value) {
                              controller.selectedIndex.value = 1;
                              return;
                            }

                            if (_formKey.currentState!.validate()) {
                              if (controller.isMemberId.value) {
                                await controller.updateLoanMember();
                              } else {
                                await controller.saveLoanMember();
                              }
                              controller.selectedIndex.value = 1;
                            } else {
                              AppTostMassage.showTostMassage(
                                massage: "Please fill all required fields",
                              );
                            }
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.primaryOrange,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: const Center(
                              child: Icon(
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
                Obx(() {
                  return controller.isLoading.value
                      ? Container(
                          color: Colors.white.withOpacity(0.3),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryOrange,
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
