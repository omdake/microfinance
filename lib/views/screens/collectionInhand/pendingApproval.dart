import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/logic/controller/collectionInHand/pendingApprovalListController.dart';
import 'package:microfinance/models/collection_in_hand.model.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/ui_helper.dart/load_more_listview.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class PendingApproval extends StatelessWidget {
  const PendingApproval({super.key});
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
    required CollectionInhandResult user,
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
                    C2(),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Agent Id: ",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF050708),
                              fontFamily: "Roboto-Regular",
                            ),
                          ),
                          TextSpan(
                            text: "${user.employee ?? ""}",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF050708),
                              fontFamily: "Roboto-Regular",
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Agent Name: ",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF050708),
                              fontFamily: "Roboto-Regular",
                            ),
                          ),
                          TextSpan(
                            text: "${user.employeeEmployeeName ?? ""}",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF050708),
                              fontFamily: "Roboto-Regular",
                            ),
                          ),
                        ],
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
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Date: ",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF050708),
                            fontFamily: "Roboto-Regular",
                          ),
                        ),
                        TextSpan(
                          text: user.postingDate != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(user.postingDate!)
                              : "",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF050708),
                            fontFamily: "Roboto-Regular",
                          ),
                        ),
                      ],
                    ),
                  ),
                  C5(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor(user.status),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      user.status?.isNotEmpty == true ? user.status! : "",
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
    final controller = Get.put(PendingApprovalListController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: paddingWidget([
                      const LabelsWithMark(label: "Selected Date"),
                      Obx(() {
                        final hasDate =
                            controller.selectedDateText.value.isNotEmpty;

                        return TextFormField(
                          readOnly: true,
                          cursorColor: AppColors.primary,
                          controller: controller.selectedDateController.value,
                          onTap: () => controller.selectDate(context,
                              isSelectedDate: true),
                          style: TextStyles.textfieldTextStyle,
                          decoration: InputDecoration(
                            hintText: "Select Date",
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hasDate ? Icons.close : Icons.calendar_month,
                                color: Colors.grey.shade600,
                              ),
                              onPressed: () {
                                if (hasDate) {
                                  controller.clearSelectedDate();
                                } else {
                                  controller.selectDate(context,
                                      isSelectedDate: true);
                                }
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        );
                      }),
                    ]),
                  ),
                  C10(),
                  Expanded(
                    flex: 1,
                    child: paddingWidget(
                      [
                        const LabelsWithMark(label: "Status"),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller.Status.value,
                                style: TextStyles.textfieldTextStyle,
                                cursorColor: Colors.black,
                                onChanged: (value) {
                                  if (value.length >= 3 || value.isEmpty) {
                                    controller.onSearchChanged(value);
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter Status",
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontFamily: "Roboto-Regular",
                                    fontSize: 14,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey.shade600,
                                  ),
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              C25(),
              Expanded(
                child: Obx(() {
                  if (controller.pendingApproval.isEmpty) {
                    return const Center(child: Text("No records found"));
                  }
                  return LoadMoreListView(
                    loadData: () => controller.getloadData(),
                    loadMoreData: () => controller.getLoadMoreData(),
                    children: controller.pendingApproval.map((user) {
                      return loanCard(
                        user: user,
                        onTap: () {
                          final args = {
                            "applicant": user,
                            "isReadOnly": true,
                          };
                          Get.toNamed(
                            Routes.collectionInhandView,
                            arguments: args,
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
          Get.toNamed(Routes.createCollectionInHand);
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
