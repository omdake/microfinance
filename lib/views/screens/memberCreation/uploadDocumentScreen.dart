import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/ui_helper_widgets.dart';
import 'package:microfinance/logic/controller/memberCreation/memberCreationController.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
import 'package:microfinance/views/screens/memberCreation/aaharPopupScreen.dart';
import 'package:microfinance/views/screens/memberCreation/addressDocScreen.dart';
import 'package:microfinance/views/screens/memberCreation/homePopupScreen.dart';
import 'package:microfinance/views/screens/memberCreation/memberCreationSuccess.dart';
import 'package:microfinance/views/screens/memberCreation/panCardPopupScreen.dart';
import 'package:microfinance/views/screens/memberCreation/voterCardPopupScreen.dart';

class UploadDcumentSreen extends StatelessWidget {
  UploadDcumentSreen({super.key});

  final MemberCreationController controller =
      Get.put(MemberCreationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => ListView(
                        children: [
                          documentTile(
                              icon: Icons.folder_open,
                              title: "Aadhar Card",
                              value: () =>
                                  controller.aadharNumber.value.text.isNotEmpty
                                      ? controller.aadharNumber.value.text
                                      : "Aadhar Card Details",
                              onTap: () {
                                Get.dialog(AadharPopup());
                              }),
                          documentTile(
                              icon: Icons.folder_open,
                              title: "PAN Card",
                              value: () =>
                                  controller.panNumber.value.text.isNotEmpty
                                      ? controller.panNumber.value.text
                                      : "Pan Card Details",
                              onTap: () {
                                Get.dialog(PanCardPopup());
                              }),
                          documentTile(
                              icon: Icons.folder_open,
                              title: "Voter ID",
                              value: () =>
                                  controller.voterId.value.text.isNotEmpty
                                      ? controller.voterId.value.text
                                      : "Voter Id Details",
                              onTap: () {
                                Get.dialog(VoterIdPopup());
                              }),
                          documentTile(
                              icon: Icons.folder_open,
                              title: "Address Document",
                              value: () => controller
                                      .selectedAddressDocType.value.isNotEmpty
                                  ? controller.selectedAddressDocType.value
                                  : "Address Document Details",
                              onTap: () {
                                Get.dialog(AddressDocPopup());
                              }),
                          documentTile(
                              icon: Icons.folder_open,
                              title: "Home Image",
                              value: () {
                                if (controller.homeImage.value != null) {
                                  return "Uploaded";
                                } else if (controller.loanMember.isNotEmpty &&
                                    controller.loanMember[0].homeImage !=
                                        null &&
                                    controller
                                        .loanMember[0].homeImage!.isNotEmpty) {
                                  return "Uploaded";
                                } else {
                                  return "Home Details";
                                }
                              },
                              onTap: () {
                                Get.dialog(HomePopup());
                              }),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.selectedIndex.value = 3;
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.primaryOrange,
                            shape: BoxShape.circle,
                          ),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () {
                          // Hide the button if read-only
                          if (controller.isReadOnly.value)
                            return SizedBox.shrink();

                          return InkWell(
                            onTap: () async {
                              if (controller
                                      .aadharNumber.value.text.isNotEmpty &&
                                  controller.panNumber.value.text.isNotEmpty &&
                                  controller.voterId.value.text.isNotEmpty &&
                                  controller.selectedAddressDocType.value
                                      .isNotEmpty &&
                                  (controller.homeImage.value != null ||
                                      controller.loanMember.first.homeImage
                                              ?.isNotEmpty ==
                                          true)) {
                                controller.isLoading.value = true;
                                await controller.updateLoanMember();
                                controller.isLoading.value = false;

                                showSubmitConfirmationDialog();
                              } else {
                                AppTostMassage.showTostMassage(
                                  massage: "Please fill all required fields",
                                );
                              }
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.primaryOrange,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Obx(() {
                return controller.isLoading.value
                    ? Container(
                        color: Colors.white.withOpacity(0.3),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryOrange,
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget documentTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required String Function() value,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF707070)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                color: Colors.black54,
              ),
            ),
            C15(),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title.toUpperCase(),
                        style: TextStyle(
                            color: Color(0xFF17243E),
                            fontSize: 12,
                            fontFamily: "Roboto-Medium")),
                    const SizedBox(height: 4),
                    Text(
                      value(),
                      style: TextStyle(
                        color: Color(0xFF17243E),
                        fontSize: 14,
                        fontFamily: "Roboto-Medium",
                      ),
                    ),
                  ]),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFC1CAC7),
            ),
          ],
        ),
      ),
    );
  }

  void showSubmitConfirmationDialog() {
    Get.dialog(
      AlertDialog(
        content: const Text("Are you sure you want to Submit?"),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            onPressed: () async {
              Get.back();
              controller.isLoading.value = true;
              controller.isLoading.value = false;
              if (controller.isReadOnly.value) {
                controller.selectedIndex.value = 1;
                return;
              }
              await controller.submitLoanMember(
                  memberName: controller.name.value);
              final appId = controller.memberId.value.text;
              final fullName = [
                controller.firstName.value.text,
                controller.middleName.value.text,
                controller.lastName.value.text,
              ].where((namePart) => namePart.trim().isNotEmpty).join(' ');

              final city = controller.city.value.text;
              final state = controller.selectedState.value;
              Get.offAll(() => MemberCreatedSuccessScreen(
                    applicationId: appId,
                    memberName: fullName,
                    city: city,
                    state: state,
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.black,
              foregroundColor: Colors.white,
            ),
            child: const Text("Yes"),
          ),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[100],
              foregroundColor: Colors.red[900],
            ),
            child: const Text("No"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
