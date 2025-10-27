import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/common_widgets/ui_helper_widgets.dart';
import 'package:microfinance/logic/controller/groupCreation/groupListController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/ui_helper.dart/load_more_listview.dart';

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GroupListController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(title: "Group List"),
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
              C20(),
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
                      return Column(
                        children: [
                          Container(
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
                                              text: "Group Name: ",
                                              style: TextStyle(
                                                fontFamily: "Roboto-Medium",
                                                fontSize: 15,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "${user.groupName ?? ""}",
                                              style: const TextStyle(
                                                fontFamily: "Roboto-Medium",
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Group Head Name: ",
                                                  style: TextStyle(
                                                    fontFamily: "Roboto-Medium",
                                                    fontSize: 15,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "${user.groupHeadMemberName ?? ""}",
                                                  style: const TextStyle(
                                                    fontFamily: "Roboto-Medium",
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              final token = await AppPreferences
                                                  .getToken();

                                              if (user.groupImage != null &&
                                                  user.groupImage!.isNotEmpty) {
                                                final imageUrl = user
                                                        .groupImage!
                                                        .startsWith('http')
                                                    ? user.groupImage!
                                                    : "${AppEnvironment.baseUrl}${user.groupImage!.startsWith('/') ? '' : '/'}${user.groupImage}";

                                                final isPdf = imageUrl
                                                    .toLowerCase()
                                                    .endsWith('.pdf');

                                                Get.dialog(
                                                  Dialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Colors.white,
                                                      ),
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      child: isPdf
                                                          ? PDFView(
                                                              filePath:
                                                                  imageUrl,
                                                            )
                                                          : SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    imageUrl,
                                                                httpHeaders: {
                                                                  'Authorization':
                                                                      token ??
                                                                          ''
                                                                },
                                                                fit: BoxFit
                                                                    .contain,
                                                                width: double
                                                                    .infinity,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    const Center(
                                                                  child: CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          2),
                                                                ),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Center(
                                                                  child: Icon(
                                                                      Icons
                                                                          .broken_image,
                                                                      size: 50,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                Get.snackbar(
                                                  "Info",
                                                  "No file available",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                );
                                              }
                                            },
                                            child: const Icon(
                                              Icons.visibility_outlined,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
          Get.toNamed(Routes.groupCreation);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        tooltip: "Add Payment Proof",
      ),
    );
  }
}
