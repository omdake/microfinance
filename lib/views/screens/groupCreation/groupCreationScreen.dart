import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/buttons.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/uploadFile.dart'
    show imagePickerField;
import 'package:microfinance/logic/controller/groupCreation/groupScreenController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class GroupCreationScreen extends StatelessWidget {
  GroupCreationScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final GroupScreenController controller = Get.put(GroupScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Group Create"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        }

        return Container(
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
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      paddingWidget(
                        [
                          const LabelsWithMark(
                              label: "Group Code", isRequired: true),
                          TextFormField(
                            enabled: !controller.isReadOnly.value,
                            controller: controller.groupCode.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) => requiredValidator(value!),
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                hint: "Enter Group Code"),
                          ),
                        ],
                      ),
                      C10(),
                      paddingWidget(
                        [
                          LabelsWithMark(label: "Group Name "),
                          TextFormField(
                            enabled: !controller.isReadOnly.value,
                            controller: controller.groupName.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                hint: "Enter Group Name"),
                          ),
                        ],
                      ),
                      C10(),
                      paddingWidget([
                        LabelsWithMark(label: "Group Head"),
                        Obx(() {
                          return DropdownButtonFormField2<String>(
                            value: controller.selectedGroupHead.value.isEmpty
                                ? null
                                : controller.selectedGroupHead.value,
                            isExpanded: true,
                            items: controller.groupheadList.map((e) {
                              return DropdownMenuItem(
                                value: e.name.toString(),
                                child: Text(
                                  e.memberName ?? '',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            style: TextStyles.textfieldTextStyle,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 500,
                            ),
                            decoration: TextFieldDecoration.textfieldDecoration(
                                hint: "Select Group Head",
                                sufficIconOntap: () {},
                                sufficIcon: null),
                            onChanged: (value) {
                              controller.selectedGroupHead.value = value!;
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
                      imagePickerField(
                        label: "Group Image",
                        imageFile: controller.groupImage, // Rx<File?>
                        imageUrl: controller
                            .groupImageUrl, // Optional: RxString if you have URL
                        isFocused: controller.isgroupImageFocused,
                        isEnabled: !controller.isReadOnly
                            .value, // Enable/disable based on controller
                        onTap: () =>
                            controller.pickImage(controller.groupImage),
                        isRequired: false,
                      ),
                      C50(),
                      Obx(
                        () => controller.isReadOnly.value
                            ? SizedBox.shrink()
                            : AppButton(
                                title: "save",
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    controller.saveGroup();
                                  } else {
                                    AppTostMassage.showTostMassage(
                                      massage:
                                          "Please fill all required fields",
                                    );
                                  }
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
