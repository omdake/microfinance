import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/drawer_widget.dart';
import 'package:microfinance/logic/controller/dashboard/dasboardController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final controller = Get.put(DashboardController());
  final random = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Roboto-Medium",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16),
        //     child: InkWell(
        //       child: Container(
        //         padding: const EdgeInsets.all(8),
        //         child: Image.asset(
        //           'assets/new/notification.png',
        //           fit: BoxFit.contain,
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Obx(() => buildBody(context)),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade300,
      elevation: 0,
      title: const Text(
        "Home",
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Roboto-Medium",
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/new/notification.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          collectionCard(context),
          C15(),
          Row(
            children: [
              Expanded(
                child: smallStatBox(
                  "₹ ${controller.dueReport.value}",
                  "OUTSTANDING REPORT",
                ),
              ),
              C10(),
              Expanded(
                child: smallStatBox(
                  "₹ ${controller.collectionByCash.value}",
                  "CASH PAYMENT",
                  onTap: () => Get.toNamed(Routes.collectionInHand),
                ),
              ),
            ],
          ),
          C20(),
          memberStats(),
          // C20(),
          // dashboardMenu(),
        ],
      ),
    );
  }

  Widget collectionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFA52A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            "${controller.fullName.value} ",
            // - ${controller.employeeCode.value}",
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Roboto-Medium",
              fontSize: 14,
            ),
          ),
          C5(),
          const Text(
            "TOTAL COLLECTION",
            style: TextStyle(
              color: Colors.white70,
              fontFamily: "Roboto-Regular",
              fontSize: 12,
            ),
          ),
          C5(),
          Text(
            "₹ ${controller.todaysCollection.value}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontFamily: "Roboto-Bold",
            ),
          ),
          C10(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(30, (index) {
                  int height = 10 + random.nextInt(50);

                  return Container(
                    width: 3,
                    height: height.toDouble(),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                }),
              ),
              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
          C10(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Today",
                  style: TextStyle(color: Colors.white70, fontSize: 10)),
              divider(),
              const Text("Yesterday",
                  style: TextStyle(color: Colors.white70, fontSize: 10)),
              divider(),
              const Text("Week",
                  style: TextStyle(color: Colors.white70, fontSize: 10)),
              divider(),
              const Text("Month",
                  style: TextStyle(color: Colors.white70, fontSize: 10)),
              divider(),
              const Text("Year",
                  style: TextStyle(color: Colors.white70, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return Container(
      height: 12,
      width: 1,
      color: Colors.white54,
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget smallStatBox(String value, String label, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFF7043),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "Roboto-Bold",
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "Roboto-Regular",
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget memberStats() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "MY MEMBERS",
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Roboto-Medium",
              color: Colors.black87,
            ),
          ),
          C10(),
          Row(
            children: [
              Expanded(
                child: memberBox(
                  "${controller.totalMembers.value}",
                  "Total Members",
                  onTap: () {
                    Get.toNamed(Routes.memberList, arguments: {
                      "status": "",
                      "group": controller.selectedGroup.value,
                      "title": "Total Members",
                      "is_group": true,
                    });
                  },
                ),
              ),
              C5(),
              Expanded(
                child: memberBox(
                  "${controller.verifiedMembers.value}",
                  "Verified Members",
                  onTap: () {
                    Get.toNamed(
                      Routes.memberList,
                      arguments: {
                        "title": "Verified Members",
                        "status": "Verified",
                        "group": controller.selectedGroup.value
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          C5(),
          Row(
            children: [
              Expanded(
                child: memberBox(
                  "${controller.ungroupedMembers.value}",
                  "Ungrouped Members",
                  onTap: () {
                    Get.toNamed(
                      Routes.memberList,
                      arguments: {
                        "title": "Ungrouped Members",
                        "is_group": false,
                      },
                    );
                  },
                ),
              ),
              C5(),
              Expanded(
                child: memberBox(
                  "${controller.pendingVerification.value}",
                  "Pending Verification",
                  onTap: () {
                    Get.toNamed(
                      Routes.memberList,
                      arguments: {
                        "title": "Pending Verification",
                        "status": "Pending",
                        "group": controller.selectedGroup.value
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          C5(),
          Row(
            children: [
              Expanded(
                child: memberBox(
                  "${controller.draftCount.value}",
                  "Draft Members",
                  onTap: () {
                    Get.toNamed(
                      Routes.memberList,
                      arguments: {
                        "title": "Draft",
                        "status": "Draft",
                        "group": controller.selectedGroup.value
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget memberBox(String count, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: const TextStyle(
                  fontFamily: "Roboto-Bold", fontSize: 16, color: Colors.black),
            ),
            C5(),
            Text(
              label,
              style: const TextStyle(
                fontFamily: "Roboto-Regular",
                fontSize: 10,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget dashboardMenu() {
  //   return Column(
  //     children: [
  //       menuButton("MEMBER CREATION", Icons.recent_actors_outlined,
  //           Routes.memberCreation),
  //       C10(),
  //       menuButton(
  //           "LOAN APPLICATION", Icons.assignment, Routes.loanApplicationList),
  //       C10(),
  //       menuButton("DUE EMI", Icons.today, Routes.loanEMIScreen),
  //       C10(),
  //       menuButton("PENDING EMI", Icons.access_time_outlined, Routes.dueEmi),
  //       C10(),
  //       menuButton(
  //           "GROUP CREATION", Icons.group_add_outlined, Routes.groupList),
  //       C10(),
  //       menuButton(
  //           "LOAN SUMMARY", Icons.summarize_outlined, Routes.loanSummaryScreen),
  //     ],
  //   );
  // }

  Widget menuButton(String title, IconData icon, String route) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.toNamed(route),
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryOrange,
                child: Icon(icon, size: 20, color: Colors.white),
              ),
              C10(),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Roboto-Medium",
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.black45),
            ],
          ),
        ),
      ),
    );
  }
}
