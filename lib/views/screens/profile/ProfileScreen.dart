import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/common_widgets/ui_helper_widgets.dart';
import 'package:microfinance/logic/controller/dashboard/homeController.dart';
import 'package:microfinance/logic/controller/profile/profileScreenController.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileScreenController controller = Get.put(ProfileScreenController());

  String getValue(String? value, String defaultValue) {
    if (value == null || value.isEmpty || value == "null") return defaultValue;
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyles.appbartitle,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            final homeController = Get.find<HomeController>();
            homeController.changeIndex(0);
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: () {
                  moreMenu(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryOrange),
                      color: AppColors.primaryOrange),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                )),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: [
            const C20(),
            Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.3,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.primaryOrange, width: 2),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Obx(() {
                              final imageFile = controller.memberImage.value;
                              final imageUrl = controller.memberImageUrl.value;
                              final token = controller.token.value;

                              if (imageFile != null) {
                                return CircleAvatar(
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage: FileImage(imageFile),
                                );
                              } else if (imageUrl.isNotEmpty) {
                                return ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    httpHeaders: {'Authorization': token},
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.person, size: 30),
                                  ),
                                );
                              } else {
                                return const Icon(Icons.person, size: 30);
                              }
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Obx(
                      () {
                        final statusText =
                            getValue(controller.status.value.text, "N/A");
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.primaryRed,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 45),
                            child: Text(
                              statusText,
                              style: const TextStyle(
                                fontFamily: "Roboto-Regular",
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            C10(),
            Center(
              child: Obx(
                () => Text(
                  getValue(controller.empName.value.text, 'NA'),
                  style: const TextStyle(
                      color: Color(0xFF050708),
                      fontSize: 16,
                      fontFamily: "Roboto-Bold"),
                ),
              ),
            ),
            Center(
              child: Obx(
                () => Text(
                  getValue(controller.email.value.text, 'NA'),
                  style: const TextStyle(
                      color: Color(0xFF33475B),
                      fontSize: 16,
                      fontFamily: "Roboto-Regular"),
                ),
              ),
            ),
            C10(),
            _buildInfoContainer([
              DetailTile(
                icon: Icons.person,
                title: 'DEPARTMENT',
                subtitle: getValue(controller.department.value.text, "NA"),
              ),
              DetailTile(
                icon: Icons.flag,
                title: 'POSITION',
                subtitle: getValue(controller.designation.value.text, 'NA'),
                isShow: true,
              ),
            ]),
            _buildInfoContainer([
              DetailTile(
                icon: Icons.cake,
                title: 'Birth Date',
                subtitle: getValue(controller.dob.value.text, 'NA'),
              ),
              DetailTile(
                icon: Icons.person,
                title: 'Gender',
                subtitle: getValue(controller.gender.value.text, 'NA'),
              ),
              DetailTile(
                icon: Icons.people,
                title: 'Marital Status',
                subtitle: getValue(controller.maritalStatus.value.text, 'NA'),
              ),
              DetailTile(
                icon: Icons.email,
                title: 'Primary Email',
                subtitle: getValue(controller.email.value.text, 'NA'),
              ),
              DetailTile(
                icon: Icons.phone,
                title: 'Personal Contact No',
                subtitle: '+91 9876543210',
              ),
              DetailTile(
                icon: Icons.bloodtype,
                title: 'Blood Group',
                subtitle: getValue(controller.bloodGroup.value.text, "NA"),
                isShow: true,
              ),
            ]),
            _buildInfoContainer([
              DetailTile(
                icon: Icons.calendar_today,
                title: 'Join Date',
                subtitle: getValue(controller.dojoining.value.text, 'NA'),
                isShow: true,
              ),
            ]),
          ],
        );
      }),
    );
  }

  void moreMenu(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    child: Column(
                      children: [
                        optionTile(
                          "Reset Password",
                          () => Get.toNamed(Routes.resetPassword),
                        ),
                        Divider(
                          color: Colors.grey.shade200,
                          indent: 10,
                          endIndent: 10,
                        ),
                        optionTile("Logout", () async {
                          showLogoutConfirmation(context);
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          color: AppColors.white,
                          size: 60,
                        ))),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget optionTile(String label, VoidCallback onTap) {
    return ListTile(
      title: Center(
          child: Text(
        label,
        style: TextStyles.cardtitle,
      )),
      onTap: onTap,
    );
  }

  void showLogoutConfirmation(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Are you sure you want to logout?",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Roboto-Medium",
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        C20(),
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await AppPreferences.clearPreferences();
                                  Get.offAllNamed(Routes.loginScreen);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: const Text(
                                  "YES",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Roboto-Medium",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => Get.back(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryOrange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: const Text(
                                  "NO",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Roboto-Medium",
                                    color: Colors.white,
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
                C20(),
                // Align(
                //   alignment: Alignment.center,
                //   child: InkWell(
                //     onTap: () {
                //       Get.back();
                //     },
                //     child: Icon(
                //       Icons.cancel_outlined,
                //       color: AppColors.white,
                //       size: 60,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoContainer(List<DetailTile> tiles) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF33475B), width: 0.25)),
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(children: tiles),
    );
  }
}

class DetailTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isShow;

  const DetailTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isShow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title.toUpperCase(),
                style: const TextStyle(
                    fontFamily: "Roboto-Regular",
                    fontSize: 12,
                    color: Color(0xFF5D6675)),
              ),
            ),
            Expanded(
              child: Text(
                subtitle,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    color: Color(0xFF23272C),
                    fontFamily: "Roboto-Medium",
                    fontSize: 12),
              ),
            )
          ],
        ),
        if (!isShow) const Divider(color: Color(0xFFE0E4EA))
      ],
    );
  }
}
