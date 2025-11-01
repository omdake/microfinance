import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/logic/controller/loanApplication/loanlistController.dart';

import 'package:microfinance/models/loan_applicant_list.model.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/load_more_listview.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class LoanApplicationList extends StatelessWidget {
  const LoanApplicationList({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoanApplicationListController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Loan Application List"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              Obx(() {
                return DropdownButtonFormField2<String>(
                  value: controller.selectedGroup.value,
                  hint: Text(
                    "Select A Group Name",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: "Roboto-Regular",
                      fontSize: 12,
                    ),
                  ),
                  items: [
                    const DropdownMenuItem<String>(
                      value: "",
                      child: Text("All Group"),
                    ),
                    ...controller.groupList.map((e) {
                      return DropdownMenuItem<String>(
                        value: e.name ?? "",
                        child: Text(
                          e.groupName ?? "",
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ],
                  dropdownSearchData: DropdownSearchData(
                    searchController: controller.groupSearchController.value,
                    searchInnerWidgetHeight: 50,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyles.textfieldTextStyle,
                        controller: controller.groupSearchController.value,
                        decoration: TextFieldDecoration.textfieldDecoration(
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
                      controller.groupSearchController.value.clear();
                    }
                  },
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 500,
                  ),
                  isExpanded: true,
                  style: TextStyles.textfieldTextStyle,
                  decoration: TextFieldDecoration.textfieldDecoration(
                    sufficIconOntap: () {},
                    sufficIcon: null,
                    hint: '',
                  ).copyWith(
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (newGroup) {
                    controller.page.value = 1;
                    controller.loanApplicantList.clear();
                    controller.selectedGroup.value = newGroup ?? "All Group";
                    if (controller.selectedGroup.value.isEmpty) {
                      controller.getAplicantList(page: controller.page.value);
                    } else {
                      controller.getAplicantList(
                        page: controller.page.value,
                        loanGroup: controller.selectedGroup.value,
                      );
                    }
                  },
                );
              }),
              C25(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }

                  if (controller.loanApplicantList.isEmpty) {
                    return const Center(child: Text("No members found"));
                  }

                  return LoadMoreListView(
                    loadData: () => controller.getloadData(),
                    loadMoreData: () => controller.getLoadMoreData(),
                    children: controller.loanApplicantList.map((user) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              final args = {
                                "applicant": user,
                                "isReadOnly": true,
                              };
                              Get.toNamed(
                                Routes.loanApplicationViewonly,
                                arguments: args,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Applicant Id: ",
                                                style: TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "${user.name ?? ""}",
                                                style: const TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Applicant Name: ",
                                                style: TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${user.applicantName ?? ""}",
                                                style: const TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Loan Product: ",
                                                style: TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${user.loanProduct ?? ""}",
                                                style: const TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Loan Amount: ",
                                                style: TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${user.loanAmount ?? ""}",
                                                style: const TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade600,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    child: Text(
                                      user.workflowState ?? "-",
                                      style: const TextStyle(
                                        fontFamily: "Roboto-Medium",
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(color: Colors.grey),
                        ],
                      );
                    }).toList(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.toNamed(Routes.loanApplication);
          final newApplicant = LoanApplicantListResult(); // empty model
          Get.toNamed(Routes.loanApplication, arguments: {
            "applicant": newApplicant,
            "isReadOnly": false,
          });
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        tooltip: "Add Payment Proof",
      ),
    );
  }
}
