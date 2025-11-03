import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/logic/controller/dashboard/homeController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/views/screens/dashboard/dashboardScreen.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      // drawer: CustomDrawer(context),     
      body: Obx(() {
        switch (controller.selectedIndex.value) {
          case 0:
            return DashboardScreen();
          // case 1:
          //   return LoanApplicationScreen();
          // case 2:
          //   return LoanApplicationScreen();
          // case 3:
          //   return LoanApplicationScreen();
          // case 4:
          //   return ProfileScreen();
          // case 5:
          //   return ProfileScreen();
          default:
            return DashboardScreen();
        }
      }),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: const Color(0xFFF5F5F5),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            height: kBottomNavigationBarHeight,
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => controller.changeIndex(0),
                      child: Image.asset(
                        'assets/new/home.png',
                        width: 30,
                        height: 30,
                        color: controller.selectedIndex.value == 0
                            ? AppColors.primaryRed
                            : Colors.black, 
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.changeIndex(1),
                      child: Image.asset(
                        'assets/new/note.png',
                        width: 30,
                        height: 30,
                        color: controller.selectedIndex.value == 1
                            ? AppColors.primaryRed
                            : Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.changeIndex(2),
                      child: Icon(
                        Icons.apps,
                        size: 30,
                        color: controller.selectedIndex.value == 2
                            ? AppColors.primaryRed
                            : Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.changeIndex(3),
                      child: Image.asset(
                        'assets/new/message.png',
                        width: 30,
                        height: 30,
                        color: controller.selectedIndex.value == 3
                            ? AppColors.primaryRed
                            : Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.changeIndex(4),
                      child: Icon(
                        Icons.person_outline,
                        size: 30,
                        color: controller.selectedIndex.value == 4
                            ? AppColors.primaryRed
                            : Colors.black,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
