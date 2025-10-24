import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/common_widgets/label_value_widget.dart';
import 'package:microfinance/utils/ui_helper_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';

class PDFViewWidget extends StatelessWidget {
  final File file;
  const PDFViewWidget({required this.file, super.key});

  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.file(file);
  }
}

Widget imagePickerField({
  required String label,
  Rx<File?>? imageFile,
  RxString? imageUrl,
  required RxBool isFocused,
  VoidCallback? onTap,
  bool isRequired = false,
  bool isEnabled = true,
  bool enableGeotag = false,
  Rx<Position?>? savedPosition,
  RxString? savedAddress,
}) {
  final ImagePicker picker = ImagePicker();
  Rx<Position?> filePosition = Rx<Position?>(null);
  RxString fileAddress = ''.obs;

  Future<Position?> getCurrentLocation() async {
    if (!enableGeotag) return null;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return null;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String?> getAddressFromPosition(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        return "${place.name}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      }
    } catch (e) {
      print("Error getting address: $e");
    }
    return null;
  }

  Future<File?> cropImage(String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppColors.primary,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
          ],
        ),
        IOSUiSettings(title: 'Crop Image'),
      ],
    );
    if (croppedFile != null) return File(croppedFile.path);
    return null;
  }

  Future<void> pickFile() async {
    if (!isEnabled) return;
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      imageFile?.value = file;

      if (enableGeotag) {
        Position? position = await getCurrentLocation();
        if (position != null) {
          filePosition.value = position;
          fileAddress.value = (await getAddressFromPosition(position)) ?? '';
          Get.snackbar(
            "Location Captured",
            "Lat: ${position.latitude}, Long: ${position.longitude}\nAddress: ${fileAddress.value}",
            snackPosition: SnackPosition.BOTTOM,
            //duration: const Duration(seconds: 3),
          );
        }
      }
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
      if (imageFile?.value != null)
        displayText = imageFile!.value!.path.split('/').last;
      else if (imageUrl?.value.isNotEmpty ?? false)
        displayText = imageUrl!.value.split('/').last;

      final fileExtension =
          imageFile?.value?.path.split('.').last.toLowerCase();

      return Focus(
        onFocusChange: (hasFocus) => isFocused.value = hasFocus,
        child: GestureDetector(
          onTap: isEnabled
              ? () async {
                  if (hasFile) {
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
                                height: 340,
                                child: (fileExtension == 'pdf')
                                    ? PDFViewWidget(file: imageFile!.value!)
                                    : imageFile?.value != null
                                        ? Image.file(imageFile!.value!,
                                            fit: BoxFit.contain)
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
                              if (enableGeotag && filePosition.value != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "Lat: ${filePosition.value!.latitude}, Long: ${filePosition.value!.longitude}\nAddress: ${fileAddress.value}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
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
                                title: Text(enableGeotag
                                    ? "Camera (Geotagged)"
                                    : "Camera"),
                                onTap: () async {
                                  Get.back();
                                  final cameraStatus =
                                      await Permission.camera.request();
                                  if (!cameraStatus.isGranted) {
                                    Get.snackbar("Permission Denied",
                                        "Camera permission is required");
                                    return;
                                  }
                                  final XFile? pickedFile =
                                      await picker.pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 80,
                                  );

                                  if (pickedFile != null) {
                                    File? cropped =
                                        await cropImage(pickedFile.path);
                                    if (cropped != null) {
                                      imageFile?.value = cropped;

                                      if (enableGeotag) {
                                        Future.delayed(Duration.zero, () async {
                                          try {
                                            Position? position =
                                                await getCurrentLocation();
                                            if (position != null) {
                                              String? address =
                                                  await getAddressFromPosition(
                                                      position);
                                              filePosition.value = position;
                                              fileAddress.value = address ?? '';
                                            }
                                          } catch (e) {
                                            print("Error fetching geotag: $e");
                                          }
                                        });
                                      }
                                    }
                                  }
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text("Gallery"),
                                onTap: () async {
                                  Get.back();
                                  Position? position;
                                  String? address;
                                  if (enableGeotag) {
                                    position = await getCurrentLocation();
                                    if (position != null) {
                                      address = await getAddressFromPosition(
                                          position);
                                      filePosition.value = position;
                                      fileAddress.value = address ?? '';
                                    }
                                  }

                                  final XFile? pickedFile =
                                      await picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 80,
                                  );
                                  if (pickedFile != null) {
                                    File? cropped =
                                        await cropImage(pickedFile.path);
                                    if (cropped != null) {
                                      imageFile?.value = cropped;
                                      if (enableGeotag && position != null) {
                                        Get.snackbar(
                                          "Location Captured",
                                          "Lat: ${position.latitude}, Long: ${position.longitude}\nAddress: ${address ?? ''}",
                                          snackPosition: SnackPosition.BOTTOM,
                                          duration: const Duration(seconds: 3),
                                        );
                                      }
                                    }
                                  }
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.picture_as_pdf),
                                title: const Text("Upload PDF"),
                                onTap: () async {
                                  await pickFile();
                                  Get.back();
                                  if (imageFile?.value != null &&
                                      fileExtension == 'pdf') {
                                    Get.dialog(
                                      Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                              width: 300,
                                              height: 340,
                                              child: PDFViewWidget(
                                                  file: imageFile!.value!)),
                                        ),
                                      ),
                                    );
                                  }
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
                            filePosition.value = null;
                            fileAddress.value = '';
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
