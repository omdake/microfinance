import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/logic/controller/memberCreation/memberCreationController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class CibilDetailscSreen extends StatelessWidget {
  CibilDetailscSreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final MemberCreationController controller =
      Get.put(MemberCreationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
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
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    paddingWidget(
                      [
                        const LabelsWithMark(
                          label: "Cibil Score",
                        ),
                        TextFormField(
                          enabled: !controller.isReadOnly.value,
                          controller: controller.cibilScore.value,
                          cursorColor: AppColors.primary,
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.name,
                          style: TextStyles.textfieldTextStyle,
                          decoration: TextFieldDecoration.textfieldDecoration(
                                  hint: "Cibil Score")
                              .copyWith(
                                  filled: true,
                                  fillColor: !controller.isReadOnly.value
                                      ? Colors.white
                                      : Colors.grey.shade200),
                        ),
                      ],
                    ),
                    C10(),
                    paddingWidget(
                      [
                        const LabelsWithMark(
                          label: "Cibil Date",
                        ),
                        Obx(
                          () => TextFormField(
                            enabled: !controller.isReadOnly.value,
                            controller: controller.cibilDate.value,
                            cursorColor: AppColors.primary,
                            readOnly: true,
                            onTap: () => controller.selectDate(
                                context, controller.cibilDate.value),
                            style: TextStyles.textfieldTextStyle,
                            decoration:
                                TextFieldDecoration.textfieldDecorationicon(
                              hint: "Cibil Date",
                              sufficIcon: Icons.calendar_today,
                              sufficIconOntap: () => controller.selectDate(
                                  context, controller.cibilDate.value),
                            ).copyWith(
                                    filled: true,
                                    fillColor: !controller.isReadOnly.value
                                        ? Colors.white
                                        : Colors.grey.shade200),
                          ),
                        ),
                      ],
                    ),
                    C20(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.selectedIndex.value = 2;
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryOrange,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  controller.updateLoanMember();
                                } else {
                                  AppTostMassage.showTostMassage(
                                    massage: "Please fill all required fields",
                                  );
                                }
                                controller.selectedIndex.value = 4;
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryOrange,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])),
            ),
          ),
        ));
  }
}
