import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/logic/controller/collectionInHand/collectionInHandListController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:intl/intl.dart';
import 'package:microfinance/utils/ui_helper.dart/load_more_listview.dart';

class CollectionInHandList extends StatelessWidget {
  const CollectionInHandList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CollectionInHandListController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Collection By Cash List"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Obx(() {
            if (controller.collectionInHandList.isEmpty) {
              return const Center(child: Text("No records found"));
            }

            return LoadMoreListView(
              loadData: () => controller.getloadData(),
              loadMoreData: () => controller.getLoadMoreData(),
              children: controller.collectionInHandList.map((user) {
                return Column(
                  children: [
                    GestureDetector(
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
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                              ? DateFormat('yyyy-MM-dd')
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
                            Container(
                              decoration: BoxDecoration(
                                color: (user.status == null ||
                                        user.status!.isEmpty)
                                    ? Colors.white
                                    : Colors.grey.shade600,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                user.status?.isNotEmpty == true
                                    ? user.status!
                                    : "",
                                style: TextStyle(
                                  fontFamily: "Roboto-Medium",
                                  fontSize: 13,
                                  color: (user.status == null ||
                                          user.status!.isEmpty)
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: Colors.grey),
                  ],
                );
              }).toList(),
            );
          }),
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
