import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/logic/controller/collectionInHand/collectionInHandListController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/views/screens/collectionInhand/collectionInHandList.dart';
import 'package:microfinance/views/screens/collectionInhand/pendingApproval.dart';

class CollectionInHand extends StatelessWidget {
  CollectionInHand({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CollectionInHandListController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: Text("Collection In Hand", style: TextStyles.appbartitle),
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
                    screen = PendingRequest();
                    break;
                  case 1:
                    screen = PendingApproval();
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
                    _bottomTab(title: "Pending Request", index: 0),
                    Container(
                      width: 1,
                      height: 45,
                      color: Colors.grey.shade300,
                    ),
                    _bottomTab(title: "Pending Approval", index: 1),
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
    final controller = Get.find<CollectionInHandListController>();
    final bool isSelected = controller.selectedIndex.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontFamily: "Roboto-Medium",
                fontSize: 13,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 3,
              color: isSelected ? AppColors.primaryOrange : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
