import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/common_widgets/ui_helper_widgets.dart';
import 'package:microfinance/logic/controller/profile/profileScreenController.dart';
import 'package:microfinance/themes/app_colors.dart';

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
      appBar: appBarWithTitle(title: "Personal Details"),
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
                        widthFactor: 0.4,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey, width: 2),
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
                                        const Icon(Icons.person, size: 40),
                                  ),
                                );
                              } else {
                                return const Icon(Icons.person, size: 40);
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
                              color: AppColors.grey,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 35),
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
                      color: Color(0xFF33475B),
                      fontSize: 16,
                      fontFamily: "Roboto-Bold"),
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
              ),
            ]),
            const C30(),
          ],
        );
      }),
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
