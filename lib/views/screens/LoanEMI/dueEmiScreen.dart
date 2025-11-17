import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/logic/controller/dashboard/homeController.dart';
import 'package:microfinance/logic/controller/loanEMI/dueEmiController.dart';
import 'package:microfinance/models/loan_emi.model.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/text_field_decoration.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

class DueEMIScreen extends StatelessWidget {
  const DueEMIScreen({super.key});

  Widget loanCard({
    required LoanEmiListMessage user,
    required VoidCallback onTap,
    required String token,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
                  if (user.memberImage != null &&
                      user.memberImage!.isNotEmpty) {
                    final imageUrl = user.memberImage!.startsWith('http')
                        ? user.memberImage!
                        : "${AppEnvironment.baseUrl}${user.memberImage!.startsWith('/') ? '' : '/'}${user.memberImage}";
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
                        user.memberImage != null && user.memberImage!.isNotEmpty
                            ? CachedNetworkImageProvider(
                                user.memberImage!.startsWith('http')
                                    ? user.memberImage!
                                    : "${AppEnvironment.baseUrl}${user.memberImage!.startsWith('/') ? '' : '/'}${user.memberImage}",
                                headers: {'Authorization': token},
                              )
                            : null,
                    child: user.memberImage == null || user.memberImage!.isEmpty
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
                    Text(
                      "Member Name: ${user.memberName ?? ""}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF050708),
                        fontFamily: "Roboto-Regular",
                      ),
                    ),
                    Text(
                      "Loan ID: ${user.loanId ?? ""}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF050708),
                        fontFamily: "Roboto-Regular",
                      ),
                    ),
                    Text(
                      "Total Amt: ${user.totalPayment?.toStringAsFixed(2) ?? "0.00"}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF050708),
                        fontFamily: "Roboto-Regular",
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 1,
                  height: double.infinity,
                  color: const Color(0xFFE6E6E6),
                ),
              ),
              C15(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final args = {
                        'fromEMI': true,
                        'loanId': user.loanId ?? "",
                        'loan': user.loan ?? "",
                        'totalPayment':
                            user.totalPayment?.toStringAsFixed(2) ?? "0.00",
                        'paymentDate': user.paymentDate,
                        'memberName': user.memberName,
                        'applicant': user.applicant,
                      };
                      Get.toNamed(
                        Routes.loanRepayment,
                        arguments: args,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryOrange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Center(
                          child: Text(
                            "Pay",
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
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DueEMIController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: Text("Pending EMI List", style: TextStyles.appbartitle),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            final homeController = Get.find<HomeController>();
            homeController.changeIndex(0);
            controller.resetSelectedDate();
          },
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LabelsWithMark(label: "Search"),
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
                            hintText: "Search Members",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontFamily: "Roboto-Regular",
                              fontSize: 12,
                            ),
                            suffixIcon: const Icon(Icons.search),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade500,
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
                      ],
                    ),
                  ),
                  C20(),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LabelsWithMark(label: "Up To Date"),
                        Obx(
                          () => TextFormField(
                              readOnly: true,
                              cursorColor: AppColors.primary,
                              onTap: () => controller.selectDate(context,
                                  isSelectedDate: false),
                              style: TextStyles.textfieldTextStyle,
                              decoration:
                                  TextFieldDecoration.textfieldDecorationicon(
                                hint: "Select Date",
                                sufficIcon: Icons.calendar_today,
                                sufficIconOntap: () => controller
                                    .selectDate(context, isSelectedDate: false),
                              ),
                              controller: controller.dateController.value),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              C15(),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  }
                  if (controller.loanEMIList.isEmpty) {
                    return const Center(child: Text("No members found"));
                  }

                  return ListView.builder(
                    itemCount: controller.loanEMIList.length,
                    itemBuilder: (context, index) {
                      final user = controller.loanEMIList[index];
                      return loanCard(
                        user: user,
                        token: controller.token.value,
                        onTap: () {},
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
