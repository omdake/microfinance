import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:microfinance/logic/controller/loanSummary/loanDetailsController.dart';

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({super.key});
  final LoanDetailsController controller = Get.put(LoanDetailsController());
  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    try {
      return DateFormat('yyy-MM-dd').format(date);
    } catch (e) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.white],
                    ),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: IntrinsicWidth(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Column(
                                  children: [
                                    // Header Table
                                    Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      border: TableBorder(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade300,
                                              width: 2)),
                                      columnWidths: const {
                                        0: FixedColumnWidth(50),
                                        1: FixedColumnWidth(150),
                                        2: FixedColumnWidth(150),
                                        3: FixedColumnWidth(150),
                                        4: FixedColumnWidth(150),
                                        5: FixedColumnWidth(150),
                                      },
                                      children: [
                                        TableRow(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                          ),
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1),
                                                  right: BorderSide(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Text(
                                                "Sr.NO",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: "Roboto-Medium",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Text(
                                                "Payment Date",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: "Roboto-Medium",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Text(
                                                "Principal Amount",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: "Roboto-Medium",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Text(
                                                "Interest Amount",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: "Roboto-Medium",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Text(
                                                "Total Payment",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: "Alegreya_Sans",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: const Text(
                                                "Balance Amount",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: "Roboto-Medium",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // Data Table
                                    Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: const {
                                        0: FixedColumnWidth(50),
                                        1: FixedColumnWidth(150),
                                        2: FixedColumnWidth(150),
                                        3: FixedColumnWidth(150),
                                        4: FixedColumnWidth(150),
                                        5: FixedColumnWidth(150),
                                      },
                                      children: List.generate(
                                        controller.repaymentSchedule.length,
                                        (index) {
                                          final schedule = controller
                                              .repaymentSchedule[index];
                                          return TableRow(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey.shade300,
                                                    width: 2),
                                              ),
                                              color: Colors.white,
                                            ),
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    left: BorderSide(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 1),
                                                    right: BorderSide(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 1),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${schedule.idx}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          "Roboto-Medium",
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 1),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  _formatDate(
                                                      schedule.paymentDate),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontFamily: "Roboto-Medium",
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 1),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "₹ ${schedule.principalAmount!.toStringAsFixed(2)}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          "Roboto-Medium",
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 1),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "₹ ${schedule.interestAmount!.toStringAsFixed(2)}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          "Roboto-Medium",
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 1),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "₹ ${schedule.totalPayment!.toStringAsFixed(2)}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          "Roboto-Medium",
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 1),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "₹ ${schedule.balanceLoanAmount!.toStringAsFixed(2)}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          "Roboto-Medium",
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }
}
