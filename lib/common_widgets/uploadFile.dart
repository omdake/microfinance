// ignore_for_file: unused_local_variable

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
  final RxBool? readOnlyFlag,
  bool enableGeotag = false,
  Rx<Position?>? savedPosition,
  RxString? savedAddress,
  RxBool? showError,
  Function(Position position, String address)? onGeotagCaptured,
  FormFieldValidator<File?>? validator,
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
}) {
  return FormField<File?>(
    initialValue: imageFile?.value,
    validator: validator,
    autovalidateMode: autovalidateMode,
    builder: (FormFieldState<File?> fieldState) {
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
          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);
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
          showError?.value = false;
          fieldState.didChange(file);

          if (enableGeotag) {
            Position? position = await getCurrentLocation();
            if (position != null) {
              filePosition.value = position;
              fileAddress.value =
                  (await getAddressFromPosition(position)) ?? '';
              Get.snackbar(
                "Location Captured",
                "Lat: ${position.latitude}, Long: ${position.longitude}\nAddress: ${fileAddress.value}",
                snackPosition: SnackPosition.BOTTOM,
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
          bool hasFile = (imageFile?.value != null) ||
              (imageUrl?.value.isNotEmpty ?? false);
          String displayText = "Attach";
          if (imageFile?.value != null)
            displayText = imageFile!.value!.path.split('/').last;
          else if (imageUrl?.value.isNotEmpty ?? false)
            displayText = imageUrl!.value.split('/').last;

          final fileExtension =
              imageFile?.value?.path.split('.').last.toLowerCase();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Focus(
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
                                            ? PDFViewWidget(
                                                file: imageFile!.value!)
                                            : imageFile?.value != null
                                                ? Image.file(imageFile!.value!,
                                                    fit: BoxFit.contain)
                                                : FutureBuilder<Uint8List?>(
                                                    future: fetchImageBytes(
                                                        imageUrl!.value),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      } else if (!snapshot
                                                              .hasData ||
                                                          snapshot.data ==
                                                              null) {
                                                        return const Center(
                                                            child: Text(
                                                                "Image not available"));
                                                      } else {
                                                        return Image.memory(
                                                            snapshot.data!,
                                                            fit:
                                                                BoxFit.contain);
                                                      }
                                                    },
                                                  ),
                                      ),
                                      if (enableGeotag &&
                                          filePosition.value != null)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            "Lat: ${filePosition.value!.latitude}, Long: ${filePosition.value!.longitude}\nAddress: ${fileAddress.value}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: "Roboto-regular"),
                                          ),
                                        ),
                                      C10(),
                                      ElevatedButton(
                                        onPressed: () => Get.back(),
                                        child: const Text(
                                          "Close",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Roboto-regular"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (!(readOnlyFlag?.value ?? false)) {
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
                                          try {
                                            final XFile? pickedFile =
                                                await picker.pickImage(
                                              source: ImageSource.camera,
                                              imageQuality: 80,
                                            );

                                            if (pickedFile != null) {
                                              File? cropped = await cropImage(
                                                  pickedFile.path);
                                              if (cropped != null) {
                                                imageFile?.value = cropped;
                                                showError?.value = false;
                                                fieldState.didChange(cropped);

                                                if (enableGeotag) {
                                                  Position? position =
                                                      await getCurrentLocation();
                                                  if (position != null) {
                                                    String? address =
                                                        await getAddressFromPosition(
                                                            position);
                                                    filePosition.value =
                                                        position;
                                                    fileAddress.value =
                                                        address ?? '';
                                                    onGeotagCaptured?.call(
                                                        position,
                                                        fileAddress.value);
                                                  }
                                                }
                                              }
                                            }
                                          } catch (e) {}
                                        },
                                      ),
                                      ListTile(
                                        leading:
                                            const Icon(Icons.photo_library),
                                        title: const Text("Gallery"),
                                        onTap: () async {
                                          Get.back();
                                          final XFile? pickedFile =
                                              await picker.pickImage(
                                            source: ImageSource.gallery,
                                            imageQuality: 80,
                                          );

                                          if (pickedFile != null) {
                                            File? cropped = await cropImage(
                                                pickedFile.path);
                                            if (cropped != null) {
                                              imageFile?.value = cropped;
                                              showError?.value = false;
                                              fieldState.didChange(cropped);

                                              if (enableGeotag) {
                                                Position? position =
                                                    await getCurrentLocation();
                                                if (position != null) {
                                                  String? address =
                                                      await getAddressFromPosition(
                                                          position);
                                                  filePosition.value = position;
                                                  fileAddress.value =
                                                      address ?? '';
                                                  onGeotagCaptured?.call(
                                                      position,
                                                      fileAddress.value);
                                                }
                                              }
                                            }
                                          }
                                        },
                                      ),
                                      ListTile(
                                        leading:
                                            const Icon(Icons.picture_as_pdf),
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
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: SizedBox(
                                                      width: 300,
                                                      height: 340,
                                                      child: PDFViewWidget(
                                                          file: imageFile!
                                                              .value!)),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: (readOnlyFlag?.value ?? false)
                          ? Colors.grey.shade200
                          : Colors.white,
                      border: Border.all(
                        color: fieldState.hasError || (showError?.value == true)
                            ? Colors.red
                            : (isFocused.value
                                ? Colors.grey
                                : Colors.grey.shade300),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.attach_file, color: Colors.grey),
                        C5(),
                        Expanded(
                          child: Text(
                            displayText,
                            style: TextStyles.textfieldTextStyle,
                          ),
                        ),
                        if (hasFile)
                          GestureDetector(
                            onTap: isEnabled && !(readOnlyFlag?.value ?? false)
                                ? () {
                                    if (imageFile != null)
                                      imageFile.value = null;
                                    if (imageUrl != null) imageUrl.value = '';

                                    fieldState.didChange(null);
                                    filePosition.value = null;
                                    fileAddress.value = '';
                                    showError?.value = true;
                                  }
                                : null,
                            child: Icon(
                              (readOnlyFlag?.value ?? false)
                                  ? Icons.visibility
                                  : Icons.delete,
                              color: (readOnlyFlag?.value ?? false)
                                  ? Colors.grey.shade600
                                  : Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (fieldState.hasError)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    fieldState.errorText!,
                    style: TextStyle(
                      color: AppColors.primaryRed,
                      fontSize: 12,
                    ),
                  ),
                )
              else if (showError?.value == true && !hasFile)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    "Please upload a file",
                    style: const TextStyle(
                      color: AppColors.primaryRed,
                      fontSize: 12,
                    ),
                  ),
                )
            ],
          );
        })
      ]);
    },
  );
}

