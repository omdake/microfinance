import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/buttons.dart';
import 'package:microfinance/logic/controller/authentication/loginController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/utils/strings.dart';
import 'package:microfinance/utils/ui_helper.dart/lable_widget.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class LoginWithPassword extends StatelessWidget {
  LoginWithPassword({super.key});
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  C50(),
                  C50(),
                  Icon(Icons.person_outline, size: 50),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: "Roboto-Medium",
                        fontSize: 22,
                        color: const Color(0xFF17243E),
                      ),
                    ),
                  ),
                  C20(),
                  LabelText(
                    label: Strings.UserName,
                    isRequired: true,
                    child: TextFormField(
                      controller: controller.username,
                      autovalidateMode: AutovalidateMode.disabled,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Enter Username",
                        hintStyle: const TextStyle(
                            fontFamily: "Roboto-Regular",
                            fontSize: 14,
                            color: Color(0xFF616161)),
                        border: _greyBorder(),
                        enabledBorder: _greyBorder(),
                        focusedBorder: _greyBorder(),
                        errorBorder: _greyBorder(),
                        disabledBorder: _greyBorder(),
                      ),
                    ),
                  ),
                  C10(),
                  LabelText(
                    label: Strings.Password,
                    isRequired: true,
                    child: TextFormField(
                      controller: controller.password,
                      autovalidateMode: AutovalidateMode.disabled,
                      obscureText: true,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        hintStyle: const TextStyle(
                            fontFamily: "Roboto-Regular",
                            fontSize: 14,
                            color: Color(0xFF616161)),
                        border: _greyBorder(),
                        enabledBorder: _greyBorder(),
                        focusedBorder: _greyBorder(),
                        errorBorder: _greyBorder(),
                        disabledBorder: _greyBorder(),
                      ),
                    ),
                  ),
                  C20(),
                  Obx(
                    () => Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                  "Login",
                                  style: TextStyle(
                                      fontFamily: "Roboto-Medium",
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                        ),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          await controller.login();
                        },
                      ),
                    ),
                  ),
                  C10(),
                  AppTextButton(
                    onTap: () {
                      Get.offAndToNamed(Routes.forgotPasswordScreen);
                    },
                    title: 'Forgot Password',
                    style: TextStyle(
                        color: Colors.grey, fontFamily: "Inter-Regular"),
                  ),
                ],
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
}
