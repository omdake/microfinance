import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/nav_bar.dart';
import 'package:microfinance/logic/controller/dashboard/homeController.dart';
import 'package:microfinance/views/screens/dashboard/dashboardScreen.dart';
import 'package:microfinance/views/screens/LoanEMI/dueEmiScreen.dart';
import 'package:microfinance/views/screens/memberCreation/memberCreation.dart';
import 'package:microfinance/views/screens/profile/ProfileScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  final List<Widget> _screens = [
    DashboardScreen(),
    DueEMIScreen(),
    MemberCreationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _screens[homeController.selectedIndex.value],
        bottomNavigationBar: const CustomBottomNavBar(),
      ),
    );
  }
}
