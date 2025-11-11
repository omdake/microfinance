import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/nav_bar.dart';
import 'package:microfinance/logic/controller/loanApplication/loanApplicationController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';
import 'package:microfinance/views/screens/loanApplication/loanApplicationSuccess.dart';

class LoanApplicationScreen extends StatelessWidget {
  LoanApplicationScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final LoanApplicationController controller =
      Get.put(LoanApplicationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          elevation: 0,
          title: Text(
            " Create Loan Application",
            style: TextStyles.appbartitle,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
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
                      "APPLICANT DETAILS",
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
                                    paddingWidget([
                                      LabelsWithMark(
                                          label: "Applicant Name",
                                          isRequired: true),
                                      Obx(() {
                                        return DropdownButtonFormField2<String>(
                                          value: controller.selectedApplicantId
                                                  .value.isEmpty
                                              ? null
                                              : controller
                                                  .selectedApplicantId.value,
                                          items: controller.loanMemberAsPerGroup
                                              .map((e) {
                                            return DropdownMenuItem<String>(
                                              value: e.name ?? "",
                                              child: Text(e.memberName ?? ""),
                                            );
                                          }).toList(),
                                          style: TextStyles.textfieldTextStyle,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: TextFieldDecoration
                                              .textfieldDecoration(
                                            hint: "",
                                            sufficIconOntap: () {},
                                            sufficIcon: null,
                                          ).copyWith(
                                            contentPadding: EdgeInsets.all(-5),
                                          ),
                                          hint: Text(
                                            "Select Applicant",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontFamily: "Roboto-Regular",
                                              fontSize: 12,
                                            ),
                                          ),
                                          dropdownSearchData:
                                              DropdownSearchData(
                                            searchController: controller
                                                .loanApplicantSearchController
                                                .value,
                                            searchInnerWidgetHeight: 50,
                                            searchInnerWidget: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: TextFormField(
                                                cursorColor: Colors.black,
                                                style: TextStyles
                                                    .textfieldTextStyle,
                                                controller: controller
                                                    .loanApplicantSearchController
                                                    .value,
                                                decoration: TextFieldDecoration
                                                    .textfieldDecoration(
                                                  sufficIconOntap: () {},
                                                  sufficIcon: Icons.search,
                                                  hint: 'Search Applicant...',
                                                ),
                                              ),
                                            ),
                                            searchMatchFn: (item, searchValue) {
                                              if (searchValue.trim().length <
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
                                                  .loanApplicantSearchController
                                                  .value
                                                  .clear();
                                            }
                                          },
                                          dropdownStyleData: DropdownStyleData(
                                            maxHeight: 500,
                                          ),
                                          onChanged: (newValue) {
                                            if (newValue != null) {
                                              final selectedMember = controller
                                                  .loanMemberAsPerGroup
                                                  .firstWhere((e) =>
                                                      e.name == newValue);
                                              controller.selectedMemberName
                                                  .value = selectedMember
                                                      .memberName
                                                      ?.trim() ??
                                                  "";
                                              controller.selectedApplicantId
                                                      .value =
                                                  selectedMember.name ?? "";
                                              controller.selectedGroup.value =
                                                  selectedMember.group ?? "";

                                              controller.getCoBorrowerList(
                                                  controller
                                                      .selectedGroup.value);
                                              controller.getNomineeList(
                                                  controller
                                                      .selectedGroup.value);
                                              controller.selectedCoBorrowerId
                                                  .value = "";
                                              controller.selectedCoBorrower
                                                  .value = "";
                                              controller.selectednominee.value =
                                                  "";
                                              controller
                                                  .selectedNomineeId.value = "";
                                            }
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'This field can\'t be empty';
                                            }
                                            return null;
                                          },
                                        );
                                      })
                                    ]),
                                    C10(),
                                    paddingWidget([
                                      const LabelsWithMark(
                                          label: "Co-Borrower"),
                                      Obx(() {
                                        return Stack(
                                          alignment: Alignment.centerRight,
                                          children: [
                                            DropdownButtonFormField2<String>(
                                              value: controller
                                                      .selectedCoBorrowerId
                                                      .value
                                                      .isEmpty
                                                  ? null
                                                  : controller
                                                      .selectedCoBorrowerId
                                                      .value,
                                              hint: Text(
                                                "Select A Co-Borrower Name",
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontFamily: "Roboto-Regular",
                                                  fontSize: 12,
                                                ),
                                              ),
                                              dropdownSearchData:
                                                  DropdownSearchData(
                                                searchController: controller
                                                    .coborrowerSearchController
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
                                                        .coborrowerSearchController
                                                        .value,
                                                    decoration:
                                                        TextFieldDecoration
                                                            .textfieldDecoration(
                                                      sufficIconOntap: () {},
                                                      sufficIcon: Icons.search,
                                                      hint:
                                                          'Search Co-Borrower...',
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
                                                      .coborrowerSearchController
                                                      .value
                                                      .clear();
                                                }
                                              },
                                              items: controller.coBorrowerList
                                                  .map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e.name ?? "",
                                                  child:
                                                      Text(e.memberName ?? ""),
                                                );
                                              }).toList(),
                                              style:
                                                  TextStyles.textfieldTextStyle,
                                              decoration: TextFieldDecoration
                                                  .textfieldDecoration(
                                                hint: '',
                                                sufficIcon: null,
                                              ).copyWith(
                                                contentPadding:
                                                    EdgeInsets.all(-5),
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                maxHeight: 500,
                                              ),
                                              onChanged: (newValue) {
                                                if (newValue != null) {
                                                  controller
                                                      .selectedCoBorrowerId
                                                      .value = newValue;
                                                  final selected = controller
                                                      .coBorrowerList
                                                      .firstWhere((e) =>
                                                          e.name == newValue);
                                                  controller.selectedCoBorrower
                                                          .value =
                                                      selected.memberName ?? "";
                                                }
                                              },
                                            ),
                                            if (controller.selectedCoBorrowerId
                                                .value.isNotEmpty)
                                              Positioned(
                                                right: 40,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .selectedCoBorrowerId
                                                        .value = "";
                                                    controller
                                                        .selectedCoBorrower
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
                                    paddingWidget([
                                      const LabelsWithMark(
                                        label: "Loan Product",
                                        isRequired: true,
                                      ),
                                      Obx(() {
                                        return DropdownButtonFormField<String>(
                                          value: controller
                                                  .selectedProduct.value.isEmpty
                                              ? null
                                              : controller
                                                  .selectedProduct.value,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          hint: Text(
                                            "Select a Product",
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontFamily: "Roboto-Regular",
                                                fontSize: 12),
                                          ),
                                          items:
                                              controller.productList.map((e) {
                                            return DropdownMenuItem<String>(
                                              value: e.productName ?? "",
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(e.productName ?? ""),
                                                  C10(),
                                                  Text(
                                                    "Max Amount: ${e.maximumLoanAmount ?? ''}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade700,
                                                        fontFamily:
                                                            "Roboto-regular"),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  if (e.rateOfInterest !=
                                                      null) ...[
                                                    Text(" , ",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey.shade700,
                                                            fontFamily:
                                                                "Roboto-regular")),
                                                    Text(
                                                      "ROI: ${e.rateOfInterest!}",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .grey.shade700,
                                                          fontFamily:
                                                              "Roboto-regular"),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                          selectedItemBuilder: (context) {
                                            return controller.productList
                                                .map((e) {
                                              return Text(
                                                e.productName ?? "",
                                                style: TextStyles
                                                    .textfieldTextStyle,
                                              );
                                            }).toList();
                                          },
                                          onChanged: (newValue) {
                                            if (newValue != null) {
                                              controller.selectedProduct.value =
                                                  newValue;
                                              final productMap = {
                                                for (var e
                                                    in controller.productList)
                                                  e.productName!: e
                                              };
                                              controller
                                                      .selectedproductId.value =
                                                  productMap[newValue]?.name ??
                                                      "";
                                            }
                                          },
                                          style: TextStyles.textfieldTextStyle,
                                          decoration: TextFieldDecoration
                                              .textfieldDecoration(
                                            sufficIconOntap: () {},
                                            sufficIcon: null,
                                            hint: "",
                                          ),
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
                                            label: "Amount", isRequired: true),
                                        TextFormField(
                                          controller:
                                              controller.loanAmount.value,
                                          cursorColor: AppColors.primary,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          validator: (value) =>
                                              requiredValidator(value!),
                                          keyboardType: TextInputType.number,
                                          style: TextStyles.textfieldTextStyle,
                                          decoration: TextFieldDecoration
                                              .textfieldDecoration(
                                                  hint: "Amount"),
                                        ),
                                      ],
                                    ),
                                    C10(),
                                    paddingWidget(
                                      [
                                        const LabelsWithMark(
                                            label: "Period", isRequired: true),
                                        TextFormField(
                                          controller: controller.periods.value,
                                          cursorColor: AppColors.primary,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          keyboardType: TextInputType.number,
                                          style: TextStyles.textfieldTextStyle,
                                          validator: (value) =>
                                              requiredValidator(value!),
                                          decoration: TextFieldDecoration
                                              .textfieldDecoration(
                                            hint: "Period",
                                          ),
                                        ),
                                      ],
                                    ),
                                    C10(),
                                    paddingWidget([
                                      const LabelsWithMark(
                                          label: "Nominee", isRequired: true),
                                      Obx(() {
                                        return DropdownButtonFormField2<String>(
                                          value: controller
                                                  .selectednominee.value.isEmpty
                                              ? null
                                              : controller
                                                  .selectednominee.value,
                                          hint: Text(
                                            "Select A Nominee Name",
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontFamily: "Roboto-Regular",
                                              fontSize: 12,
                                            ),
                                          ),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          dropdownSearchData:
                                              DropdownSearchData(
                                            searchController: controller
                                                .nomineeSearchController.value,
                                            searchInnerWidgetHeight: 50,
                                            searchInnerWidget: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: TextFormField(
                                                cursorColor: Colors.black,
                                                style: TextStyles
                                                    .textfieldTextStyle,
                                                controller: controller
                                                    .nomineeSearchController
                                                    .value,
                                                decoration: TextFieldDecoration
                                                    .textfieldDecoration(
                                                  sufficIconOntap: () {},
                                                  sufficIcon: Icons.search,
                                                  hint: 'Search nominee...',
                                                ),
                                              ),
                                            ),
                                            searchMatchFn: (item, searchValue) {
                                              if (searchValue.trim().length <
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
                                                  .nomineeSearchController.value
                                                  .clear();
                                            }
                                          },
                                          dropdownStyleData: DropdownStyleData(
                                            maxHeight: 500,
                                          ),
                                          items:
                                              controller.nomineeList.map((e) {
                                            return DropdownMenuItem<String>(
                                              value: e.memberName ?? "",
                                              child: Text(e.memberName ?? ""),
                                            );
                                          }).toList(),
                                          style: TextStyles.textfieldTextStyle,
                                          decoration: TextFieldDecoration
                                              .textfieldDecoration(
                                            sufficIconOntap: () {},
                                            sufficIcon: null,
                                            hint: '',
                                          ).copyWith(
                                            contentPadding: EdgeInsets.all(-5),
                                          ),
                                          onChanged: (newValue) {
                                            if (newValue != null) {
                                              controller.selectednominee.value =
                                                  newValue;
                                              final memberMap = {
                                                for (var e
                                                    in controller.nomineeList)
                                                  e.memberName!: e
                                              };
                                              controller
                                                      .selectedNomineeId.value =
                                                  memberMap[newValue]?.name ??
                                                      "";

                                              controller.getRelationList();
                                            }
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
                                            label: "Relation",
                                            isRequired: true),
                                        Obx(() {
                                          return DropdownButtonFormField<
                                              String>(
                                            hint: Text(
                                              "Select A Relation With Applicant",
                                              style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontFamily: "Roboto-Regular",
                                                  fontSize: 12),
                                            ),
                                            value: controller.selectedRelation
                                                    .value.isEmpty
                                                ? null
                                                : controller
                                                    .selectedRelation.value,
                                                    autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                            items: controller.RelationList.map(
                                                (e) {
                                              return DropdownMenuItem<String>(
                                                value: e.value,
                                                child: Text(e.value ?? ""),
                                              );
                                            }).toList(),
                                            style:
                                                TextStyles.textfieldTextStyle,
                                            decoration: TextFieldDecoration
                                                .textfieldDecoration(
                                              sufficIconOntap: () {},
                                              sufficIcon: null,
                                              hint: "",
                                            ),
                                            onChanged: (newValue) {
                                              if (newValue != null) {
                                                controller.selectedRelation
                                                    .value = newValue;
                                              }
                                            },
                                            validator: (value) {
                                              if (value == null) {
                                                return 'This field can\'t be empty';
                                              }
                                              return null;
                                            },
                                          );
                                        })
                                      ],
                                    ),
                                    C10(),
                                    paddingWidget(
                                      [
                                        LabelsWithMark(label: "Description"),
                                        TextFormField(
                                          controller:
                                              controller.description.value,
                                          cursorColor: AppColors.primary,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          keyboardType: TextInputType.name,
                                          style: TextStyles.textfieldTextStyle,
                                          decoration: TextFieldDecoration
                                              .textfieldDecoration(
                                                  hint: "Description"),
                                        ),
                                      ],
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
                                    await controller.saveLoanMember();

                                    Get.off(() => LoanApplicationSuccessScreen(
                                          crNo: controller
                                              .selectedApplicantId.value,
                                          applicantName: controller
                                              .selectedMemberName.value,
                                          amount:
                                              controller.loanAmount.value.text,
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
