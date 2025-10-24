import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/logic/controller/dashboard/dasboardController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        drawer: customDrawer(context),
        appBar: appBarWithTwoTitle(
          title: controller.fullName.value,
          subTitle: controller.email.value,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: InkWell(
                onTap: () => moreMenu(context),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(Icons.settings, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Obx(() => buildBody(context)),
        ),
        // bottomNavigationBar: Obx(
        //   () => BottomNavigationBar(
        //     backgroundColor: Colors.grey,
        //     currentIndex: controller.selectedIndex.value,
        //     onTap: (index) => controller.selectedIndex.value = index,
        //     type: BottomNavigationBarType.fixed,
        //     selectedItemColor: AppColors.black,
        //     unselectedItemColor: Colors.white,
        //     showSelectedLabels: false,
        //     showUnselectedLabels: false,
        //     items: const [
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.home), label: 'Dashboard'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.person_add_alt_1_outlined),
        //           label: 'Member Creation'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.note_add_outlined),
        //           label: 'Loan Application'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.payments_outlined), label: 'Loan EMI'),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.summarize_outlined), label: 'Loan Summary'),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    switch (controller.selectedIndex.value) {
      case 0:
        return homeSection(context);
      case 1:
        return const Center(child: Text(" Member Creation"));
      case 2:
        return const Center(child: Text("Loan Application"));
      case 3:
        return const Center(child: Text("Loan EmI"));
      case 4:
        return const Center(child: Text("Loan Summary"));
      default:
        return const Center(child: Text("Invalid Tab"));
    }
  }

  Widget homeSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            statsCard(
              title: "My Member",
              children: [
                Row(
                  children: [
                    Expanded(
                      child: reusableCard(
                        title: "${controller.totalMembers.value}",
                        subTitle: 'Total Members',
                        onTap: () => (
                          Get.toNamed(Routes.memberList,
                              arguments: {"status": "", "group": ""}),
                        ),
                      ),
                    ),
                    C10(),
                    Expanded(
                      child: reusableCard(
                        title: "${controller.verifiedMembers.value}",
                        subTitle: 'Verified Members',
                        onTap: () => (
                          Get.toNamed(
                            Routes.memberList,
                            arguments: {
                              "status": "Verified",
                              "group": controller.selectedGroup.value
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                C10(),
                Row(
                  children: [
                    Expanded(
                      child: reusableCard(
                          title: "${controller.ungroupedMembers.value}",
                          subTitle: 'Ungrouped Members',
                          onTap: () => (Get.toNamed(
                                Routes.memberList,
                                arguments: {
                                  "is_group": false,
                                },
                              ))),
                    ),
                    C10(),
                    Expanded(
                      child: reusableCard(
                        title: "${controller.pendingVerification.value}",
                        subTitle: 'Pending Verification',
                        onTap: () => (
                          Get.toNamed(
                            Routes.memberList,
                            arguments: {
                              "status": "pending",
                              "group": controller.selectedGroup.value
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            C5(),
            Divider(color: Colors.grey.shade400),
            C5(),
            statsCard(
              title: "My Collection",
              children: [
                Row(
                  children: [
                    Expanded(
                      child: reusableCard(
                        title: "${controller.todaysCollection.value}",
                        subTitle: 'Today Collection',
                      ),
                    ),
                    C10(),
                    Expanded(
                      child: reusableCard(
                        title: "${controller.dueReport.value}",
                        subTitle: 'Outstanding Report',
                      ),
                    ),
                  ],
                ),
                C10(),
                Row(
                  children: [
                    Expanded(
                      child: reusableCard(
                        title: "${controller.assignedGroup.value}",
                        subTitle: 'Monthly Collection',
                      ),
                    ),
                    C10(),
                    Expanded(
                      child: reusableCard(
                        title: "${controller.collectionByCash.value}",
                        subTitle: 'Collection By Cash',
                        onTap: () => Get.toNamed(Routes.collectionInHandList),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            C5(),
            Divider(color: Colors.grey.shade400),
            C5(),
            quickActionsCard(),
          ],
        ),
      ),
    );
  }

  Widget statsCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF707070)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle(title),
          C15(),
          ...children,
        ],
      ),
    );
  }

  Widget quickActionsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF707070)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle("Quick Actions"),
          C15(),
          Row(
            children: [
              Expanded(
                child: quickButton(
                  title: "Member Creation",
                  onTap: () => Get.toNamed(Routes.memberCreation),
                ),
              ),
              C10(),
              Expanded(
                child: quickButton(
                  title: "Loan Application",
                  onTap: () => Get.toNamed(Routes.loanApplicationList),
                ),
              ),
            ],
          ),
          C10(),
          Row(
            children: [
              Expanded(
                child: quickButton(
                  title: "Due EMI",
                  onTap: () => Get.toNamed(Routes.loanEMIScreen),
                ),
              ),
              C10(),
              Expanded(
                child: quickButton(
                  title: "Pending EMI",
                  onTap: () => Get.toNamed(Routes.dueEmi),
                ),
              ),
            ],
          ),
          C10(),
          Row(
            children: [
              Expanded(
                child: quickButton(
                  title: "Group Creation",
                  onTap: () => Get.toNamed(Routes.groupList),
                ),
              ),
              C10(),
              Expanded(
                child: quickButton(
                  title: "Loan Summary",
                  onTap: () => Get.toNamed(Routes.loanSummaryScreen),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) => Text(
        title,
        style: const TextStyle(
          fontFamily: "Roboto-Medium",
          fontSize: 15,
          color: Color(0xFF616161),
        ),
      );

  Widget quickButton({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Roboto-Medium",
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget reusableCard({
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
          children: [
            Text(title,
                style: const TextStyle(
                    fontFamily: "Roboto-Bold",
                    fontSize: 15,
                    color: Colors.black)),
            Text(subTitle,
                style: const TextStyle(
                    fontFamily: "Roboto-Regular",
                    fontSize: 11,
                    color: Color(0xFF939393))),
          ],
        ),
      ),
    );
  }

  Drawer customDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade800,
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
      leading: Icon(icon, color: Colors.black),
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        color: Colors.grey,
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
}
