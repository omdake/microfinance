import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/logic/controller/loanApplication/loanApplicationController.dart';
import 'package:microfinance/routes/routes_string.dart';

class LoanApplicationList extends StatelessWidget {
  const LoanApplicationList({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoanApplicationController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Loan Application List"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
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
                                              text: "Company: ",
                                              style: TextStyle(
                                                fontFamily: "Roboto-Medium",
                                                fontSize: 15,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "${user.company ?? ""}",
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
                                              text: "${user.loanProduct ?? ""}",
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
                                              text: "${user.loanAmount ?? ""}",
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
          Get.toNamed(Routes.loanApplication);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        tooltip: "Add Payment Proof",
      ),
    );
  }
}
