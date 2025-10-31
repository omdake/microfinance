import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/logic/controller/splashController.dart';
import 'package:microfinance/themes/app_theme.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: AppColors.primaryRed,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            C50(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: Image.asset(
                      'assets/new/currency.png',
                    ),
                  ),
                ),
                C25(),
                const Text(
                  "SMALL STEPS",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto-Regular",
                    fontSize: 20,
                    //letterSpacing: 1.2,
                  ),
                ),
                const Text(
                  "BIG DREAM",
                  style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                   // letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tejraj Micro Association",
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 10,
                        ),
                      ),
                      C5(),
                      Text(
                        "|",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      C5(),
                      Text(
                        "EXCELLENT MINDS",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
