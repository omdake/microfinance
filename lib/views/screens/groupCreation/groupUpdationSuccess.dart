import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class GroupUpdationSuccess extends StatelessWidget {
  final String applicantName;
  final String group;

  const GroupUpdationSuccess({
    super.key,
    required this.applicantName,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primaryOrange,
                    width: 4,
                  ),
                ),
                child: Icon(
                  Icons.check,
                  size: 40,
                  color: AppColors.primaryOrange,
                ),
              ),
              C15(),
              const Text(
                "GROUP UPDATED\nSUCCESSFULLY",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1,
                  fontFamily: "Roboto-Medium",
                ),
              ),
              C50(),
              Column(
                children: [
                  C10(),
                  Text(
                    applicantName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "Roboto-Medium",
                    ),
                  ),
                  Text(
                    "$group",
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "Roboto-Medium",
                    ),
                  ),
                ],
              ),
              C50(),
              GestureDetector(
                onTap: () => Get.offAllNamed(Routes.groupList),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB51C1C),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "BACK TO HOME",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: "Roboto-Medium",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
