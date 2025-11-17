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
    switch (status?.toLowerCase()) {
      case "approved":
        return const Color(0xFFAE282E);
      case "pending":
        return const Color(0xFFF06321);
      case "rejected":
        return const Color(0xFF5F5F5F);
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    try {
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (e) {
      return 'N/A';
    }
  }

  Widget _buildDisbursementItem(dynamic user) {
    String _getInitials(String? name) {
      if (name == null || name.trim().isEmpty) {
        return "?";
      }
      final parts = name.trim().split(" ");
      if (parts.length == 1) {
        return parts[0][0].toUpperCase();
      } else {
        return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFFD9D9D9),
                  backgroundImage: user.applicantImage != null &&
                          user.applicantImage!.isNotEmpty
                      ? NetworkImage(user.applicantImage!)
                      : null,
                  child: (user.applicantImage == null ||
                          user.applicantImage!.isEmpty)
                      ? Text(
                          _getInitials(user.applicantMemberName),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
              ),
            ),
            C10(),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${user.applicantMemberName ?? ""}".toString().toUpperCase(),
                      style: const TextStyle(
                      fontFamily: "Roboto-Medium",
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Member Id: ${user.applicant ?? ""}",
                    style: TextStyle(
                      fontFamily: "Roboto-Regular",
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Loan Id: ${user.againstLoanLoanId ?? ""}",
                    style: const TextStyle(
                      fontFamily: "Roboto-Regular",
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Amount Paid: ${user.amountPaid ?? ""}",
                    style: const TextStyle(
                      fontFamily: "Roboto-Regular",
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Posting date: ${_formatDate(user.valueDate)}",
                    style: const TextStyle(
                      fontFamily: "Roboto-Regular",
                      fontSize: 11,
                      color: Colors.black,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor(user.workflowState),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    user.workflowState?.toUpperCase() ?? "-",
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontFamily: "Roboto-Medium",
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
              Column(
                children: [
                  TextField(
                    controller: controller.search.value,
                    style: TextStyles.textfieldTextStyle,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      if (value.length >= 3 || value.isEmpty) {
                        controller.onSearchChanged(value);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Search Members",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontFamily: "Roboto-Regular",
                        fontSize: 14,
                      ),
                      suffixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  C10(),
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
                        searchController:
                            controller.groupSearchController.value,
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
                        controller.selectedGroup.value =
                            newGroup ?? "All Group";
                        if (controller.selectedGroup.value.isEmpty) {
                          controller.getRepaymentList(
                              page: controller.page.value,
                              search: controller.search.value.text);
                        } else {
                          controller.repaymentList.clear();
                          controller.getRepaymentList(
                              page: controller.page.value,
                              search: controller.search.value.text);
                        }
                      },
                    );
                  }),
                ],
              ),
              C20(),

              // List
              Expanded(
                child: Obx(() {
                  return LoadMoreListView1(
                      isLoading: controller.isLoading.value,
                      loadData: () => controller.getloadData(),
                      loadMoreData: () => controller.getLoadMoreData(),
                      children: controller.repaymentList.isNotEmpty
                          ? controller.repaymentList.map((user) {
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
                            }).toList()
                          : []);
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
