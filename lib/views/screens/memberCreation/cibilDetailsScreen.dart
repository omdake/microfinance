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
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.5),
                width: 1.5,
              )),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
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
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    keyboardType: TextInputType.name,
                                    style: TextStyles.textfieldTextStyle,
                                    decoration:
                                        TextFieldDecoration.textfieldDecoration(
                                                hint: "Cibil Score")
                                            .copyWith(
                                                filled: true,
                                                fillColor:
                                                    !controller.isReadOnly.value
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
                                      onTap: () => controller.selectDate1(
                                          context, controller.cibilDate.value),
                                      style: TextStyles.textfieldTextStyle,
                                      decoration: TextFieldDecoration
                                          .textfieldDecorationicon(
                                        hint: "Cibil Date",
                                        sufficIcon: Icons.calendar_today,
                                        sufficIconOntap: () =>
                                            controller.selectDate(context,
                                                controller.cibilDate.value),
                                      ).copyWith(
                                          filled: true,
                                          fillColor: !controller.isReadOnly.value
                                              ? Colors.white
                                              : Colors.grey.shade200),
                                    ),
                                  ),
                                ],
                              ),
                            ])),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.selectedIndex.value = 2;
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.primaryOrange,
                              shape: BoxShape.circle,
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (controller.isReadOnly.value) {
                              controller.selectedIndex.value = 4;
                              return;
                            }
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
                            decoration: const BoxDecoration(
                              color: AppColors.primaryOrange,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Obx(() {
                  return controller.isLoading.value
                      ? Container(
                          color: Colors.white.withOpacity(0.3),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryOrange,
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                }),
              ],
            ),
          ),
        ));
  }
}
