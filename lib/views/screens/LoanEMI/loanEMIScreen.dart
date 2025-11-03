import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/logic/controller/loanEMI/loanEMIController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class LoanEMIScreen extends StatelessWidget {
  const LoanEMIScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoanEMIController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Due EMI List"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              paddingWidget([
                const LabelsWithMark(label: "Selected Date"),
                Obx(
                  () => TextFormField(
                    readOnly: true,
                    cursorColor: AppColors.primary,
                    onTap: () =>
                        controller.selectDate(context, isSelectedDate: true),
                    style: TextStyles.textfieldTextStyle,
                    decoration: TextFieldDecoration.textfieldDecorationicon(
                      hint: "Select Date",
                      sufficIcon: Icons.calendar_today,
                      sufficIconOntap: () =>
                          controller.selectDate(context, isSelectedDate: true),
                    ),
                    controller: TextEditingController(
                        text: controller.selectedDate.value),
                  ),
                ),
              ]),
              C10(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  }
                  if (controller.loanEMIList.isEmpty) {
                    return const Center(child: Text("No members found"));
                  }
                  return ListView.builder(
                    itemCount: controller.loanEMIList.length,
                    itemBuilder: (context, index) {
                      final user = controller.loanEMIList[index];
                      final phoneNumber = user.mobileNo ?? '';
                      return Column(
                        children: [
                          Container(
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
                                      Text(
                                        "Name: ${user.memberName ?? ""}",
                                        style: const TextStyle(
                                          fontFamily: "Roboto-Regular",
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "Loan ID: ${user.loan ?? ""}",
                                        style: const TextStyle(
                                          fontFamily: "Roboto-Regular",
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "Total Amt: ${user.totalPayment?.toStringAsFixed(2) ?? "0.00"}",
                                        style: const TextStyle(
                                          fontFamily: "Roboto-Regular",
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                C10(),
                                GestureDetector(
                                  onTap: () async {
                                    Get.toNamed(
                                      Routes.loanRepayment,
                                      arguments: {
                                        'fromEMI': true,
                                        'loanId': user.loan ?? "",
                                        'totalPayment': user.totalPayment
                                                ?.toStringAsFixed(2) ??
                                            "0.00",
                                        'paymentDate': user.paymentDate,
                                        'memberName': user.memberName,
                                        'applicant': user.applicant,
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          if (phoneNumber.isNotEmpty) {
                                            final Uri phoneUri = Uri(
                                                scheme: 'tel',
                                                path: phoneNumber);
                                            if (await canLaunchUrl(phoneUri)) {
                                              await launchUrl(phoneUri);
                                            }
                                          }
                                        },
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor:
                                              Colors.green.shade900,
                                          child: const Icon(
                                            Icons.call,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      C15(),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade500,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 8),
                                          child: Center(
                                            child: Text(
                                              "Pay",
                                              style: const TextStyle(
                                                fontFamily: "Roboto-Medium",
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
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
    );
  }
}
