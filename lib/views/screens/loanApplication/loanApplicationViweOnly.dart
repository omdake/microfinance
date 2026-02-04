import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/common_widgets/nav_bar.dart';
import 'package:microfinance/logic/controller/loanApplication/loanApplicationViewOnlyController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/validator.dart';

class LoanApplicationViewOnlyScreen extends StatelessWidget {
  LoanApplicationViewOnlyScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _popupKey = GlobalKey<FormState>();
  final LoanApplicationViewOnlyController controller =
      Get.put(LoanApplicationViewOnlyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Loan Application Creation", actions: [
        Visibility(
          visible: controller.isReadOnly.value,
          child: IconButton(
              onPressed: () {
                controller.selectedPrintFormat.value = "";
                Get.dialog(
                    barrierDismissible: false,
                    Dialog(
                      insetPadding: EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                key: _popupKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Select Report Format",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Roboto-Regular"),
                                      ),
                                    ),
                                    C20(),
                                    const LabelsWithMark(
                                      label: "Report Format",
                                      isRequired: true,
                                    ),
                                    Obx(() {
                                      return DropdownButtonFormField<String>(
                                        value: controller.selectedPrintFormat
                                                .value.isEmpty
                                            ? null
                                            : controller
                                                .selectedPrintFormat.value,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        hint: Text(
                                          "Select report format",
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontFamily: "Roboto-Regular",
                                            fontSize: 12,
                                          ),
                                        ),
                                        items: controller.printFormatStaticList
                                            .map((e) {
                                          return DropdownMenuItem<String>(
                                            value: e["value"],
                                            child: Text(e["label"] ?? ""),
                                          );
                                        }).toList(),
                                        selectedItemBuilder: (context) {
                                          return controller
                                              .printFormatStaticList
                                              .map((e) {
                                            return Text(
                                              e["label"] ?? "",
                                              style:
                                                  TextStyles.textfieldTextStyle,
                                            );
                                          }).toList();
                                        },
                                        onChanged: (newValue) {
                                          if (newValue != null) {
                                            controller.selectedPrintFormat
                                                .value = newValue;
                                            final selectedItem = controller
                                                .printFormatStaticList
                                                .firstWhere((e) =>
                                                    e["value"] == newValue);
                                            controller.selectedPrintFormatLabel
                                                    .value =
                                                selectedItem["label"] ?? "";
                                          }
                                        },
                                        style: TextStyles.textfieldTextStyle,
                                        decoration: TextFieldDecoration
                                            .textfieldDecoration(
                                          sufficIconOntap: () {},
                                          sufficIcon: null,
                                          hint: "",
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      );
                                    }),
                                    C20(),
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          if (_popupKey.currentState!
                                              .validate()) {
                                            Get.back();
                                            controller.viewReport();
                                          }
                                        },
                                        child: Container(
                                          width: 120,
                                          decoration: const BoxDecoration(
                                            color: AppColors.primaryOrange,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25)),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 8),
                                          alignment: Alignment.center,
                                          child: Obx(
                                            () => Text(
                                              controller.isLoading.value
                                                  ? "Loading..."
                                                  : "View",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Roboto-Regular"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    C10(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              right: 0,
                              top: -8,
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 25,
                                  color: AppColors.primaryOrange,
                                ),
                              ))
                        ],
                      ),
                    ));
              },
              icon: Icon(Icons.print)),
        )
      ]),
      bottomNavigationBar: const CustomBottomNavBar(),
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
                            const LabelsWithMark(label: "Applicant Name"),
                            TextFormField(
                              controller: controller.applicantName.value,
                              enabled: controller.isFormEdit.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => requiredValidator(value!),
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Applicant Name")
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
                            const LabelsWithMark(label: "Co-Borrower"),
                            TextFormField(
                              controller: controller.coBorrower.value,
                              enabled: controller.isFormEdit.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => requiredValidator(value!),
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Co-Borrower")
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
                            const LabelsWithMark(label: "Loan Product"),
                            TextFormField(
                              controller: controller.loanProduct.value,
                              enabled: controller.isFormEdit.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => requiredValidator(value!),
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Loan Product")
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
                            const LabelsWithMark(label: "Amount"),
                            TextFormField(
                              controller: controller.loanAmount.value,
                              enabled: controller.isFormEdit.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => requiredValidator(value!),
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Amount")
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
                            const LabelsWithMark(label: "Period"),
                            TextFormField(
                              controller: controller.periods.value,
                              enabled: controller.isFormEdit.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyles.textfieldTextStyle,
                              validator: (value) => requiredValidator(value!),
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                hint: "Period",
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
                            const LabelsWithMark(label: "Nominee"),
                            TextFormField(
                              controller: controller.nominee.value,
                              enabled: controller.isFormEdit.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => requiredValidator(value!),
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Nominee")
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
                            const LabelsWithMark(label: "Group"),
                            TextFormField(
                              controller: controller.group.value,
                              enabled: controller.isFormEdit.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => requiredValidator(value!),
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Loan Group")
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
                            const LabelsWithMark(label: "Relation"),
                            TextFormField(
                              controller: controller.relation.value,
                              enabled: controller.isFormEdit.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) => requiredValidator(value!),
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Relation")
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
                            LabelsWithMark(label: "Description"),
                            TextFormField(
                              controller: controller.description.value,
                              enabled: controller.isFormEdit.value,
                              cursorColor: AppColors.primary,
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.name,
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                          hint: "Description")
                                      .copyWith(
                                filled: true,
                                fillColor: controller.isFormEdit.value
                                    ? Colors.white
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ],
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
