import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/logic/controller/MemberList/memberListController.dart';
import 'package:microfinance/models/group_list.model.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
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

                return DropdownButtonFormField<GroupListMessage>(
                  value: controller.groupList.isNotEmpty
                      ? controller.groupList.first
                      : null,
                  items: controller.groupList.map((e) {
                    return DropdownMenuItem<GroupListMessage>(
                      value: e,
                      child: Text(e.name ?? ""),
                    );
                  }).toList(),
                  decoration: TextFieldDecoration.textfieldDecoration(
                    sufficIconOntap: () {},
                    sufficIcon: null,
                    hint: '',
                  ),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      controller.selectedGroup.value = newValue.name!;
                      controller.getLoanMemberList();
                    }
                  },
                );
              }),
              C25(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  }
                  if (controller.loanMemberList.isEmpty) {
                    return const Center(child: Text("No members found"));
                  }
                  return ListView.builder(
                    itemCount: controller.loanMemberList.length,
                    itemBuilder: (context, index) {
                      final user = controller.loanMemberList[index];

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
                                      color: Colors.grey.shade800,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: const TextStyle(
                                            fontFamily: "Roboto-Medium",
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                C15(),
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
                                      C5(),
                                      Text(
                                        user.memberId ?? "",
                                        style: const TextStyle(
                                            fontFamily: "Roboto-Regular",
                                            color: Color(0xFF667085),
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                C10(),
                                GestureDetector(
                                  onTap: () async {
                                    Get.toNamed(
                                      Routes.memberCreation,
                                      arguments: {'name': user.name},
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade500,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      child: Center(
                                        child: Text(
                                          "Action",
                                          style: const TextStyle(
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
