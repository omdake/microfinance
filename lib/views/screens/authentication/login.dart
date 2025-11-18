import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/buttons.dart';
import 'package:microfinance/logic/controller/authentication/loginController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/themes/app_theme.dart';
import 'package:microfinance/utils/strings.dart';
import 'package:microfinance/utils/ui_helper.dart/lable_widget.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class LoginWithPassword extends StatelessWidget {
  LoginWithPassword({super.key});
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryRed,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(children: [
                  Spacer(),
                  Center(
                    child: Image.asset(
                      'assets/new/logo.png',
                      height: 160,
                      width: 160,
                    ),
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
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
                              const Text(
                                "Login",
                                style: TextStyle(
                                  fontFamily: "Roboto-Medium",
                                  fontSize: 22,
                                  color: Color(0xFF17243E),
                                ),
                              ),
                              C10(),
                              LabelText(
                                label: Strings.UserName,
                                isRequired: true,
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: TextStyles.textfieldTextStyle,
                                  controller: controller.username,
                                  decoration: InputDecoration(
                                    hintText: "Enter Username",
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontFamily: "Roboto-Regular",
                                      fontSize: 12,
                                    ),
                                    border: _greyBorder(),
                                    enabledBorder: _greyBorder(),
                                    focusedBorder: _greyBorder(),
                                    errorBorder: _errorBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Username is required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              C10(),
                              LabelText(
                                label: Strings.Password,
                                isRequired: true,
                                child: Obx(
                                  () => TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: TextStyles.textfieldTextStyle,
                                    obscureText: controller.hidePassword.value,
                                    controller: controller.password,
                                    decoration: InputDecoration(
                                      hintText: "Enter Password",
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
                                          controller.hidePassword.value =
                                              !controller.hidePassword.value;
                                        },
                                        icon: Icon(
                                          controller.hidePassword.value
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                        ),
                                      ),
                                    ),
                                    validator: (value) =>
                                        loginPasswordValidator(value!.trim()),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                    ),
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState!.validate()) {
                                        await controller.login();
                                      }
                                    },
                                    child: controller.isLoading.value
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          )
                                        : const Text(
                                            "LOGIN",
                                            style: TextStyle(
                                              fontFamily: "Roboto-Medium",
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              //C5(),
                              Center(
                                child: AppTextButton(
                                  onTap: () {
                                    Get.offAndToNamed(
                                        Routes.forgotPasswordScreen);
                                  },
                                  title: 'Forgot Password?',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, right: 8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          Text("|",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "Roboto-Medium",
                              )),
                          C5(),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "powered by: ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: "Roboto-Medium",
                                  ),
                                ),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Image.asset(
                                    'assets/new/excelllogo.png',
                                    width: 16,
                                    height: 16,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                TextSpan(
                                  text: " EXCELLENT MINDS",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Roboto-Medium",
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 8,
                      color: AppColors.primaryOrange,
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ));
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