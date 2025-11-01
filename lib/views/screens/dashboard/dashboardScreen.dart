import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/logic/controller/dashboard/dasboardController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final controller = Get.put(DashboardController());
  final random = Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: customDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: const Text(
          "Home",
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Roboto-Medium",
              fontWeight: FontWeight.bold),
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
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/new/notification.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() => buildBody(context)),
      bottomNavigationBar: bottomNavBar(),
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
                      "₹ ${controller.dueReport.value}", "OUTSTANDING REPORT")),
              C10(),
              Expanded(
                child: smallStatBox(
                    "₹ ${controller.collectionByCash.value}", "CASH PAYMENT",
                    onTap: () => Get.toNamed(Routes.collectionInHand)),
              ),
            ],
          ),
          C20(),
          memberStats(),
          C20(),
          menuButton(
            "MEMBER CREATION",
            Icons.recent_actors_outlined,
            Routes.memberCreation,
          ),
          C10(),
          menuButton(
            "LOAN APPLICATION",
            Icons.assignment,
            Routes.loanApplicationList,
          ),
          C10(),
          menuButton(
            "DUE EMI",
            Icons.today,
            Routes.loanEMIScreen,
          ),
          C10(),
          menuButton(
            "PENDING EMI",
            Icons.access_time_outlined,
            Routes.dueEmi,
          ),
          C10(),
          menuButton(
            "GROUP CREATION",
            Icons.group_add_outlined,
            Routes.groupList,
          ),
          C10(),
          menuButton(
            "LOAN SUMMARY",
            Icons.summarize_outlined,
            Routes.loanSummaryScreen,
          ),
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
    return GestureDetector(
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
                      "group": "",
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
                  "${controller.ungroupedMembers.value}",
                  "Draft Members",
                  onTap: () {
                    Get.toNamed(
                      Routes.memberList,
                      arguments: {
                        "title": "Draft",
                        "status": "Draft",
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

  Widget menuButton(String title, IconData icon, String route) {
    return InkWell(
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
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryOrange,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            C10(),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: "Roboto-Medium",
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }

  Drawer customDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryRed,
      child: SafeArea(
        child: Column(
          children: [
            drawerHeader(),
            Expanded(
              child: drawerBody(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            child: Text("Hi", style: TextStyle(color: Colors.black)),
          ),
          C15(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${controller.fullName.value}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              C5(),
              Text("${controller.email}",
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget drawerBody(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(35)),
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            drawerTile(Icons.person_outline, "Profile", () {
              Get.toNamed(Routes.profile);
            }),
            const Divider(
              thickness: 0.4,
              color: Colors.grey,
              indent: 50,
              endIndent: 30,
            ),
            drawerTile(
                Icons.person_add_alt_1_outlined, "Member Creation", () {}),
            const Divider(
              thickness: 0.4,
              color: Colors.grey,
              indent: 50,
              endIndent: 30,
            ),
            drawerTile(Icons.note_add_outlined, "Loan Application", () {}),
            const Divider(
              thickness: 0.4,
              color: Colors.grey,
              indent: 50,
              endIndent: 30,
            ),
            drawerTile(Icons.payments_outlined, "Loan EMI", () {}),
            const Divider(
              thickness: 0.4,
              color: Colors.grey,
              indent: 50,
              endIndent: 30,
            ),
            drawerTile(Icons.summarize_outlined, "Loan Summary", () {}),
            const Divider(
              thickness: 0.4,
              color: Colors.grey,
              indent: 50,
              endIndent: 30,
            ),
            drawerTile(
                Icons.logout_outlined, "Logout", showLogoutConfirmationDialog),
            const Divider(
              thickness: 0.4,
              color: Colors.grey,
              indent: 50,
              endIndent: 30,
            ),
            drawerTile(Icons.summarize_outlined, "Reset Password", () {
              Get.toNamed(Routes.resetPassword);
            }),
            const Divider(
              thickness: 0.4,
              color: Colors.grey,
              indent: 50,
              endIndent: 30,
            ),
            Obx(() => InkWell(
                  onTap: () => DevService.instance.openDevScreen(context),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: MediaQuery.of(context).padding.bottom + 12,
                      top: 12,
                    ),
                    child: Center(
                      child: Text(
                        "${controller.appName.value} v${controller.version.value}",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget drawerTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryOrange),
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        color: AppColors.primaryOrange,
      ),
      title: Text(title),
      onTap: onTap,
    );
  }

  void showLogoutConfirmationDialog() {
    Get.dialog(
        AlertDialog(
          content: const Text("Are you sure you want to logout?"),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () async {
                  await AppPreferences.clearPreferences();
                  Get.offAllNamed(Routes.loginScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  foregroundColor: AppColors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text("Yes"),
              ),
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[100],
                  foregroundColor: Colors.red[900],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text("No"),
              ),
            ),
          ],
        ),
        barrierDismissible: false);
  }

  void moreMenu(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 12),
                    child: Column(
                      children: [
                        optionTile(
                          "My Profile",
                          () => Get.toNamed(Routes.personalDetails),
                        ),
                        Divider(
                          color: Colors.grey,
                          indent: 50,
                          endIndent: 50,
                        ),
                        optionTile("Privacy Policy", () => {}),
                        Divider(
                          color: Colors.grey,
                          indent: 50,
                          endIndent: 50,
                        ),
                        optionTile("Logout", () async {
                          showLogoutConfirmationDialog();
                          // await AppPreferences.clearAll();
                          // Get.offAllNamed(Routes.loginScreen);
                        }),
                      ],
                    ),
                  ),
                ),
                C100(),
                Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          color: AppColors.white,
                          size: 60,
                        ))),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget optionTile(String label, VoidCallback onTap) {
    return ListTile(
      title: Center(
        child: Text(label, style: TextStyles.cardtitle),
      ),
      onTap: onTap,
    );
  }

  Widget bottomNavBar() {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: (index) => controller.selectedIndex.value = index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFA52A2A),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/new/home.png',
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/new/note.png',
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/new/app.png',
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/new/message.png',
            ),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 30,
                color: Color(0xFF050708),
              ),
              label: ''),
        ],
      ),
    );
  }
}