class PDFViewWidget1 extends StatelessWidget {
  final File file;
  const PDFViewWidget1({required this.file, super.key});

  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.file(file);
  }
}

Widget imagePickerField1({
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
  RxBool? showError,
  final RxBool? readOnlyFlag,
  Function(Position position, String address)? onGeotagCaptured,
  FormFieldValidator<File?>? validator,
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
}) {
  return FormField<File?>(
    initialValue: imageFile?.value,
    validator: validator,
    autovalidateMode: autovalidateMode,
    builder: (FormFieldState<File?> fieldState) {
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
          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);
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
          showError?.value = false;
          fieldState.didChange(file);

          if (enableGeotag) {
            Position? position = await getCurrentLocation();
            if (position != null) {
              filePosition.value = position;
              fileAddress.value =
                  (await getAddressFromPosition(position)) ?? '';
              Get.snackbar(
                "Location Captured",
                "Lat: ${position.latitude}, Long: ${position.longitude}\nAddress: ${fileAddress.value}",
                snackPosition: SnackPosition.BOTTOM,
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
          bool hasFile = (imageFile?.value != null) ||
              (imageUrl?.value.isNotEmpty ?? false);
          String displayText = "Attach";
          if (imageFile?.value != null)
            displayText = imageFile!.value!.path.split('/').last;
          else if (imageUrl?.value.isNotEmpty ?? false)
            displayText = imageUrl!.value.split('/').last;

          final fileExtension =
              imageFile?.value?.path.split('.').last.toLowerCase();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Focus(
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
                                            ? PDFViewWidget1(
                                                file: imageFile!.value!)
                                            : imageFile?.value != null
                                                ? Image.file(imageFile!.value!,
                                                    fit: BoxFit.contain)
                                                : FutureBuilder<Uint8List?>(
                                                    future: fetchImageBytes(
                                                        imageUrl!.value),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      } else if (!snapshot
                                                              .hasData ||
                                                          snapshot.data ==
                                                              null) {
                                                        return const Center(
                                                            child: Text(
                                                                "Image not available"));
                                                      } else {
                                                        return Image.memory(
                                                            snapshot.data!,
                                                            fit:
                                                                BoxFit.contain);
                                                      }
                                                    },
                                                  ),
                                      ),
                                      if (enableGeotag &&
                                          filePosition.value != null)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            "Lat: ${filePosition.value!.latitude}, Long: ${filePosition.value!.longitude}\nAddress: ${fileAddress.value}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: "Roboto-regular"),
                                          ),
                                        ),
                                      C10(),
                                      ElevatedButton(
                                        onPressed: () => Get.back(),
                                        child: const Text(
                                          "Close",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Roboto-regular"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if ((!(readOnlyFlag?.value ?? false))) {
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
                                          try {
                                            final XFile? pickedFile =
                                                await picker.pickImage(
                                              source: ImageSource.camera,
                                              imageQuality: 80,
                                            );

                                            if (pickedFile != null) {
                                              File? cropped = await cropImage(
                                                  pickedFile.path);
                                              if (cropped != null) {
                                                imageFile?.value = cropped;
                                                showError?.value = false;
                                                fieldState.didChange(cropped);

                                                if (enableGeotag) {
                                                  Position? position =
                                                      await getCurrentLocation();
                                                  if (position != null) {
                                                    String? address =
                                                        await getAddressFromPosition(
                                                            position);
                                                    filePosition.value =
                                                        position;
                                                    fileAddress.value =
                                                        address ?? '';
                                                    onGeotagCaptured?.call(
                                                        position,
                                                        fileAddress.value);
                                                  }
                                                }
                                              }
                                            }
                                          } catch (e) {}
                                        },
                                      ),
                                      ListTile(
                                        leading:
                                            const Icon(Icons.photo_library),
                                        title: const Text("Gallery"),
                                        onTap: () async {
                                          Get.back();
                                          final XFile? pickedFile =
                                              await picker.pickImage(
                                            source: ImageSource.gallery,
                                            imageQuality: 80,
                                          );

                                          if (pickedFile != null) {
                                            File? cropped = await cropImage(
                                                pickedFile.path);
                                            if (cropped != null) {
                                              imageFile?.value = cropped;
                                              showError?.value = false;
                                              fieldState.didChange(cropped);

                                              if (enableGeotag) {
                                                Position? position =
                                                    await getCurrentLocation();
                                                if (position != null) {
                                                  String? address =
                                                      await getAddressFromPosition(
                                                          position);
                                                  filePosition.value = position;
                                                  fileAddress.value =
                                                      address ?? '';
                                                  onGeotagCaptured?.call(
                                                      position,
                                                      fileAddress.value);
                                                }
                                              }
                                            }
                                          }
                                        },
                                      ),
                                      ListTile(
                                        leading:
                                            const Icon(Icons.picture_as_pdf),
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
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Flexible(
                                                    fit: FlexFit.loose,
                                                    child: PDFViewWidget(
                                                        file:
                                                            imageFile!.value!),
                                                  ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: (readOnlyFlag?.value ?? false)
                          ? Colors.grey.shade200
                          : Colors.white,
                      border: Border.all(
                        color: fieldState.hasError || (showError?.value == true)
                            ? Colors.red
                            : (isFocused.value
                                ? Colors.grey
                                : Colors.grey.shade300),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        if (hasFile)
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1.5,
                              child: () {
                                final filePath = imageFile?.value?.path ??
                                    imageUrl?.value ??
                                    '';
                                final extension =
                                    filePath.split('.').last.toLowerCase();

                                if (extension == 'pdf') {
                                  return const Center(
                                    child: Icon(Icons.picture_as_pdf,
                                        size: 60, color: Colors.red),
                                  );
                                } else if (imageFile?.value != null) {
                                  return Image.file(imageFile!.value!,
                                      fit: BoxFit.contain);
                                } else if (imageUrl?.value.isNotEmpty ??
                                    false) {
                                  return Image.network(imageUrl!.value,
                                      fit: BoxFit.contain);
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }(),
                            ),
                          )
                        else
                          Expanded(
                            child: Text(
                              'Attach File',
                              style: TextStyles.textfieldTextStyle,
                            ),
                          ),
                        if (hasFile && !(readOnlyFlag?.value ?? false))
                          GestureDetector(
                            onTap: isEnabled && !(readOnlyFlag?.value ?? false)
                                ? () {
                                    if (imageFile != null)
                                      imageFile.value = null;
                                    if (imageUrl != null) imageUrl.value = '';

                                    fieldState.didChange(null);
                                    filePosition.value = null;
                                    fileAddress.value = '';
                                    showError?.value = true;
                                  }
                                : null,
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (fieldState.hasError)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    fieldState.errorText!,
                    style: TextStyle(
                      color: AppColors.primaryRed,
                      fontSize: 12,
                    ),
                  ),
                )
              else if (showError?.value == true && !hasFile)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Text(
                    "Please upload a file",
                    style: const TextStyle(
                      color: AppColors.primaryRed,
                      fontSize: 12,
                    ),
                  ),
                )
            ],
          );
        })
      ]);
    },
  );
}
