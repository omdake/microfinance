import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/nav_bar.dart';
import 'package:microfinance/logic/controller/loanEMI/loanEMIController.dart';
import 'package:microfinance/models/loan_emi.model.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class LoanEMIScreen extends StatelessWidget {
  const LoanEMIScreen({super.key});

  Widget loanCard({
    required LoanEmiListMessage user,
    required VoidCallback onTap,
    required String phoneNumber,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
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
                      "Name: ${user.memberName ?? ""}",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF050708),
                        fontFamily: "Roboto-Regular",
                      ),
                    ),
                    Text(
                      "Loan ID: ${user.loan ?? ""}",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF050708),
                        fontFamily: "Roboto-Regular",
                      ),
                    ),
                    Text(
                      "Total Amt: ${user.totalPayment?.toStringAsFixed(2) ?? "0.00"}",
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
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Get.toNamed(
                            Routes.loanRepayment,
                            arguments: {
                              'fromEMI': true,
                              'loanId': user.loan ?? "",
                              'totalPayment':
                                  user.totalPayment?.toStringAsFixed(2) ??
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
                                  final Uri phoneUri =
                                      Uri(scheme: 'tel', path: phoneNumber);
                                  if (await canLaunchUrl(phoneUri)) {
                                    await launchUrl(phoneUri);
                                  }
                                }
                              },
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.green.shade900,
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
                                color: AppColors.primaryOrange,
                                borderRadius: BorderRadius.circular(6),
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
    final controller = Get.put(LoanEMIController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: Text("Due EMI List", style: TextStyles.appbartitle),
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
       bottomNavigationBar: const CustomBottomNavBar(),
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
              C15(),
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
                      return loanCard(
                        user: user,
                        phoneNumber: phoneNumber,
                        onTap: () {},
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
