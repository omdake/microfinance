import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/logic/controller/loanApplication/loanlistController.dart';

import 'package:microfinance/models/loan_applicant_list.model.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
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
                  value: controller.selectedGroup.value.isEmpty
                      ? null
                      : controller.selectedGroup.value,
                  hint: Text(
                    "Select A Group Name",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: "Roboto-Regular",
                      fontSize: 12,
                    ),
                  ),
                  items: controller.groupList.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.name ?? "",
                      child: Text(
                        e.groupName ?? "",
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 500,
                  ),
                  isExpanded: true,
                  style: TextStyles.textfieldTextStyle,
                  decoration: TextFieldDecoration.textfieldDecoration(
                    sufficIconOntap: () {},
                    sufficIcon: null,
                    hint: '',
                  ),
                  onChanged: (newGroup) {
                    controller.selectedGroup.value = newGroup!;
                    controller.loanApplicantList.clear();
                    controller.getAplicantList();
                  },
                );
              }),
              C25(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  }
                  if (controller.loanApplicantList.isEmpty) {
                    return const Center(child: Text("No members found"));
                  }
                  return ListView.builder(
                    itemCount: controller.loanApplicantList.length,
                    itemBuilder: (context, index) {
                      final user = controller.loanApplicantList[index];

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
                                      user.status ?? "-",
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
                    },
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
