import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/buttons.dart';
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
                              label: "First Name", isRequired: true),
                          TextFormField(
                            controller: controller.firstName.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) => requiredValidator(value!),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                hint: "First Name"),
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
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) => requiredValidator(value!),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                hint: "Middle Name"),
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
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) => requiredValidator(value!),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                hint: "Last Name"),
                          ),
                        ],
                      ),
                      C10(),
                      paddingWidget(
                        [
                          const LabelsWithMark(
                              label: "Email", isRequired: true),
                          TextFormField(
                            controller: controller.email.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: TextStyles.textfieldTextStyle,
                            validator: (value) =>
                                commonValidator(value!.trim()),
                            decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Email",
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
                            return DropdownButtonFormField<String>(
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                hint: "Select Gender",
                              ),
                              style: TextStyles.textfieldTextStyle,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              items: controller.genderList.map((gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender),
                                );
                              }).toList(),
                              value: controller.selectedGender.value.isNotEmpty
                                  ? controller.selectedGender.value
                                  : null,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectedGender.value = value;
                                }
                              },
                              validator: (value) {
                                if (controller.selectedGender.value.isEmpty) {
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
                              controller: controller.dob.value,
                              cursorColor: AppColors.primary,
                              readOnly: true,
                              onTap: () => controller.selectDate(
                                  context, controller.dob.value),
                              validator: (value) => requiredValidator(value!),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecorationicon(
                                hint: "Date Of Birth",
                                sufficIcon: Icons.calendar_today,
                                sufficIconOntap: () => controller.selectDate(
                                    context, controller.dob.value),
                              ),
                            ),
                          ),
                        ],
                      ),
                      C10(),
                      Obx(() {
                        if (!controller.isDobSelected.value) return SizedBox();
                        return Column(
                          children: [
                            paddingWidget(
                              [
                                const LabelsWithMark(
                                    label: "Entry Age", isRequired: true),
                                TextFormField(
                                  readOnly: true,
                                  controller: controller.entryAge.value,
                                  cursorColor: AppColors.primary,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (value) =>
                                      requiredValidator(value!),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.number,
                                  style: TextStyles.textfieldTextStyle,
                                  decoration:
                                      TextFieldDecoration.textfieldDecoration(
                                          hint: "Age"),
                                ),
                              ],
                            ),
                            C10(),
                            paddingWidget(
                              [
                                const LabelsWithMark(
                                    label: "Completed Age", isRequired: true),
                                TextFormField(
                                  readOnly: true,
                                  controller: controller.completedAge.value,
                                  cursorColor: AppColors.primary,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (value) =>
                                      requiredValidator(value!),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.number,
                                  style: TextStyles.textfieldTextStyle,
                                  decoration:
                                      TextFieldDecoration.textfieldDecoration(
                                          hint: "Age"),
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
                          controller: controller.mobileNo.value,
                          cursorColor: AppColors.primary,
                          keyboardType: TextInputType.phone,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyles.textfieldTextStyle,
                          validator: (value) =>
                              mobileNoValidator(value!.trim()),
                          decoration: TextFieldDecoration.textfieldDecoration(
                            hint: "Mobile Number",
                          ),
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
                            controller: controller.alternateMobileNo.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.phone,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "Mobile Number",
                            ),
                            inputFormatters: [
                              MobileNumberPrefixFormatter(),
                            ],
                          ),
                        ],
                      ),
                      C10(),
                      imagePickerField(
                        label: "Member Image",isRequired: true,
                        imageFile: controller.memberImage,
                        imageUrl: RxString(controller.loanMember.isNotEmpty
                            ? controller.loanMember[0].memberImage ?? ''
                            : ''),
                        isFocused: controller.isMemberImageFocused,
                        onTap: () =>
                            controller.pickImage(controller.memberImage),
                      ),
                      C10(),
                      paddingWidget([
                        LabelsWithMark(label: "Group",isRequired: true,),
                        Obx(() {
                          return DropdownButtonFormField<String>(
                            value: controller.selectedGroup.value.isEmpty
                                ? null
                                : controller.selectedGroup.value,
                            items: controller.groupList.map((e) {
                              return DropdownMenuItem(
                                value: e.name.toString(),
                                child: Text(e.groupName.toString()),
                              );
                            }).toList(),
                            style: TextStyles.textfieldTextStyle,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                hint: "Select Group",
                                sufficIconOntap: () {},
                                sufficIcon: null),
                            onChanged: (value) {
                              controller.selectedGroup.value = value!;
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
                      paddingWidget([
                        LabelsWithMark(label: "Occupation",isRequired: true,),
                        Obx(() {
                          return DropdownButtonFormField<String>(
                            value: controller.selectedOccupation.value.isEmpty
                                ? null
                                : controller.selectedOccupation.value,
                            items: controller.occupationList.map((e) {
                              return DropdownMenuItem(
                                value: e.name.toString(),
                                child: Text(e.occupation.toString()),
                              );
                            }).toList(),
                            style: TextStyles.textfieldTextStyle,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                hint: "Select Occupation",
                                sufficIconOntap: () {},
                                sufficIcon: null),
                            onChanged: (value) {
                              controller.selectedOccupation.value = value!;
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
                      AppButton(
                          title: "save",
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              controller.saveLoanMember();
                            } else {
                              AppTostMassage.showTostMassage(
                                massage: "Please fill all required fields",
                              );
                            }
                          })
                    ])),
              ),
            ),
          )),
    );
  }
}
