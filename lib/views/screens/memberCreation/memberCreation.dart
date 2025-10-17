import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/logic/controller/memberCreation/memberCreationController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/views/screens/memberCreation/cibilDetailsScreen.dart';
import 'package:microfinance/views/screens/memberCreation/personalDetails.dart';
import 'package:microfinance/views/screens/memberCreation/addressDetailsScreen.dart';
import 'package:microfinance/views/screens/memberCreation/bankDetailsScreen.dart';
import 'package:microfinance/views/screens/memberCreation/uploadDocumentScreen.dart';

class MemberCreationScreen extends StatelessWidget {
  MemberCreationScreen({super.key});

  final MemberCreationController controller =
      Get.put(MemberCreationController());

  final List<String> labels = [
    "Personal Details",
    "Address Details",
    "Bank Details",
    "Cibil Details",
    "Upload Document",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Member Creation"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(labels.length, (index) {
                  return Expanded(
                    child: Obx(() {
                      final isSelected =
                          controller.selectedIndex.value == index;
                      return InkWell(
                        onTap: () => controller.selectButton(index),
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
                                horizontal: 6, vertical: 2),
                            child: Text(
                              labels[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Roboto-Medium",
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
              C10(),
              Expanded(
                child: Obx(() {
                  final index = controller.selectedIndex.value;

                  Widget screen;
                  switch (index) {
                    case 0:
                      screen = PersonalDetailsScreen();
                      break;
                    case 1:
                      screen = AddressDetailsScreen();
                      break;
                    case 2:
                      screen = BankDetailscSreen();
                      break;
                    case 3:
                      screen = CibilDetailscSreen();
                      case 4:
                      screen = UploadDcumentSreen();
                      break;
                    default:
                      screen = const SizedBox();
                  }

                  return Card(
                    color: AppColors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: screen,
                    ),
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
