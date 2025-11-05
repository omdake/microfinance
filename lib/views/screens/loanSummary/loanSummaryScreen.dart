import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/logic/controller/loanSummary/loanSummaryController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/views/screens/loanSummary/disbursement.dart';
import 'package:microfinance/views/screens/loanSummary/repaymentScreen.dart';

class LoanSummaryScreen extends StatelessWidget {
  LoanSummaryScreen({super.key});
  final controller = Get.put(LoanSummaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: Text("Loan Summary List", style: TextStyles.appbartitle),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(Routes.homeScreen),
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.arrow_back, color: Colors.black, size: 20),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                Widget screen;
                switch (controller.selectedIndex.value) {
                  case 0:
                    screen = DisbursementScreen();
                    break;
                  case 1:
                    screen = RepaymentScreen();
                    break;
                  default:
                    screen = const SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: screen,
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
                    _bottomTab(title: "DISBURSEMENT", index: 0),
                    Container(
                      width: 1,
                      height: 45,
                      color: Colors.grey.shade300,
                    ),
                    _bottomTab(title: "REPAYMENT", index: 1),
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
