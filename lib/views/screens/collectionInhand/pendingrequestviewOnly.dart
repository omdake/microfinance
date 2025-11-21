import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/uploadFile.dart'
    show imagePickerField;
import 'package:microfinance/logic/controller/collectionInHand/collectionInHandController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class PendingApprovalViewOnlyScreen extends StatelessWidget {
  PendingApprovalViewOnlyScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final CollectionInHandController controller =
      Get.put(CollectionInHandController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Create Collection In Hand"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.5),
              ),
            ),
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
                                label: "Employee", isRequired: true),
                            TextFormField(
                              enabled: !controller.isReadOnly.value,
                              controller: controller.employee.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => requiredValidator(value!),
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Employee")
                                      .copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                        C10(),
                        paddingWidget(
                          [
                            LabelsWithMark(label: "Employee Name"),
                            TextFormField(
                              enabled: !controller.isReadOnly.value,
                              controller: controller.employeeName.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Employee Name")
                                      .copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                        C10(),
                        paddingWidget(
                          [
                            const LabelsWithMark(
                                label: "Posting Date", isRequired: true),
                            Obx(
                              () => TextFormField(
                                enabled: !controller.isReadOnly.value,
                                controller: controller.postingDate.value,
                                cursorColor: AppColors.primary,
                                readOnly: true,
                                onTap: () => controller.selectDate(
                                    context, controller.postingDate.value),
                                validator: (value) => requiredValidator(value!),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: TextStyles.textfieldTextStyle,
                                decoration:
                                    TextFieldDecoration.textfieldDecorationicon(
                                  hint: " Enter Posting Date",
                                  sufficIcon: Icons.calendar_today,
                                  sufficIconOntap: () => controller.selectDate(
                                      context, controller.postingDate.value),
                                ).copyWith(
                                  filled: true,
                                  fillColor: controller.isFormEdit.value
                                      ? Colors.white
                                      : Colors.grey.shade200,
                                ),
                              ),
                            ),
                          ],
                        ),
                        C10(),
                        paddingWidget(
                          [
                            const LabelsWithMark(
                                label: "Amount", isRequired: true),
                            TextFormField(
                              controller: controller.amount.value,
                              enabled: !controller.isReadOnly.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyles.textfieldTextStyle,
                              validator: (value) => requiredValidator(value!),
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                hint: "Enter Amount",
                              ).copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                        C10(),
                        paddingWidget(
                          [
                            const LabelsWithMark(
                                label: " Give To", isRequired: true),
                            TextFormField(
                              controller: controller.givenTo.value,
                              enabled: !controller.isReadOnly.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyles.textfieldTextStyle,
                              validator: (value) => requiredValidator(value!),
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                hint: "Enter Amount",
                              ).copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                        C10(),
                        if (controller.givenTo.value.text == "Employee")
                          paddingWidget([
                            const LabelsWithMark(
                                label: "Amount Given To", isRequired: true),
                            TextFormField(
                              controller: controller.amountgivenTo.value,
                              enabled: !controller.isReadOnly.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyles.textfieldTextStyle,
                              validator: (value) => requiredValidator(value!),
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                hint: "Enter Amount Given To",
                              ).copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ])
                        else if (controller.givenTo.value.text == "Bank")
                          paddingWidget([
                            const LabelsWithMark(
                                label: "Bank Name", isRequired: true),
                            TextFormField(
                              controller: controller.bankName.value,
                              enabled: !controller.isReadOnly.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.text,
                              style: TextStyles.textfieldTextStyle,
                              validator: (value) => requiredValidator(value!),
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                hint: "Enter Bank Name",
                              ).copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ]),
                        C10(),
                        imagePickerField(
                          // isEnabled: !controller.isReadOnly.value,
                          label: "Payment Proof",
                          readOnlyFlag: controller.isReadOnly,
                          imageFile: controller.paymentProofImage,
                          imageUrl: controller.paymentProofUrl,
                          isFocused: controller.isPaymentProofImageFocused,
                          onTap: () => controller
                              .pickImage(controller.paymentProofImage),
                        ),
                      ],
                    ),
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
