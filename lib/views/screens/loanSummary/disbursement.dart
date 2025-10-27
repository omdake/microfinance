import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/logic/controller/loanSummary/loanSummaryController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class DisbursementScreen extends StatelessWidget {
  DisbursementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoanSummaryController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [

               Obx(() {
                return DropdownButtonFormField2<String>(
                  value: controller.selecteddisbursementGroup.value.isEmpty
                      ? null
                      : controller.selecteddisbursementGroup.value,
                  hint: Text(
                    "Select A Group Name",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: "Roboto-Regular",
                      fontSize: 12,
                    ),
                  ),
                  items: controller.groupList.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.name ?? "",
                      child: Text(
                        e.groupName ?? "",
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 500,
                  ),
                  isExpanded: true,
                  style: TextStyles.textfieldTextStyle,
                  decoration: TextFieldDecoration.textfieldDecoration(
                    sufficIconOntap: () {},
                    sufficIcon: null,
                    hint: '',
                  ),
                  onChanged: (newGroup) {
                    controller.selecteddisbursementGroup.value = newGroup!;
                    controller.loanDisbursementList.clear();
                    controller.getLoanDisbursementList();
                  },
                );
              }),
              C20(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }
                  if (controller.loanDisbursementList.isEmpty) {
                    return const Center(child: Text("No members found"));
                  }

                  return ListView.builder(
                    itemCount: controller.loanDisbursementList.length,
                    itemBuilder: (context, index) {
                      final user = controller.loanDisbursementList[index];

                      return Column(
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Get.toNamed(Routes.loanDetailsScreen,
                                  arguments: user);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Id: ",
                                                style: TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "${user.name ?? ""}",
                                                style: const TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Applicant: ",
                                                style: TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${user.applicantMemberName ?? "-"}",
                                                style: const TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade600,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    child: Text(
                                      user.status ?? "-",
                                      style: const TextStyle(
                                        fontFamily: "Roboto-Medium",
                                        fontSize: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(color: Colors.grey),
                        ],
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
