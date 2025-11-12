import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/common_widgets/nav_bar.dart';
import 'package:microfinance/logic/controller/groupCreation/groupListController.dart';
import 'package:microfinance/models/groupCreation.model.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/ui_helper.dart/load_more_listview.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({super.key});
  String _getInitials(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "?";
    }
    final parts = name.trim().split(" ");
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
    }
  }

  Color statusColor(String? status) {
    switch (status?.toLowerCase()) {
      case "approved":
        return const Color(0xFFAE282E);
      case "pending":
        return const Color(0xFFF06321);
      default:
        return Colors.grey;
    }
  }

  Widget loanCard({
    required GroupCreationResult user,
    required VoidCallback onTap,
    required String token,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE6E6E6)),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    if (user.groupImage != null &&
                        user.groupImage!.isNotEmpty) {
                      final imageUrl = user.groupImage!.startsWith('http')
                          ? user.groupImage!
                          : "${AppEnvironment.baseUrl}${user.groupImage!.startsWith('/') ? '' : '/'}${user.groupImage}";
                      final isPdf = imageUrl.toLowerCase().endsWith('.pdf');

                      Get.dialog(
                        Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: isPdf
                                ? PDFView(filePath: imageUrl)
                                : CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    httpHeaders: {'Authorization': token},
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                    placeholder: (_, __) => const Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    ),
                                    errorWidget: (_, __, ___) => const Center(
                                      child: Icon(Icons.broken_image,
                                          size: 50, color: Colors.grey),
                                    ),
                                  ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE6E6E6),
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xFFD9D9D9),
                      backgroundImage:
                          user.groupImage != null && user.groupImage!.isNotEmpty
                              ? CachedNetworkImageProvider(
                                  user.groupImage!.startsWith('http')
                                      ? user.groupImage!
                                      : "${AppEnvironment.baseUrl}${user.groupImage!.startsWith('/') ? '' : '/'}${user.groupImage}",
                                  headers: {'Authorization': token},
                                )
                              : null,
                      child:
                          (user.groupImage == null || user.groupImage!.isEmpty)
                              ? Text(
                                  _getInitials(user.groupName),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                    ),
                  ),
                ),
              ),
              C15(),
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Group Name:${user.groupName ?? "-"}",
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF050708),
                        fontFamily: "Roboto-Medium",
                      ),
                    ),
                    C2(),
                    Text(
                      "Group Head Name: ${user.groupHeadMemberName ?? "-"}",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF050708),
                        fontFamily: "Roboto-Regular",
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
              C15(),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (user.workflowState != null &&
                        user.workflowState!.toLowerCase() != "open")
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: statusColor(user.workflowState),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          user.workflowState!.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontFamily: "Roboto-Medium",
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GroupListController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: Text("Group List", style: TextStyles.appbartitle),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(Routes.homeScreen),
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
            ),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.arrow_back, color: Colors.black, size: 20),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.groupCreation),
        elevation: 0,
        backgroundColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightElevation: 0,
        tooltip: "Add Group",
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryOrange,
            border: Border.all(
              color: AppColors.primaryOrange,
              width: 2,
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: const Icon(Icons.add, color: AppColors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              TextField(
                controller: controller.search.value,
                style: TextStyles.textfieldTextStyle,
                cursorColor: Colors.black,
                onChanged: (value) {
                  if (value.length >= 3 || value.isEmpty) {
                    controller.onSearchChanged(value);
                  }
                },
                decoration: InputDecoration(
                  hintText: "Search Group",
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
              ),
              C25(),
              Expanded(
                child: Obx(() {
                  if (controller.search.value.text.length >= 3 &&
                      controller.groupList.isEmpty) {
                    return Center(
                      child: Text(
                        "No records found",
                        style: TextStyles.textfieldTextStyle,
                      ),
                    );
                  }

                  return LoadMoreListView1(
                    isLoading: controller.isLoading.value,
                    loadData: () => controller.getloadData(),
                    loadMoreData: () => controller.getLoadMoreData(),
                    children: controller.groupList.map((user) {
                      return loanCard(
                        user: user,
                        token: controller.token.value,
                        onTap: () {
                          final args = {
                            "name": user.name,
                            "groupHead": user.groupHead,
                            "groupName": user.groupName,
                            "groupImage": user.groupImage,
                            "status": user.workflowState
                          };

                          Get.toNamed(
                            Routes.groupCreation,
                            arguments: args,
                          );
                        },
                      );
                    }).toList(),
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
