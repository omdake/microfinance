import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/logic/controller/splashController.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Welcome Micro Finance",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
