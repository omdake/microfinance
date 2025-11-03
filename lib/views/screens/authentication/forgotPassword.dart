import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/logic/controller/authentication/loginController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/strings.dart';
import 'package:microfinance/utils/ui_helper.dart/lable_widget.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:pinput/pinput.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.loginScreen);
        return false;
      },
      child: Scaffold(
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 23),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
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
                    child: Form(
                      key: _formKey,
                      child: Obx(
                        () => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Forgot Password",
                              style: TextStyle(
                                fontFamily: "Roboto-Medium",
                                fontSize: 22,
                                color: Color(0xFF17243E),
                              ),
                            ),
                            C15(),
                            LabelText(
                              label: Strings.Email,
                              isRequired: true,
                              child: TextFormField(
                                controller: controller.email.value,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: TextStyles.textfieldTextStyle,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.black,
                                enabled: !controller.showOtpSection.value,
                                decoration: InputDecoration(
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontFamily: "Roboto-Regular",
                                      fontSize: 12),
                                  border: _greyBorder(),
                                  enabledBorder: _greyBorder(),
                                  focusedBorder: _greyBorder(),
                                  errorBorder: _errorBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Email is required";
                                  }
                                  final emailRegex = RegExp(
                                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                                  if (!emailRegex.hasMatch(value.trim())) {
                                    return "Enter a valid email";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            if (!controller.showOtpSection.value) ...[
                              C20(),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFA52A2A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();
                                      controller.sendOTP();
                                    }
                                  },
                                  child: controller.isLoading.value
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        )
                                      : const Text(
                                          "Send OTP",
                                          style: TextStyle(
                                            fontFamily: "Roboto-Medium",
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            ] else ...[
                              C15(),
                              LabelText(
                                label: "OTP",
                                isRequired: true,
                                child: Obx(
                                  () => Pinput(
                                    length: 6,
                                    controller: controller.otp.value,
                                    autofocus: true,
                                    keyboardType: TextInputType.number,
                                    defaultPinTheme: PinTheme(
                                      height: 50,
                                      width: 50,
                                      textStyle: TextStyles.textfieldTextStyle,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    focusedPinTheme: PinTheme(
                                      height: 50,
                                      width: 50,
                                      textStyle: TextStyles.textfieldTextStyle,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.primaryOrange),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    errorPinTheme: PinTheme(
                                      height: 50,
                                      width: 50,
                                      textStyle: TextStyles.textfieldTextStyle
                                          .copyWith(color: Colors.red),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.red),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "OTP is required";
                                      }
                                      if (value.trim().length < 4 ||
                                          value.trim().length > 6) {
                                        return "OTP must be between 4-6 digits";
                                      }
                                      return null;
                                    },
                                    showCursor: true,
                                    cursor: Container(
                                      width: 2,
                                      height: 24,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              C20(),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFA52A2A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();
                                      controller.VerifyOTP();
                                    }
                                  },
                                  child: const Text(
                                    "Verify OTP",
                                    style: TextStyle(
                                      fontFamily: "Roboto-Medium",
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _greyBorder() => OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFEAECF0)),
        borderRadius: BorderRadius.circular(10),
      );

  OutlineInputBorder _errorBorder() => OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      );
}
