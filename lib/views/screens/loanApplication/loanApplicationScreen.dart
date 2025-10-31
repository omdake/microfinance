import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/buttons.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/logic/controller/loanApplication/loanApplicationController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class LoanApplicationScreen extends StatelessWidget {
  LoanApplicationScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final LoanApplicationController controller =
      Get.put(LoanApplicationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Loan Application Creation"),
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
                      paddingWidget([
                        LabelsWithMark(label: "Applicant Name"),
                        Obx(() {
                          return DropdownButtonFormField2<String>(
                            value: controller.selectedMemberName.value.isEmpty
                                ? null
                                : controller.selectedMemberName.value,
                            items: controller.loanMemberAsPerGroup.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.memberName ?? "",
                                child: Text(e.memberName ?? ""),
                              );
                            }).toList(),
                            style: TextStyles.textfieldTextStyle,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: TextFieldDecoration.textfieldDecoration(
                              hint: "",
                              sufficIconOntap: () {},
                              sufficIcon: null,
                            ),
                            hint: Text(
                              "Select Applicant",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontFamily: "Roboto-Regular",
                                fontSize: 12,
                              ),
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController:
                                  controller.loanApplicantSearchController.value,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  style: TextStyles.textfieldTextStyle,
                                  controller:
                                      controller.loanApplicantSearchController.value,
                                  decoration:
                                      TextFieldDecoration.textfieldDecoration(
                                    sufficIconOntap: () {},
                                    sufficIcon: Icons.search,
                                    hint: 'Search group...',
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                if (searchValue.trim().length < 3) {
                                  return true;
                                }
                                return (item.child is Text &&
                                    (item.child as Text)
                                        .data!
                                        .toLowerCase()
                                        .contains(searchValue.toLowerCase()));
                              },
                            ),
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                controller.loanApplicantSearchController.value.clear();
                              }
                            },
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 500,
                            ),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                final selectedMember =
                                    controller.loanMemberAsPerGroup.firstWhere(
                                        (e) => e.memberName == newValue);
                                controller.selectedMemberName.value =
                                    selectedMember.memberName?.trim() ?? "";
                                controller.selectedApplicantId.value =
                                    selectedMember.name ?? "";
                                controller.selectedGroup.value =
                                    selectedMember.group ?? "";

                                controller.getCoBorrowerList(
                                    controller.selectedGroup.value);
                                controller.getNomineeList(
                                    controller.selectedGroup.value);
                                ;
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field can\'t be empty';
                              }
                              return null;
                            },
                          );
                        })
                      ]),
                      C10(),
                      paddingWidget([
                        const LabelsWithMark(label: "Co-Borrower"),
                        Obx(() {
                          return DropdownButtonFormField2<String>(
                            value: controller.selectedCoBorrowerId.value.isEmpty
                                ? null
                                : controller.selectedCoBorrowerId.value,
                            hint: Text(
                              "Select A Co-Borrower Name",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontFamily: "Roboto-Regular",
                                fontSize: 12,
                              ),
                            ),
                             dropdownSearchData: DropdownSearchData(
                              searchController:
                                  controller.coborrowerSearchController.value,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  style: TextStyles.textfieldTextStyle,
                                  controller:
                                      controller.coborrowerSearchController.value,
                                  decoration:
                                      TextFieldDecoration.textfieldDecoration(
                                    sufficIconOntap: () {},
                                    sufficIcon: Icons.search,
                                    hint: 'Search group...',
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                if (searchValue.trim().length < 3) {
                                  return true;
                                }
                                return (item.child is Text &&
                                    (item.child as Text)
                                        .data!
                                        .toLowerCase()
                                        .contains(searchValue.toLowerCase()));
                              },
                            ),
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                controller.coborrowerSearchController.value.clear();
                              }
                            },
                            items: controller.coBorrowerList.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.name ?? "",
                                child: Text(e.memberName ?? ""),
                              );
                            }).toList(),
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                              sufficIconOntap: () {},
                              sufficIcon: null,
                              hint: '',
                            ),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                controller.selectedCoBorrowerId.value =
                                    newValue;
                                final selected = controller.coBorrowerList
                                    .firstWhere((e) => e.name == newValue);
                                controller.selectedCoBorrower.value =
                                    selected.memberName ?? "";
                              }
                            },
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
                            value: controller.selectedProduct.value.isEmpty
                                ? null
                                : controller.selectedProduct.value,
                            hint: Text(
                              "Select a Product",
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontFamily: "Roboto-Regular",
                                  fontSize: 12),
                            ),
                            items: controller.productList.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.productName ?? "",
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e.productName ?? ""),
                                    C10(),
                                    Text(
                                      "Max Amount: ${e.maximumLoanAmount ?? ''}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade700,
                                          fontFamily: "Roboto-regular"),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (e.rateOfInterest != null) ...[
                                      Text(" , ",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade700,
                                              fontFamily: "Roboto-regular")),
                                      Text(
                                        "ROI: ${e.rateOfInterest!}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade700,
                                            fontFamily: "Roboto-regular"),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            }).toList(),
                            selectedItemBuilder: (context) {
                              return controller.productList.map((e) {
                                return Text(
                                  e.productName ?? "",
                                  style: TextStyles.textfieldTextStyle,
                                );
                              }).toList();
                            },
                            onChanged: (newValue) {
                              if (newValue != null) {
                                controller.selectedProduct.value = newValue;
                                final productMap = {
                                  for (var e in controller.productList)
                                    e.productName!: e
                                };
                                controller.selectedproductId.value =
                                    productMap[newValue]?.name ?? "";
                              }
                            },
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                              sufficIconOntap: () {},
                              sufficIcon: null,
                              hint: "",
                            ),
                          );
                        })
                      ]),
                      C10(),
                      paddingWidget(
                        [
                          const LabelsWithMark(
                              label: "Amount", isRequired: true),
                          TextFormField(
                            controller: controller.loanAmount.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) => requiredValidator(value!),
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
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
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyles.textfieldTextStyle,
                            validator: (value) => requiredValidator(value!),
                            decoration: TextFieldDecoration.textfieldDecoration(
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
                            value: controller.selectednominee.value.isEmpty
                                ? null
                                : controller.selectednominee.value,
                            hint: Text(
                              "Select A Nominee Name",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontFamily: "Roboto-Regular",
                                fontSize: 12,
                              ),
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController:
                                  controller.nomineeSearchController.value,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  style: TextStyles.textfieldTextStyle,
                                  controller:
                                      controller.nomineeSearchController.value,
                                  decoration:
                                      TextFieldDecoration.textfieldDecoration(
                                    sufficIconOntap: () {},
                                    sufficIcon: Icons.search,
                                    hint: 'Search group...',
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                if (searchValue.trim().length < 3) {
                                  return true;
                                }
                                return (item.child is Text &&
                                    (item.child as Text)
                                        .data!
                                        .toLowerCase()
                                        .contains(searchValue.toLowerCase()));
                              },
                            ),
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                controller.nomineeSearchController.value.clear();
                              }
                            },
                            items: controller.nomineeList.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.memberName ?? "",
                                child: Text(e.memberName ?? ""),
                              );
                            }).toList(),
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                              sufficIconOntap: () {},
                              sufficIcon: null,
                              hint: '',
                            ),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                controller.selectednominee.value = newValue;
                                final memberMap = {
                                  for (var e in controller.nomineeList)
                                    e.memberName!: e
                                };
                                controller.selectedNomineeId.value =
                                    memberMap[newValue]?.name ?? "";

                                controller.getRelationList();
                              }
                            },
                          );
                        })
                      ]),
                      C10(),
                      paddingWidget(
                        [
                          const LabelsWithMark(
                              label: "Relation", isRequired: true),
                          Obx(() {
                            return DropdownButtonFormField<String>(
                              hint: Text(
                                "Select A Relation With Applicant",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontFamily: "Roboto-Regular",
                                    fontSize: 12),
                              ),
                              value: controller.selectedRelation.value.isEmpty
                                  ? null
                                  : controller.selectedRelation.value,
                              items: controller.RelationList.map((e) {
                                return DropdownMenuItem<String>(
                                  value: e.value,
                                  child: Text(e.value ?? ""),
                                );
                              }).toList(),
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                sufficIconOntap: () {},
                                sufficIcon: null,
                                hint: "",
                              ),
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  controller.selectedRelation.value = newValue;
                                }
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
                            controller: controller.description.value,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.name,
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                hint: "Description"),
                          ),
                        ],
                      ),
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
