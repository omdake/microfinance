import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/common_widgets/ui_helper_widgets.dart';
import 'package:microfinance/logic/controller/loanSummary/loanDetailsController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/views/screens/loanSummary/detailScreen.dart';
import 'package:microfinance/views/screens/loanSummary/scheduleScreen.dart';

class LoanDetails extends StatelessWidget {
  LoanDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoanDetailsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Loan Details"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                Widget screen;
                switch (controller.selectedIndex.value) {
                  case 0:
                    screen = DetailsScreen();
                    break;
                  case 1:
                    screen = ScheduleScreen();
                    break;
                  default:
                    screen = const SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: AppColors.white,
                    child: screen,
                  ),
                );
              }),
            ),
            Obx(() {
              return Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    _bottomTab(title: "DETAILS", index: 0),
                    Container(
                      width: 1,
                      height: 45,
                      color: Colors.grey.shade300,
                    ),
                    _bottomTab(title: "SCHEDULE", index: 1),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _bottomTab({required String title, required int index}) {
    final controller = Get.find<LoanDetailsController>();
    final bool isSelected = controller.selectedIndex.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            C10(),
            Text(
              title,
              style: TextStyle(
                fontFamily: "Roboto-Medium",
                fontSize: 13,
                color: Colors.black,
              ),
            ),
            C5(),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Container(
                height: kBottomNavigationBarHeight * 0.07,
                color:
                    isSelected ? AppColors.primaryOrange : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
