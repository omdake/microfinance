import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/logic/controller/dashboard/dasboardController.dart';
import 'package:microfinance/logic/controller/dashboard/homeController.dart';
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
    String initials = getInitials(controller.fullName.value);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        children: [
          Obx(() {
            final imageFile = controller.memberImage.value;
            final imageUrl = controller.memberImageUrl.value;

            Widget avatarChild;

            if (imageFile != null) {
              avatarChild = CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: FileImage(imageFile),
              );
            } else if (imageUrl.isNotEmpty) {
              avatarChild = CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade300,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    httpHeaders: {'Authorization': controller.token.value},
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Center(
                      child: Text(
                        initials,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Text(
                        initials,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              avatarChild = CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade300,
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            }

            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryOrange, width: 2),
              ),
              padding: const EdgeInsets.all(4),
              child: avatarChild,
            );
          }),
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
                style: const TextStyle(
                  color: Color(0xFFE3F1E3),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getInitials(String name) {
    if (name.trim().isEmpty) return "?";
    List<String> parts = name.trim().split(" ");
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
  Widget drawerBody(BuildContext context, DashboardController controller) {
    final HomeController homeController = Get.find<HomeController>();

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
                  drawerTile("Profile", () {
                    Get.back();
                    homeController.changeIndex(3);
                  }),
                  listDivider(),
                  // drawerTile("Dashboard", () {
                  //   Get.back();
                  //   homeController.changeIndex(0);
                  // }),
                  //listDivider(),
                  drawerTile("Pending EMI", () {
                    Get.back();
                    homeController.changeIndex(1);
                  }),
                  listDivider(),
                  drawerTile("Due EMI", () {
                    Get.back();
                    homeController.changeIndex(2);
                  }),
                  listDivider(),
                  drawerTile("Member Creation",
                      () => Get.toNamed(Routes.memberCreation)),
                  listDivider(),
                  drawerTile("Loan Application", () => Get.toNamed(Routes.loanApplicationList)),
                  listDivider(),
                  drawerTile("Loan Summary",
                      () => Get.toNamed(Routes.loanSummaryScreen)),
                  listDivider(),
                  drawerTile(
                      "Group Creation", () => Get.toNamed(Routes.groupList)),
                ],
              ),
            ),
            // Footer remains the same
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  footerText("TERMS AND CONDITION", () {}),
                  footerDivider(),
                  footerText("PRIVACY POLICY", () {}),
                  C15(),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: InkWell(
                        onTap: () {
                          DevService.instance.openDevScreen(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${controller.appName.value} v${controller.version.value} (${controller.buildNumber.value})",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  })
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
