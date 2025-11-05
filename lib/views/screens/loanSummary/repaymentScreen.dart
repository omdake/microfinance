import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:microfinance/logic/controller/loanSummary/loanRepaymentListController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/utils/ui_helper.dart/load_more_listview.dart';

class RepaymentScreen extends StatelessWidget {
  RepaymentScreen({super.key});

  Color statusColor(String? status) {
    switch (status?.toUpperCase()) {
      case "SUBMITTED":
        return AppColors.primaryOrange;
      case "CLOSED":
        return const Color(0xFFAE282E);
      case "CANCELLED":
        return const Color(0xFFAE282E);
      default:
        return Colors.grey.shade600;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    try {
      return DateFormat('yyy-MM-dd').format(date);
    } catch (e) {
      return 'N/A';
    }
  }

  Widget _buildDisbursementItem(dynamic user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE6E6E6),
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xFFD9D9D9),
                  child: Icon(Icons.person, color: Colors.white, size: 22),
                ),
              ),
            ),
            C10(),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: " Name: ",
                          style: const TextStyle(
                            fontFamily: "Roboto-Regular",
                            fontSize: 11,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "${user.applicantMemberName ?? ""}",
                          style: const TextStyle(
                            fontFamily: "Roboto-Regular",
                            fontSize: 11,
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
                          text: " Id: ",
                          style: const TextStyle(
                            fontFamily: "Roboto-Regular",
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "${user.applicant ?? ""}",
                          style: TextStyle(
                            fontFamily: "Roboto-Regular",
                            fontSize: 11,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: " Loan: ",
                          style: const TextStyle(
                            fontFamily: "Roboto-Regular",
                            fontSize: 11,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "${user.againstLoan ?? ""}",
                          style: const TextStyle(
                            fontFamily: "Roboto-Regular",
                            fontSize: 11,
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
                          text: "Amount Paid: ",
                          style: const TextStyle(
                            fontFamily: "Roboto-Regular",
                            fontSize: 11,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "${user.amountPaid ?? ""}",
                          style: const TextStyle(
                            fontFamily: "Roboto-Regular",
                            fontSize: 11,
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
                          text: "Posting date: ",
                          style: const TextStyle(
                            fontFamily: "Roboto-Regular",
                            fontSize: 11,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: _formatDate(user.valueDate),
                          style: const TextStyle(
                            fontFamily: "Roboto-Regular",
                            fontSize: 11,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 1,
                  height: double.infinity,
                  color: const Color(0xFFE6E6E6),
                ),
              ),
            ),
            //C10(),
            Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: (user.workflowState == null ||
                            user.workflowState!.isEmpty)
                        ? Colors.white
                        : Colors.grey.shade600,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    user.workflowState?.isNotEmpty == true
                        ? user.workflowState!
                        : "",
                    style: TextStyle(
                      fontFamily: "Roboto-Medium",
                      fontSize: 13,
                      color: (user.workflowState == null ||
                              user.workflowState!.isEmpty)
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoanSummaryListController());

    return Scaffold(
      backgroundColor: Colors.white,
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
                  dropdownStyleData: DropdownStyleData(
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
                    controller.selectedGroup.value = newGroup ?? "All Group";
                    if (controller.selectedGroup.value.isEmpty) {
                      controller.getRepaymentList(page: controller.page.value);
                    } else {
                      controller.repaymentList.clear();
                      controller.getRepaymentList(page: controller.page.value);
                    }
                  },
                );
              }),
              C20(),

              // List
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }

                  if (controller.repaymentList.isEmpty) {
                    return const Center(child: Text("No members found"));
                  }

                  return LoadMoreListView(
                    loadData: () => controller.getloadData(),
                    loadMoreData: () => controller.getLoadMoreData(),
                    children: controller.repaymentList.map((user) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          final args = {
                            "applicant": user,
                            "isReadOnly": true,
                          };
                          Get.toNamed(
                            Routes.loanRepaymentViewonly,
                            arguments: args,
                          );
                        },
                        child: _buildDisbursementItem(user),
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
          Get.toNamed(Routes.loanRepayment);
        },
        elevation: 0,
        backgroundColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightElevation: 0,
        tooltip: "Add Loan Application",
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryOrange,
            border: Border.all(
              color: AppColors.primaryOrange,
              width: 2,
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
