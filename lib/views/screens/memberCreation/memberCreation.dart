import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/nav_bar.dart';
import 'package:microfinance/logic/controller/dashboard/homeController.dart';
import 'package:microfinance/logic/controller/memberCreation/memberCreationController.dart';
import 'package:microfinance/themes/app_textstyles.dart';
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
    "PERSONAL DETAILS",
    "ADDRESS DETAILS",
    "BANK DETAILS",
    "CIBIL SCORE DETAILS",
    "DOCUMENT UPLOAD",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: Text(
          "Member Creation",
          style: TextStyles.appbartitle,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            final homeController = Get.find<HomeController>();
            homeController.changeIndex(0);
            Get.back();
          },
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
      bottomNavigationBar: const CustomBottomNavBar(),
      body: SafeArea(
        child: Column(
          children: [
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
                    break;
                  case 4:
                    screen = UploadDcumentSreen();
                    break;
                  default:
                    screen = const SizedBox();
                }

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          labels[index],
                          style: const TextStyle(
                            fontFamily: "Roboto-Medium",
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: screen,
                      )
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
