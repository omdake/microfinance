import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/logic/controller/dashboard/homeController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  void _navigateToTab(int index) {
    final homeController = Get.find<HomeController>();
    homeController.selectedIndex.value = index;
    if (Get.currentRoute != Routes.homeScreen) {
      Get.offAllNamed(Routes.homeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Obx(
      () => SafeArea(
          child: Container(
        color: const Color(0xFFF5F5F5),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIcon(Icons.home, 0, homeController),
            _buildIcon(Icons.watch_later_outlined, 1, homeController),
            _buildIcon(Icons.person_add_outlined, 2, homeController),
            _buildIcon(Icons.person_outline, 3, homeController),
          ],
        ),
      )),
    );
  }

  Widget _buildIcon(IconData icon, int index, HomeController controller) {
    return InkWell(
      onTap: () => _navigateToTab(index),
      child: Icon(
        icon,
        size: 30,
        color: controller.selectedIndex.value == index
            ? AppColors.primaryRed
            : Colors.black,
      ),
    );
  }
}
