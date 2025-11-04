import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class MemberCreatedSuccessScreen extends StatelessWidget {
  final String applicationId;
  final String memberName;
  final String city;
  final String state;

  const MemberCreatedSuccessScreen({
    super.key,
    required this.applicationId,
    required this.memberName,
    required this.city,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryOrange,
                    width: 5,
                  ),
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.primaryOrange,
                  size: 50,
                ),
              ),
              C25(),
              const Text(
                "MEMBER CREATED\nSUCCESSFULLY",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),
              C30(),
              Column(
                children: [
                  const Text(
                    "LOAN APPLICATION",
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "ID NO: $applicationId",
                    style: const TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  C5(),
                  Text(
                    memberName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "$city, $state".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              C50(),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(Routes.homeScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 40.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB12E2E),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "BACK TO HOME",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
