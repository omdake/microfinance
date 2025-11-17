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
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
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
                                              enabled:
                                                  !controller.isReadOnly.value,
                                              controller:
                                                  controller.groupName.value,
                                              cursorColor: AppColors.primary,
                                              textCapitalization:
                                                  TextCapitalization.characters,
                                              keyboardType: TextInputType.name,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              validator: (value) =>
                                                  requiredValidator(value!),
                                              style:
                                                  TextStyles.textfieldTextStyle,
                                              decoration: TextFieldDecoration
                                                      .textfieldDecoration(
                                                          hint:
                                                              "Enter Group Name".toUpperCase())
                                                  .copyWith(
                                                filled: true,
                                                fillColor:
                                                    controller.isReadOnly.value
                                                        ? Colors.grey.shade300
                                                        : Colors.white,
                                              ),
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
                                            final validValue =
                                                controller.groupheadList.any(
                                              (e) =>
                                                  e.name ==
                                                  controller
                                                      .selectedGroupHead.value,
                                            )
                                                    ? controller
                                                        .selectedGroupHead.value
                                                    : null;
                                            final isEnabled =
                                                !controller.isReadOnly.value;
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  children: [
                                                    DropdownButtonFormField2<
                                                            String>(
                                                        value: validValue,
                                                        isExpanded: true,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        items: controller
                                                            .groupheadList
                                                            .map((e) {
                                                          return DropdownMenuItem(
                                                            value: e.name
                                                                .toString(),
                                                            child: Text(
                                                              e.memberName ??
                                                                  '',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        style: TextStyles
                                                            .textfieldTextStyle,
                                                        hint: Text(
                                                          "Select Group Head".toUpperCase(),
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey.shade600,
                                                            fontFamily:
                                                                "Roboto-Regular",
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        validator: (value) {
                                                          if (controller
                                                              .selectedGroupHead
                                                              .value
                                                              .isEmpty) {
                                                            return '';
                                                          }
                                                          return null;
                                                        },
                                                        dropdownSearchData:
                                                            DropdownSearchData(
                                                          searchController:
                                                              controller
                                                                  .groupSearchController
                                                                  .value,
                                                          searchInnerWidgetHeight:
                                                              50,
                                                          searchInnerWidget:
                                                              Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child:
                                                                TextFormField(
                                                              cursorColor:
                                                                  Colors.black,
                                                              style: TextStyles
                                                                  .textfieldTextStyle,
                                                              controller: controller
                                                                  .groupSearchController
                                                                  .value,
                                                              decoration:
                                                                  TextFieldDecoration
                                                                      .textfieldDecoration(
                                                                sufficIconOntap:
                                                                    () {},
                                                                sufficIcon:
                                                                    Icons
                                                                        .search,
                                                                hint:
                                                                    'Search group head...',
                                                              ),
                                                            ),
                                                          ),
                                                          searchMatchFn: (item,
                                                              searchValue) {
                                                            if (searchValue
                                                                    .trim()
                                                                    .length <
                                                                3) {
                                                              return true;
                                                            }
                                                            return (item.child
                                                                    is Text &&
                                                                (item.child
                                                                        as Text)
                                                                    .data!
                                                                    .toLowerCase()
                                                                    .contains(
                                                                        searchValue
                                                                            .toLowerCase()));
                                                          },
                                                        ),
                                                        onMenuStateChange:
                                                            (isOpen) {
                                                          if (!isOpen) {
                                                            controller
                                                                .groupSearchController
                                                                .value
                                                                .clear();
                                                          }
                                                        },
                                                        dropdownStyleData:
                                                            DropdownStyleData(
                                                                maxHeight: 500),
                                                        decoration:
                                                            TextFieldDecoration
                                                                .textfieldDecoration(
                                                          hint: "",
                                                          sufficIconOntap:
                                                              () {},
                                                          sufficIcon: null,
                                                        ).copyWith(
                                                          filled: true,
                                                          fillColor: controller
                                                                  .isReadOnly
                                                                  .value
                                                              ? Colors
                                                                  .grey.shade300
                                                              : Colors.white,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(-5),
                                                          errorStyle:
                                                              const TextStyle(
                                                                  height: 0.2),
                                                        ),
                                                        onChanged: isEnabled
                                                            ? (value) {
                                                                controller
                                                                        .selectedGroupHead
                                                                        .value =
                                                                    value ?? '';
                                                              }
                                                            : null),
                                                  ],
                                                ),
                                                Obx(() {
                                                  if (controller
                                                          .showError.value &&
                                                      controller
                                                          .selectedGroupHead
                                                          .value
                                                          .isEmpty) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 13.0),
                                                      child: Text(
                                                        'This Field is required',
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .primaryRed,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return const SizedBox
                                                        .shrink();
                                                  }
                                                })
                                              ],
                                            );
                                          }),
                                        ]),
                                        C10(),
                                        imagePickerField(
                                          label: "Group Image",
                                          imageFile: controller.groupImage,
                                          imageUrl: controller.groupImageUrl,
                                          isFocused:
                                              controller.isgroupImageFocused,
                                          // isEnabled: !controller.isReadOnly.value,
                                          onTap: () => controller
                                              .pickImage(controller.groupImage),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (!controller.isReadOnly.value)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        controller.showError.value = controller
                                            .selectedGroupHead.value.isEmpty;

                                        if (_formKey.currentState!.validate()) {
                                          if (controller.selectedGroupHead.value
                                              .isEmpty) {
                                            AppTostMassage.showTostMassage(
                                              massage:
                                                  "Please select a Group Head",
                                            );
                                            return;
                                          }
                                          if (controller
                                              .name.value.isNotEmpty) {
                                            await controller.updateGroup();
                                          } else {
                                            await controller.saveGroup();
                                          }
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 8),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Submit",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Roboto-Regular",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
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
