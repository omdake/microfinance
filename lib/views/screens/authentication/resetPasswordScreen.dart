import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/logic/controller/authentication/loginController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/ui_helper.dart/lable_widget.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.forgotPasswordScreen);
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Reset Password",
                              style: TextStyle(
                                fontFamily: "Roboto-Medium",
                                fontSize: 22,
                                color: Color(0xFF17243E),
                              ),
                            ),
                          ),
                          C15(),
                          LabelText(
                            label: "New Password",
                            isRequired: true,
                            child: Obx(() => TextFormField(
                                  controller: controller.newPassword.value,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: TextStyles.textfieldTextStyle,
                                  obscureText: controller.hidenewPassword.value,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintText: "Enter New Password",
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontFamily: "Roboto-Regular",
                                        fontSize: 12),
                                    border: _greyBorder(),
                                    enabledBorder: _greyBorder(),
                                    focusedBorder: _greyBorder(),
                                    errorBorder: _errorBorder(),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.hidenewPassword.value =
                                            !controller.hidenewPassword.value;
                                      },
                                      icon: Icon(
                                        controller.hidenewPassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password is required";
                                    }
                                    if (value.length < 6) {
                                      return "Password must be at least 6 characters";
                                    }
                                    return null;
                                  },
                                )),
                          ),
                          C20(),
                          LabelText(
                            label: "Confirm Password",
                            isRequired: true,
                            child: Obx(() => TextFormField(
                                  controller: controller.ConfirmPassword.value,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: TextStyles.textfieldTextStyle,
                                  obscureText:
                                      controller.hideconfirmPassword.value,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintText: "Enter Confirm Password",
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontFamily: "Roboto-Regular",
                                      fontSize: 12,
                                    ),
                                    border: _greyBorder(),
                                    enabledBorder: _greyBorder(),
                                    focusedBorder: _greyBorder(),
                                    errorBorder: _errorBorder(),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.hideconfirmPassword.value =
                                            !controller
                                                .hideconfirmPassword.value;
                                      },
                                      icon: Icon(
                                        controller.hideconfirmPassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Confirm Password is required";
                                    }
                                    if (value !=
                                        controller.newPassword.value.text) {
                                      return "Passwords do not match";
                                    }
                                    return null;
                                  },
                                )),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    await controller.ResetPassword();
                                  }
                                },
                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      )
                                    : const Text(
                                        "Reset Password",
                                        style: TextStyle(
                                          fontFamily: "Roboto-Medium",
                                          fontSize: 16,
                                          color: Colors.white,
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
