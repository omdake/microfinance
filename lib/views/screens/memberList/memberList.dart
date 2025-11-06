import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/logic/controller/MemberList/memberListController.dart';
import 'package:microfinance/models/group_list.model.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:microfinance/utils/ui_helper.dart/load_more_listview.dart';

class MemberListScreen extends StatelessWidget {
  MemberListScreen({super.key});

  Widget _buildMemberListItem(dynamic user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE6E6E6),
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0xFFD9D9D9),
                  child: Icon(Icons.person, color: Colors.white, size: 22),
                ),
              ),
            ),
            C10(),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.memberName ?? "",
                    style: const TextStyle(
                      fontFamily: "Roboto-Medium",
                      fontSize: 13,
                      color: Color(0xFF33475B),
                    ),
                  ),
                  Text(
                    user.memberId ?? "",
                    style: const TextStyle(
                      fontFamily: "Roboto-Regular",
                      color: Color(0xFF667085),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 1,
                  height: double.infinity,
                  color: const Color(0xFFE6E6E6),
                ),
              ),
            ),
            //C10(),
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () async {
                  Get.toNamed(
                    Routes.memberCreation,
                    arguments: {
                      'name': user.name,
                      'status': user.status,
                      'isReadOnly': user.status == "Pending",
                    },
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Action",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontFamily: "Roboto-Medium",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MemberListController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(
        title: controller.screenTitle.value.isNotEmpty
            ? controller.screenTitle.value
            : "Member List",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              Obx(() {
                if (controller.isGroup.value) {
                  return SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField2<GroupListMessage>(
                        isExpanded: true,
                        decoration: TextFieldDecoration.textfieldDecoration(
                          sufficIconOntap: () {},
                          sufficIcon: null,
                          hint: '',
                        ).copyWith(
                          contentPadding: EdgeInsets.zero,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 500,
                        ),
                        value: controller.selectedGroup.value.isEmpty
                            ? null
                            : controller.groupList.firstWhereOrNull(
                                (g) => g.name == controller.selectedGroup.value,
                              ),
                        items: [
                          const DropdownMenuItem<GroupListMessage>(
                            value: null,
                            child: Text("All Group"),
                          ),
                          ...controller.groupList.map((e) {
                            return DropdownMenuItem<GroupListMessage>(
                              value: e,
                              child: Text(
                                e.groupName ?? "",
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                        ],
                        dropdownSearchData: DropdownSearchData(
                          searchController:
                              controller.groupSearchController.value,
                          searchInnerWidgetHeight: 50,
                          searchInnerWidget: Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: TextStyles.textfieldTextStyle,
                              controller:
                                  controller.groupSearchController.value,
                              decoration:
                                  TextFieldDecoration.textfieldDecoration(
                                sufficIconOntap: () {},
                                sufficIcon: Icons.search,
                                hint: 'Search group...',
                              ),
                            ),
                          ),
                          searchMatchFn: (item, searchValue) {
                            if (searchValue.trim().length < 3) return true;
                            return (item.child is Text &&
                                (item.child as Text)
                                    .data!
                                    .toLowerCase()
                                    .contains(searchValue.toLowerCase()));
                          },
                        ),
                        onMenuStateChange: (isOpen) {
                          if (!isOpen)
                            controller.groupSearchController.value.clear();
                        },
                        onChanged: (newValue) {
                          controller.page.value = 1;

                          if (newValue == null) {
                            controller.selectedGroup.value = "";

                            controller.totalLoanMemberList(
                              Status: controller.status.value,
                              isGroup: controller.isGroup.value,
                            );
                          } else {
                            controller.selectedGroup.value =
                                newValue.name ?? "";

                            controller.totalLoanMemberList(
                                Status: controller.status.value,
                                isGroup: controller.isGroup.value,
                                group: controller.selectedGroup.value);
                          }
                        }),
                  );
                } else {
                  return TextField(
                    controller: controller.search.value,
                    style: TextStyles.textfieldTextStyle,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      if (value.length >= 3 || value.isEmpty) {
                        controller.onSearchChanged(value);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Search Members",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontFamily: "Roboto-Regular",
                        fontSize: 14,
                      ),
                      suffixIcon: const Icon(Icons.search),
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
                  );
                }
              }),
              C20(),
              Expanded(
                child: Obx(() {
                  if ((controller.search.value.text.length >= 3 ||
                          controller.search.value.text.isEmpty) &&
                      controller.loanMemberList.isEmpty &&
                      !controller.isLoading.value) {
                    return Center(
                      child: Text(
                        "No records found",
                        style: TextStyles.textfieldTextStyle,
                      ),
                    );
                  }

                  return LoadMoreListView(
                    loadData: () => controller.getloadData(),
                    loadMoreData: () => controller.getLoadMoreData(),
                    children: controller.loanMemberList.isNotEmpty
                        ? controller.loanMemberList.map((user) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {},
                              child: _buildMemberListItem(user),
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
