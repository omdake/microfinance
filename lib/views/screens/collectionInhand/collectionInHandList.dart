import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/logic/controller/collectionInHand/collectionInHandController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:intl/intl.dart';

class CollectionInHandList extends StatelessWidget {
  const CollectionInHandList({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CollectionInHandController());
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
                  if (controller.collectionInHandList.isEmpty) {
                    return const Center(child: Text("No members found"));
                  }
                  return ListView.builder(
                    itemCount: controller.collectionInHandList.length,
                    itemBuilder: (context, index) {
                      final user = controller.collectionInHandList[index];

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
                                              text: "Employee Id: ",
                                              style: TextStyle(
                                                fontFamily: "Roboto-Medium",
                                                fontSize: 15,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "${user.employee ?? ""}",
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
                                              text: "Employee Name: ",
                                              style: TextStyle(
                                                fontFamily: "Roboto-Medium",
                                                fontSize: 15,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  "${user.employeeEmployeeName ?? ""}",
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
                                              text: "Date: ",
                                              style: TextStyle(
                                                fontFamily: "Roboto-Medium",
                                                fontSize: 15,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            TextSpan(
                                              text: user.postingDate != null
                                                  ? DateFormat(
                                                          'yyyy-MM-dd')
                                                      .format(user.postingDate!)
                                                  : "",
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
                                // Container(
                                //   decoration: BoxDecoration(
                                //     color: Colors.grey.shade600,
                                //     borderRadius: BorderRadius.circular(25),
                                //   ),
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 4, vertical: 2),
                                //   child: Text(
                                //     user.status ?? "-",
                                //     style: const TextStyle(
                                //       fontFamily: "Roboto-Medium",
                                //       fontSize: 13,
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // ),
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
          Get.toNamed(Routes.createCollectionInHand);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        tooltip: "Add Payment Proof",
      ),
    );
  }
}
