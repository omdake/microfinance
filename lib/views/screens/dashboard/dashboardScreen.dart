import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/logic/controller/dashboard/dasboardController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarWithTwoTitle(
            title: controller.fullName.value, subTitle: controller.email.value),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF707070)),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Obx(() => Column(
                          children: [
                            title("My Member"),
                            C15(),
                            Row(
                              children: [
                                Expanded(
                                  child: resuableCard(
                                    title: "${controller.totalMembers.value}",
                                    subTitle: 'Total Members',
                                    onTap: () {
                                      final args = {
                                        "group": controller.selectedGroup.value,
                                        "status": null,
                                      };
                                      Get.toNamed(Routes.memberList,
                                          arguments: args);
                                    },
                                  ),
                                ),
                                C10(),
                                Expanded(
                                  child: resuableCard(
                                    title:
                                        "${controller.verifiedMembers.value}",
                                    subTitle: 'Verified Members',
                                    onTap: () {
                                      final args = {
                                        "group": controller.selectedGroup.value,
                                        "status": "Verified",
                                        "isGroup": true,
                                      };
                                      Get.toNamed(Routes.memberList,
                                          arguments: args);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            C10(),
                            Row(
                              children: [
                                Expanded(
                                  child: resuableCard(
                                    title:
                                        "${controller.ungroupedMembers.value}",
                                    subTitle: 'Ungrouped Members',
                                    onTap: () {
                                      final args = {
                                        "group": null,
                                        "isGroup": false,
                                      };
                                      Get.toNamed(Routes.memberList,
                                          arguments: args);
                                    },
                                  ),
                                ),
                                C10(),
                                Expanded(
                                  child: resuableCard(
                                    title:
                                        "${controller.pendingVerification.value}",
                                    subTitle: "Pending Verification",
                                    onTap: () {
                                      final args = {
                                        "group": null,
                                        "status": "Pending",
                                        "isGroup": false,
                                      };
                                      Get.toNamed(Routes.memberList,
                                          arguments: args);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  C15(),
                  Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  C15(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF707070)),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Obx(
                      () => Column(
                        children: [
                          title("My Collection"),
                          C15(),
                          Row(
                            children: [
                              Expanded(
                                child: resuableCard(
                                    title:
                                        "${controller.todaysCollection.value}",
                                    subTitle: 'Today Collection',
                                    onTap: () {}),
                              ),
                              C10(),
                              Expanded(
                                child: resuableCard(
                                    title: "${controller.dueReport.value}",
                                    subTitle: 'Due Report',
                                    onTap: () {}),
                              ),
                            ],
                          ),
                          C10(),
                          Row(
                            children: [
                              Expanded(
                                child: resuableCard(
                                    title: "${controller.assignedGroup.value}",
                                    subTitle: 'Assigned Group',
                                    onTap: () {}),
                              ),
                              C10(),
                              Expanded(
                                child: resuableCard(
                                    title:
                                        "${controller.collectionByCash.value}",
                                    subTitle: "Collection By Cash",
                                    onTap: () {}),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  C15(),
                  Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  C15(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF707070)),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title("Quick Actions"),
                        C15(),
                        Row(
                          children: [
                            Expanded(
                                child: quickButtons(
                                    onTap: () {
                                      Get.toNamed(Routes.memberCreation);
                                    },
                                    title: "Member Creation")),
                            C10(),
                            Expanded(
                                child: quickButtons(
                                    onTap: () {
                                      Get.toNamed(Routes.loanApplication);
                                    },
                                    title: "Loan Application")),
                          ],
                        ),
                        C10(),
                        Row(
                          children: [
                            Expanded(
                                child: quickButtons(
                                    onTap: () {
                                      Get.toNamed(Routes.loanEMIScreen);
                                    },
                                    title: "Loan EMI")),
                            C10(),
                            Expanded(
                                child: quickButtons(
                                    onTap: () {
                                      Get.toNamed(Routes.loanSummaryScreen); 
                                    },
                                    title: "Loan Summary")),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  quickButtons({required Function() onTap, required String title}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Roboto-Medium",
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Align title(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: "Roboto-Medium",
          fontSize: 15,
          color: const Color(0xFF616161),
        ),
      ),
    );
  }

  Widget resuableCard({
    required String title,
    required String subTitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF707070)),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: "Roboto-Bold",
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontFamily: "Roboto-Regular",
                fontSize: 11,
                color: const Color(0xFF939393),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
