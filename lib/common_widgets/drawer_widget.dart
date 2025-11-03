import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/logic/controller/dashboard/dasboardController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();

    return Drawer(
      backgroundColor: AppColors.primaryRed,
      child: SafeArea(
        child: Column(
          children: [
            drawerHeader(controller),
            Expanded(
              child: drawerBody(context, controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerHeader(DashboardController controller) {
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
              Text(
                controller.fullName.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
               C5(),
              // Text(
              //   controller.email,
              //   style: const TextStyle(color: Colors.white70, fontSize: 14),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget drawerBody(BuildContext context, DashboardController controller) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(35)),
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            drawerTile(Icons.person_outline, "Profile",
                () => Get.toNamed(Routes.profile)),
            listDivider(),
            drawerTile(Icons.person_add_outlined, "Member Creation",
                () => Get.toNamed(Routes.memberCreation)),
            listDivider(),
            drawerTile(Icons.note_add_outlined, "Loan Application",
                () => Get.toNamed(Routes.loanApplicationList)),
            listDivider(),
            drawerTile(Icons.payments_outlined, "Loan EMI",
                () => Get.toNamed(Routes.loanEMIScreen)),
            listDivider(),
            drawerTile(Icons.summarize_outlined, "Loan Summary",
                () => Get.toNamed(Routes.loanSummaryScreen)),
            listDivider(),
            drawerTile(
                Icons.logout_outlined, "Logout", showLogoutConfirmationDialog),
            listDivider(),
            drawerTile(Icons.settings, "Reset Password",
                () => Get.toNamed(Routes.resetPassword)),
            listDivider(),
            Obx(() => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 12,
                  ),
                  child: Center(
                    child: Text(
                      "${controller.appName.value} v${controller.version.value}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget drawerTile(IconData icon, String title, VoidCallback? onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryOrange),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      title: Text(title, style: const TextStyle(color: Colors.black)),
      onTap: onTap,
    );
  }

  Divider listDivider() {
    return const Divider(
      thickness: 0.4,
      color: Colors.grey,
      indent: 50,
      endIndent: 30,
    );
  }

  void showLogoutConfirmationDialog() {
    Get.dialog(
      AlertDialog(
        content: const Text("Are you sure you want to logout?"),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            onPressed: () async {
              await AppPreferences.clearPreferences();
              Get.offAllNamed(Routes.loginScreen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.black,
              foregroundColor: Colors.white,
            ),
            child: const Text("Yes"),
          ),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[100],
              foregroundColor: Colors.red[900],
            ),
            child: const Text("No"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
