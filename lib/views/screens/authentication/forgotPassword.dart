import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/logic/controller/authentication/loginController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/utils/strings.dart';
import 'package:microfinance/utils/ui_helper.dart/lable_widget.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>(); // added form key

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAndToNamed(Routes.loginScreen);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form( // ✅ Wrap the form here
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      C50(),
                      C50(),
                      Icon(Icons.person_outline, size: 50),
                      C20(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontFamily: "Roboto-Medium",
                            fontSize: 20,
                            color: const Color(0xFF17243E),
                          ),
                        ),
                      ),
                      C15(),
                      LabelText(
                        label: Strings.Email,
                        isRequired: true,
                        child: TextFormField(
                          controller: controller.email.value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress, // ✅
                          cursorColor: Colors.black,
                          enabled: !controller.showOtpSection.value,
                          decoration: InputDecoration(
                            hintText: "Enter Email",
                            hintStyle: const TextStyle(
                                fontFamily: "Roboto-Regular",
                                fontSize: 14,
                                color: Color(0xFF616161)),
                            border: _greyBorder(),
                            enabledBorder: _greyBorder(),
                            focusedBorder: _greyBorder(),
                            errorBorder: _errorBorder(), // ✅
                            disabledBorder: _greyBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Email is required";
                            }
                            final emailRegex = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (!emailRegex.hasMatch(value.trim())) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                      ),
                      Obx(
                        () => !controller.showOtpSection.value
                            ? Column(
                                children: [
                                  C20(),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade900,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: TextButton(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: controller.isLoading.value
                                            ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : const Text(
                                                "Send OTP",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Roboto-Medium",
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!
                                            .validate()) {
                                          FocusScope.of(context).unfocus();
                                          controller.sendOTP();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                      ),
                      Obx(
                        () => controller.showOtpSection.value
                            ? Column(
                                children: [
                                  C15(),
                                  LabelText(
                                    label: "OTP",
                                    isRequired: true,
                                    child: TextFormField(
                                      controller: controller.otp.value,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      keyboardType: TextInputType.number,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        hintText: "Enter OTP",
                                        hintStyle: const TextStyle(
                                            fontFamily: "Roboto-Regular",
                                            fontSize: 14,
                                            color: Color(0xFF616161)),
                                        border: _greyBorder(),
                                        enabledBorder: _greyBorder(),
                                        focusedBorder: _greyBorder(),
                                        errorBorder: _errorBorder(), // ✅
                                        disabledBorder: _greyBorder(),
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
                                    ),
                                  ),
                                  C15(),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade900,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: TextButton(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: const Text(
                                          "Verify OTP",
                                          style: TextStyle(
                                              fontFamily: "Roboto-Medium",
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!
                                            .validate()) {
                                          FocusScope.of(context).unfocus();
                                          controller.VerifyOTP();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _greyBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1.5,
      ),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    );
  }

  OutlineInputBorder _errorBorder() => OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      );
}
