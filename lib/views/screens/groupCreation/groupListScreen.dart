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

  Widget loanCard({
    required GroupCreationResult user,
    required VoidCallback onTap,
    required String token,
  }) {
    return InkWell(
      onTap: onTap,
     splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE6E6E6)),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (user.groupImage != null && user.groupImage!.isNotEmpty) {
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
                    child: user.groupImage == null || user.groupImage!.isEmpty
                        ? const Icon(Icons.person,
                            color: Colors.white, size: 22)
                        : null,
                  ),
                ),
              ),
              C15(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Group Name: ",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF050708),
                              fontFamily: "Roboto-Regular",
                            ),
                          ),
                          TextSpan(
                            text: "${user.groupName ?? ""}",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF050708),
                              fontFamily: "Roboto-Regular",
                            ),
                          ),
                        ],
                      ),
                    ),
                    C2(),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Group Head Name: ",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF050708),
                              fontFamily: "Roboto-Regular",
                            ),
                          ),
                          TextSpan(
                            text: "${user.groupHeadMemberName ?? ""}",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF050708),
                              fontFamily: "Roboto-Regular",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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

                  return LoadMoreListView(
                    loadData: () => controller.getloadData(),
                    loadMoreData: () => controller.getLoadMoreData(),
                    children: controller.groupList.map((user) {
                      return loanCard(
                        user: user,
                        token: controller.token.value,
                        onTap: () {
                          
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
