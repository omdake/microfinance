import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/common_widgets/ui_helper_widgets.dart';
import 'package:microfinance/logic/controller/collectionInHand/collectionInHandListController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/views/screens/collectionInhand/collectionInHandList.dart';
import 'package:microfinance/views/screens/collectionInhand/pendingApproval.dart';

class CollectionInHand extends StatelessWidget {
  CollectionInHand({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CollectionInHandListController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Collection By Cash List"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Obx(() {
                      final isSelected = controller.selectedIndex.value == 0;
                      return InkWell(
                        onTap: () => controller.changeTab(0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(10),
                            color: isSelected
                                ? Colors.grey.shade400
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            child: Text(
                              "Pending Request",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Roboto-Medium"),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  C10(),
                  Expanded(
                    child: Obx(() {
                      final isSelected = controller.selectedIndex.value == 1;
                      return InkWell(
                        onTap: () => controller.changeTab(1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(10),
                            color: isSelected
                                ? Colors.grey.shade400
                                : Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            child: Text(
                              "Pending Approval",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Roboto-Medium"),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              C10(),
              Expanded(
                child: Obx(() {
                  final index = controller.selectedIndex.value;

                  Widget screen;
                  switch (index) {
                    case 0:
                      screen = PendingRequest();
                      break;
                    case 1:
                      screen = PendingApproval();
                      break;

                    default:
                      screen = const SizedBox();
                  }

                  return Card(
                    color: AppColors.white,
                    child: Center(child: screen),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
