import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/logic/controller/dashboard/homeController.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Obx(() {
      return SafeArea(
        bottom: true,
        child: Container(
          color: const Color(0xFFF5F5F5),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => homeController.changeIndex(0),
                child: Image.asset(
                  'assets/new/home.png',
                  width: 30,
                  height: 30,
                  color: homeController.selectedIndex.value == 0
                      ? const Color(0xFFA52A2A)
                      : Colors.black,
                ),
              ),
              InkWell(
                onTap: () => homeController.changeIndex(1),
                child: Image.asset(
                  'assets/new/note.png',
                  width: 30,
                  height: 30,
                  color: homeController.selectedIndex.value == 1
                      ? const Color(0xFFA52A2A)
                      : Colors.black,
                ),
              ),
              InkWell(
                onTap: () => homeController.changeIndex(2),
                child: Icon(
                  Icons.apps,
                  size: 30,
                  color: homeController.selectedIndex.value == 2
                      ? const Color(0xFFA52A2A)
                      : Colors.black,
                ),
              ),
              InkWell(
                onTap: () => homeController.changeIndex(3),
                child: Image.asset(
                  'assets/new/message.png',
                  width: 30,
                  height: 30,
                  color: homeController.selectedIndex.value == 3
                      ? const Color(0xFFA52A2A)
                      : Colors.black,
                ),
              ),
              InkWell(
                onTap: () => homeController.changeIndex(4),
                child: Icon(
                  Icons.person_outline,
                  size: 30,
                  color: homeController.selectedIndex.value == 4
                      ? const Color(0xFFA52A2A)
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
