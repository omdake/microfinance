import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/logic/controller/collectionInHand/collectionInHandListController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:intl/intl.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/ui_helper.dart/load_more_listview.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class CollectionInHandList extends StatelessWidget {
  const CollectionInHandList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CollectionInHandListController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Collection By Cash List"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: paddingWidget([
                      const LabelsWithMark(label: "Selected Date"),
                      Obx(() {
                        final hasDate =
                            controller.selectedDateText.value.isNotEmpty;

                        return TextFormField(
                          readOnly: true,
                          cursorColor: AppColors.primary,
                          controller: controller.selectedDateController.value,
                          onTap: () => controller.selectDate(context,
                              isSelectedDate: true),
                          style: TextStyles.textfieldTextStyle,
                          decoration: InputDecoration(
                            hintText: "Select Date",
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hasDate ? Icons.close : Icons.calendar_month,
                                color: Colors.grey.shade600,
                              ),
                              onPressed: () {
                                if (hasDate) {
                                  controller.clearSelectedDate();
                                } else {
                                  controller.selectDate(context,
                                      isSelectedDate: true);
                                }
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        );
                      }),
                    ]),
                  ),
                  C10(),
                  Expanded(
                    flex: 1,
                    child: paddingWidget(
                      [
                        const LabelsWithMark(label: "Status"),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller.Status.value,
                                style: TextStyles.textfieldTextStyle,
                                cursorColor: Colors.black,
                                onChanged: (value) {
                                  if (value.length >= 3 || value.isEmpty) {
                                    controller.onSearchChanged(value);
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter Status",
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontFamily: "Roboto-Regular",
                                    fontSize: 14,
                                  ),
                                  suffixIcon:  Icon(Icons.search,color: Colors.grey.shade600,),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              C25(),
              Expanded(
                child: Obx(() {
                  if (controller.collectionInHandList.isEmpty) {
                    return const Center(child: Text("No records found"));
                  }

                  return LoadMoreListView(
                    loadData: () => controller.getloadData(),
                    loadMoreData: () => controller.getLoadMoreData(),
                    children: controller.collectionInHandList.map((user) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              final args = {
                                "applicant": user,
                                "isReadOnly": true,
                              };
                              Get.toNamed(
                                Routes.collectionInhandView,
                                arguments: args,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Employee Id: ",
                                                style: TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "${user.employee ?? ""}",
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
                                                text: "Employee Name: ",
                                                style: TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "${user.employeeEmployeeName ?? ""}",
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
                                                text: "Date: ",
                                                style: TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              TextSpan(
                                                text: user.postingDate != null
                                                    ? DateFormat('yyyy-MM-dd')
                                                        .format(
                                                            user.postingDate!)
                                                    : "",
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
                                      color: (user.status == null ||
                                              user.status!.isEmpty)
                                          ? Colors.white
                                          : Colors.grey.shade600,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      user.status?.isNotEmpty == true
                                          ? user.status!
                                          : "",
                                      style: TextStyle(
                                        fontFamily: "Roboto-Medium",
                                        fontSize: 13,
                                        color: (user.status == null ||
                                                user.status!.isEmpty)
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Divider(color: Colors.grey),
                        ],
                      );
                    }).toList(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.createCollectionInHand);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        tooltip: "Add Payment Proof",
      ),
    );
  }
}
