import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/nav_bar.dart';
import 'package:microfinance/common_widgets/uploadFile.dart';
import 'package:microfinance/logic/controller/dashboard/homeController.dart';
import 'package:microfinance/logic/controller/groupCreation/groupScreenController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';
import 'package:microfinance/views/screens/groupCreation/groupCreationSuccess.dart';

class GroupCreationScreen extends StatelessWidget {
  GroupCreationScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final GroupScreenController controller = Get.put(GroupScreenController());
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          elevation: 0,
          title: Text(
            " Create Group ",
            style: TextStyles.appbartitle,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.offAllNamed(Routes.groupList);
              },
              icon: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              )),
        ),
        bottomNavigationBar: const CustomBottomNavBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Center(
                    child: Text(
                      "GROUP DETAILS",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Roboto-Regular",
                        color: Color(0xFF050708),
                      ),
                    ),
                  ),
                ),
                C10(),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    paddingWidget(
                                      [
                                        LabelsWithMark(
                                          label: "Group Name",
                                          isRequired: true,
                                        ),
                                        TextFormField(
                                          enabled: !controller.isReadOnly.value,
                                          controller:
                                              controller.groupName.value,
                                          cursorColor: AppColors.primary,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          keyboardType: TextInputType.name,
                                          validator: (value) =>
                                              requiredValidator(value!),
                                          style: TextStyles.textfieldTextStyle,
                                          decoration: TextFieldDecoration
                                              .textfieldDecoration(
                                                  hint: "Enter Group Name"),
                                        ),
                                      ],
                                    ),
                                    C10(),
                                    paddingWidget([
                                      LabelsWithMark(
                                        label: "Group Head",
                                        isRequired: true,
                                      ),
                                      Obx(() {
                                        return Stack(
                                          alignment: Alignment.centerRight,
                                          children: [
                                            DropdownButtonFormField2<String>(
                                              value: controller
                                                      .selectedGroupHead
                                                      .value
                                                      .isEmpty
                                                  ? null
                                                  : controller
                                                      .selectedGroupHead.value,
                                              isExpanded: true,
                                              items: controller.groupheadList
                                                  .map((e) {
                                                return DropdownMenuItem(
                                                  value: e.name.toString(),
                                                  child: Text(
                                                    e.memberName ?? '',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                );
                                              }).toList(),
                                              style:
                                                  TextStyles.textfieldTextStyle,
                                              hint: Text(
                                                "Select Group Head",
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontFamily: "Roboto-Regular",
                                                  fontSize: 12,
                                                ),
                                              ),
                                              validator: (value) {
                                                if (controller.selectedGroupHead
                                                    .value.isEmpty) {
                                                  return 'Group Head is required';
                                                }
                                                return null;
                                              },
                                              dropdownSearchData:
                                                  DropdownSearchData(
                                                searchController: controller
                                                    .groupSearchController
                                                    .value,
                                                searchInnerWidgetHeight: 50,
                                                searchInnerWidget: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: TextFormField(
                                                    cursorColor: Colors.black,
                                                    style: TextStyles
                                                        .textfieldTextStyle,
                                                    controller: controller
                                                        .groupSearchController
                                                        .value,
                                                    decoration:
                                                        TextFieldDecoration
                                                            .textfieldDecoration(
                                                      sufficIconOntap: () {},
                                                      sufficIcon: Icons.search,
                                                      hint:
                                                          'Search group head...',
                                                    ),
                                                  ),
                                                ),
                                                searchMatchFn:
                                                    (item, searchValue) {
                                                  if (searchValue
                                                          .trim()
                                                          .length <
                                                      3) {
                                                    return true;
                                                  }
                                                  return (item.child is Text &&
                                                      (item.child as Text)
                                                          .data!
                                                          .toLowerCase()
                                                          .contains(searchValue
                                                              .toLowerCase()));
                                                },
                                              ),
                                              onMenuStateChange: (isOpen) {
                                                if (!isOpen) {
                                                  controller
                                                      .groupSearchController
                                                      .value
                                                      .clear();
                                                }
                                              },
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                maxHeight: 500,
                                              ),
                                              decoration: TextFieldDecoration
                                                  .textfieldDecoration(
                                                hint: "",
                                                sufficIconOntap: () {},
                                                sufficIcon: null,
                                              ).copyWith(
                                                contentPadding:
                                                    const EdgeInsets.all(-5),
                                              ),
                                              onChanged: (value) {
                                                controller.selectedGroupHead
                                                    .value = value!;
                                              },
                                            ),
                                            if (controller.selectedGroupHead
                                                .value.isNotEmpty)
                                              Positioned(
                                                right: 40,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.selectedGroupHead
                                                        .value = "";
                                                  },
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 18,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        );
                                      }),
                                    ]),
                                    C10(),
                                    imagePickerField(
                                      label: "Group Image",
                                      imageFile: controller.groupImage,
                                      imageUrl: controller.groupImageUrl,
                                      isFocused: controller.isgroupImageFocused,
                                      isEnabled: !controller.isReadOnly.value,
                                      onTap: () => controller
                                          .pickImage(controller.groupImage),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    controller.saveGroup();
                                    Get.off(() => GroupCreationSuccess(
                                          applicantName:
                                              controller.groupName.value.text,
                                          group: controller
                                              .selectedGroupHead.value,
                                        ));
                                  } else {
                                    AppTostMassage.showTostMassage(
                                      massage:
                                          "Please fill all required fields",
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
