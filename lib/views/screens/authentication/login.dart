import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/buttons.dart';
import 'package:microfinance/logic/controller/authentication/loginController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_theme.dart';
import 'package:microfinance/utils/strings.dart';
import 'package:microfinance/utils/ui_helper.dart/lable_widget.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class LoginWithPassword extends StatelessWidget {
  LoginWithPassword({super.key});
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryRed,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 8,
                  color: AppColors.primaryOrange,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 23),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontFamily: "Roboto-Medium",
                          fontSize: 22,
                          color: Color(0xFF17243E),
                        ),
                      ),
                      C15(),
                      LabelText(
                        label: Strings.UserName,
                        isRequired: true,
                        child: TextFormField(
                          controller: controller.username,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: "Enter Mobile/Email/Employee ID",
                            hintStyle: TextStyle(
                              fontFamily: "Roboto-Regular",
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                            border: _greyBorder(),
                            enabledBorder: _greyBorder(),
                            focusedBorder: _greyBorder(),
                          ),
                        ),
                      ),
                      C10(),
                      LabelText(
                        label: Strings.Password,
                        isRequired: true,
                        child: TextFormField(
                          controller: controller.password,
                          obscureText: true,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: "Enter Your Password",
                            hintStyle: TextStyle(
                              fontFamily: "Roboto-Regular",
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                            border: _greyBorder(),
                            enabledBorder: _greyBorder(),
                            focusedBorder: _greyBorder(),
                          ),
                        ),
                      ),
                      C20(),
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFA52A2A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              await controller.login();
                            },
                            child: controller.isLoading.value
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "SING IN",
                                    style: TextStyle(
                                      fontFamily: "Roboto-Medium",
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      C5(),
                      Center(
                        child: AppTextButton(
                          onTap: () {
                            Get.offAndToNamed(Routes.forgotPasswordScreen);
                          },
                          title: 'Forgot Password?',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontFamily: "Roboto-Regular",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _greyBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
