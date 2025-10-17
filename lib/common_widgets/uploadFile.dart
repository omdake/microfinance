import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';

Widget imagePickerField({
  required String label,
  Rx<File?>? imageFile,
  RxString? imageUrl,
  required RxBool isFocused,
  VoidCallback? onTap,
  bool isRequired = false,
  bool isEnabled = true,
}) {
  final ImagePicker picker = ImagePicker();

  Future<void> pickFile() async {
    if (!isEnabled) return;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.single.path != null) {
      imageFile?.value = File(result.files.single.path!);
    }
  }

  Future<Uint8List?> fetchImageBytes(String url) async {
    try {
      final String? token = await AppPreferences.getToken();
      final bool isPrivate = url.contains('/private/files/');
      final headers = <String, String>{};
      if (isPrivate) headers['Authorization'] = '$token';

      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) return response.bodyBytes;
    } catch (e) {
      print("Error fetching image: $e");
    }
    return null;
  }

  return paddingWidget([
    LabelsWithMark(label: label, isRequired: isRequired),
    Obx(() {
      bool hasFile =
          (imageFile?.value != null) || (imageUrl?.value.isNotEmpty ?? false);

      String displayText = "Upload";
      if (imageFile?.value != null) {
        displayText = imageFile!.value!.path.split('/').last;
      } else if (imageUrl?.value.isNotEmpty ?? false) {
        displayText = imageUrl!.value.split('/').last;
      }

      final fileExtension =
          imageFile?.value?.path.split('.').last.toLowerCase();

      return Focus(
        onFocusChange: (hasFocus) => isFocused.value = hasFocus,
        child: GestureDetector(
          onTap: isEnabled
              ? () {
                  if (hasFile) {
                    // Show preview dialog
                    Get.dialog(
                      Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(label,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              C10(),
                              SizedBox(
                                width: 300,
                                height: 300,
                                child: (fileExtension == 'pdf')
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.picture_as_pdf,
                                                size: 80, color: Colors.red),
                                            Text(displayText),
                                          ],
                                        ),
                                      )
                                    : imageFile?.value != null
                                        ? Image.file(
                                            imageFile!.value!,
                                            fit: BoxFit.contain,
                                          )
                                        : FutureBuilder<Uint8List?>(
                                            future: fetchImageBytes(
                                                imageUrl!.value),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (!snapshot.hasData ||
                                                  snapshot.data == null) {
                                                return const Center(
                                                    child: Text(
                                                        "Image not available"));
                                              } else {
                                                return Image.memory(
                                                    snapshot.data!,
                                                    fit: BoxFit.contain);
                                              }
                                            },
                                          ),
                              ),
                              C10(),
                              ElevatedButton(
                                onPressed: () => Get.back(),
                                child: const Text(
                                  "Close",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    Get.bottomSheet(
                      SafeArea(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text("Camera"),
                                onTap: () async {
                                  final XFile? pickedFile =
                                      await picker.pickImage(
                                          source: ImageSource.camera,
                                          imageQuality: 80);
                                  if (pickedFile != null) {
                                    imageFile?.value = File(pickedFile.path);
                                  }
                                  Get.back();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text("Gallery"),
                                onTap: () async {
                                  final XFile? pickedFile =
                                      await picker.pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 80);
                                  if (pickedFile != null) {
                                    imageFile?.value = File(pickedFile.path);
                                  }
                                  Get.back();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.picture_as_pdf),
                                title: const Text("Upload PDF"),
                                onTap: () async {
                                  await pickFile();
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  }
                }
              : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: isFocused.value ? Colors.grey : Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.upload_file, color: Colors.grey),
                C5(),
                Expanded(
                  child: Text(
                    displayText,
                    style: TextStyles.textfieldTextStyle,
                  ),
                ),
                if (hasFile)
                  GestureDetector(
                    onTap: isEnabled
                        ? () {
                            if (imageFile != null) imageFile.value = null;
                            if (imageUrl != null) imageUrl.value = '';
                          }
                        : null,
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      );
    }),
  ]);
}
