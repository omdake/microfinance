import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primaryRed,
                width: 2,
              ),
            ),
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Text(
                "Hi",
                style: TextStyle(color: Colors.black),
              ),
            ),
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
              Text(
                controller.email.value,
                style: const TextStyle(color: Color(0xFFE3F1E3), fontSize: 14),
              ),
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
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 10),
                children: [
                  drawerTile("Profile", () => Get.toNamed(Routes.profile)),
                  listDivider(),
                  drawerTile("Member Creation",
                      () => Get.toNamed(Routes.memberCreation)),
                  listDivider(),
                  drawerTile("Loan Application",
                      () => Get.toNamed(Routes.loanApplicationList)),
                  listDivider(),
                  drawerTile(
                      "Due EMI", () => Get.toNamed(Routes.loanEMIScreen)),
                  listDivider(),
                  drawerTile("Pending EMI", () => Get.toNamed(Routes.dueEmi)),
                  listDivider(),
                  drawerTile("Loan Summary",
                      () => Get.toNamed(Routes.loanSummaryScreen)),
                  listDivider(),
                  drawerTile("Group Creation",
                      () => Get.toNamed(Routes.groupList)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  footerText("TERMS AND CONDITION", () {}),
                  footerDivider(),
                  footerText("PRIVACY POLICY", () {}),
                  C25(),
                  Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "${controller.appName.value} v${controller.version.value}",
                          style: const TextStyle(
                              fontSize: 10, color: Color(0xFF5D6675)),
                        ),
                      )),
                  C20(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget footerText(String title, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        child: Text(
          title,
          style: const TextStyle(fontSize: 10, color: Color(0xFF5D6675)),
        ),
      ),
    );
  }

  Divider footerDivider() {
    return const Divider(
      thickness: 0.4,
      color: Colors.grey,
      indent: 10,
      // endIndent: 30,
    );
  }

  Widget drawerTile(String title, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }

  Divider listDivider() {
    return const Divider(
      thickness: 0.4,
      color: Colors.grey,
      indent: 20,
      endIndent: 30,
    );
  }
}
