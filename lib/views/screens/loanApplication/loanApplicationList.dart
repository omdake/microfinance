import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:microfinance/logic/controller/loanApplication/loanlistController.dart';
import 'package:microfinance/models/loan_applicant_list.model.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/load_more_listview.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class LoanApplicationList extends StatelessWidget {
  const LoanApplicationList({super.key});
  String formatAmount(num? amount) {
    final format = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '',
      decimalDigits: 2,
    );
    return format.format(amount ?? 0);
  }

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

  Widget loanCard({
    required LoanApplicantListResult user,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE6E6E6)),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
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
              C15(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.applicantName ?? "-",
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF050708),
                        fontFamily: "Roboto-Medium",
                      ),
                    ),
                    C2(),
                    Text(
                      "ID ${user.name ?? "-"}",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF050708),
                        fontFamily: "Roboto-Regular",
                      ),
                    ),
                    Text(
                      "Loan Product: ${user.loanProduct ?? "-"}",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF050708),
                        fontFamily: "Roboto-Regular",
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 1,
                  height: double.infinity,
                  color: const Color(0xFFE6E6E6),
                ),
              ),
              C15(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Loan Amount",
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF050708),
                      fontFamily: "Roboto-Regular",
                    ),
                  ),
                  Text(
                    formatAmount(user.loanAmount),
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Roboto-Bold",
                    ),
                  ),
                  C5(),
                  Container(
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoanApplicationListController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: Text("Loan Application", style: TextStyles.appbartitle),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(Routes.homeScreen),
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.arrow_back, color: Colors.black, size: 20),
            ),
          ),
        ),
      ),
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
                      if (searchValue.trim().length < 3) return true;
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
                  dropdownStyleData: const DropdownStyleData(maxHeight: 500),
                  isExpanded: true,
                  style: TextStyles.textfieldTextStyle,
                  decoration: TextFieldDecoration.textfieldDecoration(
                    sufficIconOntap: () {},
                    sufficIcon: null,
                    hint: '',
                  ).copyWith(contentPadding: EdgeInsets.zero),
                  onChanged: (newGroup) {
                    controller.page.value = 1;
                    controller.loanApplicantList.clear();
                    controller.selectedGroup.value = newGroup ?? "All Group";
                    controller.getAplicantList(
                      page: controller.page.value,
                      loanGroup: controller.selectedGroup.value.isEmpty
                          ? null
                          : controller.selectedGroup.value,
                    );
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
                      return loanCard(
                        user: user,
                        onTap: () {
                          Get.toNamed(
                            Routes.loanApplicationViewonly,
                            arguments: {"applicant": user, "isReadOnly": true},
                          );
                        },
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
          final newApplicant = LoanApplicantListResult();
          Get.toNamed(Routes.loanApplication, arguments: {
            "applicant": newApplicant,
            "isReadOnly": false,
          });
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
