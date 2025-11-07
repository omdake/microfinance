import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:microfinance/logic/controller/loanSummary/loanDetailsController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({super.key});
  final LoanDetailsController controller = Get.put(LoanDetailsController());

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    try {
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (e) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF979797),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Loan Amount",
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xFF050708)),
                              ),
                              Text(
                                "₹ ${controller.repaymentSchedulecard.isNotEmpty ? controller.repaymentSchedulecard.first.loanAmount?.toStringAsFixed(2) ?? '0.00' : '0.00'}",
                                style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF050708)),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Interest Rate",
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xFF050708)),
                              ),
                              Text(
                                controller.repaymentSchedulecard.isNotEmpty
                                    ? "${controller.repaymentSchedulecard.first.rateOfInterest?.toStringAsFixed(2) ?? '0.00'}%"
                                    : '0.00%',
                                style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF050708)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          color: const Color(0xFF979797),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Disbursed Amt",
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xFF050708)),
                              ),
                              Text(
                                "₹ ${controller.repaymentSchedulecard.isNotEmpty ? controller.repaymentSchedulecard.first.disbursedAmount?.toStringAsFixed(2) ?? '0.00' : '0.00'}",
                                style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF050708)),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Disbursed Date",
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xFF050708)),
                              ),
                              Text(
                                controller.repaymentSchedulecard.isNotEmpty &&
                                        controller.repaymentSchedulecard.first
                                                .postingDate !=
                                            null
                                    ? DateFormat('dd-MM-yyyy').format(controller
                                        .repaymentSchedulecard
                                        .first
                                        .postingDate!)
                                    : 'N/A',
                                style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF050708)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          color: const Color(0xFF979797),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "First EMI Date",
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xFF050708)),
                              ),
                              Text(
                                controller.repaymentSchedulecard.isNotEmpty &&
                                        controller.repaymentSchedulecard.first
                                                .repaymentStartDate !=
                                            null
                                    ? DateFormat('dd-MM-yyyy').format(controller
                                        .repaymentSchedulecard
                                        .first
                                        .repaymentStartDate!)
                                    : 'N/A',
                                style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF050708)),
                              ),
                              C10(),
                              const Text(
                                "Last EMI Date",
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xFF050708)),
                              ),
                              Text(
                                controller.repaymentSchedulecard.isNotEmpty &&
                                        controller.repaymentSchedulecard.first
                                                .maturityDate !=
                                            null
                                    ? DateFormat('dd-MM-yyyy').format(controller
                                        .repaymentSchedulecard
                                        .first
                                        .maturityDate!)
                                    : 'N/A',
                                style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF050708)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                C20(),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "EMI SUMMARY",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Roboto-Medium",
                      color: Color(0xFF050708),
                    ),
                  ),
                ),
                C15(),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.repaymentSchedule.length,
                  itemBuilder: (context, index) {
                    final schedule = controller.repaymentSchedule[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF979797),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.primaryOrange,
                                          width: 2,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.check,
                                          color: AppColors.primaryOrange,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  C5(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "EMI-${(index + 1).toString().padLeft(2, '0')}",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF050708),
                                        ),
                                      ),
                                      Text(
                                        "₹ ${schedule.balanceLoanAmount?.toStringAsFixed(2) ?? '0.00'}",
                                        style: const TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF050708),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Total Amt",
                                    style: TextStyle(
                                        fontSize: 10, color: Color(0xFF050708)),
                                  ),
                                  Text(
                                    "₹ ${schedule.totalPayment?.toStringAsFixed(2) ?? '0.00'}",
                                    style: const TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF050708),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Paid On",
                                    style: TextStyle(
                                        fontSize: 10, color: Color(0xFF050708)),
                                  ),
                                  Text(
                                    _formatDate(schedule.paymentDate),
                                    style: const TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF050708),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
