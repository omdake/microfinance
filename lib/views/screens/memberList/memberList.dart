import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/logic/controller/MemberList/memberListController.dart';
import 'package:microfinance/models/group_list.model.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper.dart/load_more_listview.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class MemberListScreen extends StatelessWidget {
  const MemberListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MemberListController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Member List"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              Obx(() {
                if (!controller.isGroup.value) return SizedBox.shrink();

                return SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField2<GroupListMessage>(
                    isExpanded: true,
                    decoration: TextFieldDecoration.textfieldDecoration(
                      sufficIconOntap: () {},
                      sufficIcon: null,
                      hint: '',
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 500,
                    ),
                    value: controller.selectedGroup.value.isEmpty
                        ? null
                        : controller.groupList.firstWhere(
                            (g) => g.name == controller.selectedGroup.value,
                            orElse: () => controller.groupList.first,
                          ),
                    items: controller.groupList.map((e) {
                      return DropdownMenuItem<GroupListMessage>(
                        value: e,
                        child: Text(
                          e.groupName ?? "",
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        controller.selectedGroup.value = newValue.name ?? "";
                        controller.page.value = 1;
                        controller.loanMemberList.clear();

                        controller.getLoanMemberList(
                            Status: controller.status.value);
                      }
                    },
                  ),
                );
              }),
              C25(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value &&
                      controller.loanMemberList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return LoadMoreListView(
                    loadData: () => controller.getloadData(),
                    loadMoreData: () => controller.getLoadMoreData(),
                    children: controller.loanMemberList.isNotEmpty
                        ? controller.loanMemberList.map((user) {
                            final index =
                                controller.loanMemberList.indexOf(user);
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              border: Border.all(
                                                  color: Colors.grey.shade800)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Center(
                                              child: Text(
                                                "${index + 1}",
                                                style: const TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user.memberName ?? "",
                                              style: const TextStyle(
                                                fontFamily: "Roboto-Medium",
                                                fontSize: 15,
                                                color: Color(0xFF33475B),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              user.memberId ?? "",
                                              style: const TextStyle(
                                                fontFamily: "Roboto-Regular",
                                                color: Color(0xFF667085),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () async {
                                          Get.toNamed(
                                            Routes.memberCreation,
                                            arguments: {'name': user.name},
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade800,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 8),
                                            child: const Center(
                                              child: Text(
                                                "Action",
                                                style: TextStyle(
                                                  fontFamily: "Roboto-Medium",
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(color: Colors.grey),
                              ],
                            );
                          }).toList()
                        : [],
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
