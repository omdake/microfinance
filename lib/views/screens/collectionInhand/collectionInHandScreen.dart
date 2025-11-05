import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/uploadFile.dart';
import 'package:microfinance/logic/controller/collectionInHand/collectionInHandController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class CollectionInHandScreen extends StatelessWidget {
  CollectionInHandScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final CollectionInHandController controller =
      Get.put(CollectionInHandController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          elevation: 0,
          title: Text(
            "Add Cash Collection",
            style: TextStyles.appbartitle,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.offAllNamed(Routes.collectionInHand);
              },
              icon: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              )),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  child: Center(
                    child: Text(
                      "ADD COLLECTION DETAILS",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Roboto-Regular",
                        color: Color(0xFF050708),
                      ),
                    ),
                  ),
                ),
                C10(),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    paddingWidget(
                                      [
                                        const LabelsWithMark(
                                            label: "Employee",
                                            isRequired: true),
                                        TextFormField(
                                          controller: controller.employee.value,
                                          cursorColor: AppColors.primary,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          validator: (value) =>
                                              requiredValidator(value!),
                                          keyboardType: TextInputType.name,
                                          style: TextStyles.textfieldTextStyle,
                                          decoration: TextFieldDecoration
                                              .textfieldDecoration(
                                                  hint: "Employee"),
                                        ),
                                      ],
                                    ),
                                    C10(),
                                    paddingWidget(
                                      [
                                        LabelsWithMark(label: "Employee Name"),
                                        TextFormField(
                                          controller:
                                              controller.employeeName.value,
                                          cursorColor: AppColors.primary,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          keyboardType: TextInputType.name,
                                          style: TextStyles.textfieldTextStyle,
                                          decoration: TextFieldDecoration
                                              .textfieldDecoration(
                                                  hint: "Employee Name"),
                                        ),
                                      ],
                                    ),
                                    C10(),
                                    paddingWidget(
                                      [
                                        const LabelsWithMark(
                                            label: "Posting Date",
                                            isRequired: true),
                                        Obx(
                                          () => TextFormField(
                                            controller:
                                                controller.postingDate.value,
                                            cursorColor: AppColors.primary,
                                            readOnly: true,
                                            onTap: () => controller.selectDate(
                                                context,
                                                controller.postingDate.value),
                                            validator: (value) =>
                                                requiredValidator(value!),
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style:
                                                TextStyles.textfieldTextStyle,
                                            decoration: TextFieldDecoration
                                                .textfieldDecorationicon(
                                              hint: " Enter Posting Date",
                                              sufficIcon: Icons.calendar_today,
                                              sufficIconOntap: () =>
                                                  controller.selectDate(
                                                      context,
                                                      controller
                                                          .postingDate.value),
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
                                          cursorColor: AppColors.primary,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: TextStyles.textfieldTextStyle,
                                          validator: (value) =>
                                              requiredValidator(value!),
                                          decoration: TextFieldDecoration
                                              .textfieldDecoration(
                                            hint: "Enter Amount",
                                          ),
                                        ),
                                      ],
                                    ),
                                    C10(),
                                    paddingWidget([
                                      const LabelsWithMark(
                                          label: "Give To", isRequired: true),
                                      Obx(() {
                                        return DropdownButtonFormField<String>(
                                          decoration: TextFieldDecoration
                                              .textfieldDecoration(
                                            hint: "Select Amount Given To",
                                          ),
                                          style: TextStyles.textfieldTextStyle,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          items: controller.giventoList
                                              .map((givento) {
                                            return DropdownMenuItem<String>(
                                              value: givento,
                                              child: Text(givento),
                                            );
                                          }).toList(),
                                          value: controller.selectedGivenTo
                                                  .value.isNotEmpty
                                              ? controller.selectedGivenTo.value
                                              : null,
                                          onChanged: (value) {
                                            if (value != null) {
                                              controller.selectedGivenTo.value =
                                                  value;
                                              controller.amountgivenTo.value
                                                  .clear();
                                              controller.getemployeeList();
                                            }
                                          },
                                          validator: (value) {
                                            if (controller.selectedGivenTo.value
                                                .isEmpty) {
                                              return 'Given To is required';
                                            }
                                            return null;
                                          },
                                        );
                                      }),
                                    ]),
                                    C10(),
                                    Obx(() {
                                      if (controller.selectedGivenTo.value ==
                                          "Employee") {
                                        return paddingWidget([
                                          const LabelsWithMark(
                                              label: "Amount Given To Employee",
                                              isRequired: true),
                                          DropdownButtonFormField<String>(
                                            decoration: TextFieldDecoration
                                                .textfieldDecoration(
                                              hint: "Select Employee",
                                            ),
                                            style:
                                                TextStyles.textfieldTextStyle,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            items: controller.employeeList
                                                .map((employee) {
                                              return DropdownMenuItem<String>(
                                                value: employee.employee,
                                                child: Text(
                                                    employee.employeeName ??
                                                        ''),
                                              );
                                            }).toList(),
                                            value: controller
                                                    .selectedamountGivenTo
                                                    .value
                                                    .isNotEmpty
                                                ? controller
                                                    .selectedamountGivenTo.value
                                                : null,
                                            onChanged: (value) {
                                              if (value != null) {
                                                controller.selectedamountGivenTo
                                                    .value = value;
                                                controller
                                                    .selectedAmountGivenToEmployeeId
                                                    .value = value;
                                              }
                                            },
                                            validator: (value) {
                                              if (controller
                                                  .selectedamountGivenTo
                                                  .value
                                                  .isEmpty) {
                                                return 'Amount Given Employee is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ]);
                                      } else {
                                        return const SizedBox();
                                      }
                                    }),
                                    Obx(() {
                                      if (controller.selectedGivenTo.value ==
                                          "Bank") {
                                        return paddingWidget([
                                          const LabelsWithMark(
                                              label: "Bank", isRequired: true),
                                          TextFormField(
                                            controller:
                                                controller.bankAmount.value,
                                            cursorColor: AppColors.primary,
                                            textCapitalization:
                                                TextCapitalization.none,
                                            keyboardType: TextInputType.text,
                                            style:
                                                TextStyles.textfieldTextStyle,
                                            validator: (value) =>
                                                requiredValidator(value!),
                                            decoration: TextFieldDecoration
                                                .textfieldDecoration(
                                              hint: "Enter Bank Name",
                                            ),
                                          ),
                                        ]);
                                      } else {
                                        return const SizedBox();
                                      }
                                    }),
                                    C10(),
                                    Obx(() {
                                      return imagePickerField(
                                        label: "Payment Proof",
                                        imageFile: controller.paymentProofImage,
                                        imageUrl: RxString(controller
                                                .collectionInHandList.isNotEmpty
                                            ? controller.collectionInHandList[0]
                                                    .paymentProof ??
                                                ''
                                            : ''),
                                        isFocused: controller
                                            .isPaymentProofImageFocused,
                                        onTap: () => controller.pickImage(
                                            controller.paymentProofImage),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  controller.saveCollectionInHand();
                                } else {
                                  AppTostMassage.showTostMassage(
                                    massage: "Please fill all required fields",
                                  );
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryOrange,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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
}
