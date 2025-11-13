import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/buttons.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/nav_bar.dart';
import 'package:microfinance/logic/controller/resetPassword/resetPasswordController.dart';
import 'package:microfinance/routes/routes_string.dart' show Routes;
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final _formKey = GlobalKey<FormState>();
  final ResetPasswordController controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: Text(
          "Reset Password",
          style: TextStyles.appbartitle,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.homeScreen);
            },
            icon: Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            )),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
      body: Obx(() {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.white],
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      paddingWidget(
                        [
                          const LabelsWithMark(
                              label: "Previous Password", isRequired: true),
                          TextFormField(
                            obscureText: true,
                            controller: controller.previousPassword.value,
                            cursorColor: AppColors.primary,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) => requiredValidator(value!),
                            style: TextStyles.textfieldTextStyle,
                            decoration: TextFieldDecoration.textfieldDecoration(
                                hint: "Enter Previous Password"),
                          ),
                        ],
                      ),
                      C10(),
                      paddingWidget(
                        [
                          const LabelsWithMark(
                              label: "New Password", isRequired: true),
                          Obx(
                            () => TextFormField(
                              controller: controller.newPassword.value,
                              obscureText: controller.hidePassword.value,
                              cursorColor: AppColors.primary,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textCapitalization: TextCapitalization.none,
                              style: TextStyles.textfieldTextStyle,
                              validator: (value) => requiredValidator(value!),
                              decoration: TextFieldDecoration
                                  .textfieldDecorationChangePassword(
                                hint: "Enter New Password",
                                sufficIconOntap: () {
                                  controller.hidePassword.value =
                                      !controller.hidePassword.value;
                                },
                                sufficIcon: Icon(
                                  controller.hidePassword.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      C10(),
                      paddingWidget(
                        [
                          LabelsWithMark(
                            label: "Confirm Password",
                            isRequired: true,
                          ),
                          TextFormField(
                            obscureText: controller.confirmHidePassword.value,
                            controller: controller.confirmPassword.value,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: AppColors.primary,
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyles.textfieldTextStyle,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              } else if (value !=
                                  controller.newPassword.value.text) {
                                return "Confirm password does not match new password";
                              }
                              return null;
                            },
                            decoration: TextFieldDecoration
                                .textfieldDecorationChangePassword(
                              hint: "Enter Confirm Password",
                              sufficIconOntap: () {
                                controller.confirmHidePassword.value =
                                    !controller.confirmHidePassword.value;
                              },
                              sufficIcon: Icon(
                                controller.confirmHidePassword.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      C10(),
                      AppButton(
                          title: "save",
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              controller.resetPassword();
                            } else {
                              AppTostMassage.showTostMassage(
                                massage: "Please fill all required fields",
                              );
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
