// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:microfinance/themes/app_colors.dart';
// import 'package:microfinance/utils/strings.dart';

// class AppSnackBar {
//   static const String defaultFontFamily = "Roboto-Medium";
//   static showSnackBarMassage({
//     required String title,
//     required String massage,
//     Color? backgroundColor,
//     Color? textColor,
//     IconData? icon,
//     Color? iconColor,
//     Duration? duration,
//     Duration? animationDuration,
//     bool? isDismissible,
//     SnackPosition? snackPosition,
//     DismissDirection? dismissDirection,
//     bool? showProgressIndicator,
//     SnackStyle? snackStyle,
//     String? fontFamily,
//   }) {
//     Get.snackbar(title, massage,
//         colorText: textColor ?? AppColors.white,
//         backgroundColor: backgroundColor ?? AppColors.primary,
//         icon: Icon(icon, color: iconColor ?? AppColors.white),
//         duration: duration ?? const Duration(seconds: 3),
//         animationDuration: animationDuration ?? Duration(seconds: 1),
//         snackPosition: snackPosition ?? SnackPosition.TOP,
//         dismissDirection: dismissDirection ?? DismissDirection.startToEnd,
//         isDismissible: isDismissible ?? true,
//         showProgressIndicator: showProgressIndicator ?? false,
//         snackStyle: snackStyle ?? SnackStyle.FLOATING);

//   }

//   static showSnackBarErrorMassage(
//       {String? title,
//       required String massage,
//       Duration? duration,
//       Duration? animationDuration,
//       bool? isDismissible,
//       SnackPosition? snackPosition,
//       DismissDirection? dismissDirection,
//       bool? showProgressIndicator,
//       SnackStyle? snackStyle}) {
//     Get.snackbar(title ?? Strings.error, massage,
//         colorText: AppColors.white,
//         backgroundColor: AppColors.error,
//         icon: Icon(Icons.error, color: AppColors.white),
//         duration: duration ?? const Duration(seconds: 4),
//         animationDuration: animationDuration ?? Duration(seconds: 1),
//         snackPosition: snackPosition ?? SnackPosition.TOP,
//         dismissDirection: dismissDirection ?? DismissDirection.startToEnd,
//         isDismissible: isDismissible ?? true,
//         showProgressIndicator: showProgressIndicator ?? false,
//         snackStyle: snackStyle ?? SnackStyle.FLOATING);
//   }

//   static showSnackBarWarningMassage(
//       {String? title,
//       required String massage,
//       Duration? duration,
//       Duration? animationDuration,
//       bool? isDismissible,
//       SnackPosition? snackPosition,
//       DismissDirection? dismissDirection,
//       bool? showProgressIndicator,
//       SnackStyle? snackStyle}) {
//     Get.snackbar(title ?? Strings.waring, massage,
//         colorText: AppColors.black,
//         backgroundColor: AppColors.Warning,
//         icon: Icon(Icons.warning, color: AppColors.black),
//         duration: duration ?? const Duration(seconds: 4),
//         animationDuration: animationDuration ?? Duration(seconds: 1),
//         snackPosition: snackPosition ?? SnackPosition.TOP,
//         dismissDirection: dismissDirection ?? DismissDirection.startToEnd,
//         isDismissible: isDismissible ?? true,
//         showProgressIndicator: showProgressIndicator ?? false,
//         snackStyle: snackStyle ?? SnackStyle.FLOATING);
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/utils/strings.dart';

class AppSnackBar {
  static const String defaultFontFamily =
      'Poppins'; // Change to your default font

  static showSnackBarMassage({
    required String title,
    required String massage,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Color? iconColor,
    Duration? duration,
    Duration? animationDuration,
    bool? isDismissible,
    SnackPosition? snackPosition,
    DismissDirection? dismissDirection,
    bool? showProgressIndicator,
    SnackStyle? snackStyle,
    String? fontFamily,
  }) {
    Get.snackbar(
      title,
      massage,
      backgroundColor: backgroundColor ?? AppColors.primary,
      duration: duration ?? const Duration(seconds: 3),
      animationDuration: animationDuration ?? const Duration(seconds: 1),
      snackPosition: snackPosition ?? SnackPosition.TOP,
      dismissDirection: dismissDirection ?? DismissDirection.startToEnd,
      isDismissible: isDismissible ?? true,
      showProgressIndicator: showProgressIndicator ?? false,
      snackStyle: snackStyle ?? SnackStyle.FLOATING,
      icon: Icon(icon, color: iconColor ?? AppColors.white),
      titleText: Text(
        title,
        style: TextStyle(
          color: textColor ?? AppColors.white,
          fontFamily: fontFamily ?? defaultFontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        massage,
        style: TextStyle(
          color: textColor ?? AppColors.white,
          fontFamily: fontFamily ?? defaultFontFamily,
        ),
      ),
    );
  }

  static showSnackBarErrorMassage({
    String? title,
    required String massage,
    Duration? duration,
    Duration? animationDuration,
    bool? isDismissible,
    SnackPosition? snackPosition,
    DismissDirection? dismissDirection,
    bool? showProgressIndicator,
    SnackStyle? snackStyle,
    String? fontFamily,
  }) {
    Get.snackbar(
      title ?? Strings.error,
      massage,
      backgroundColor: AppColors.error,
      duration: duration ?? const Duration(seconds: 4),
      animationDuration: animationDuration ?? const Duration(seconds: 1),
      snackPosition: snackPosition ?? SnackPosition.TOP,
      dismissDirection: dismissDirection ?? DismissDirection.startToEnd,
      isDismissible: isDismissible ?? true,
      showProgressIndicator: showProgressIndicator ?? false,
      snackStyle: snackStyle ?? SnackStyle.FLOATING,
      icon: const Icon(Icons.error, color: AppColors.white),
      titleText: Text(
        title ?? Strings.error,
        style: TextStyle(
          color: AppColors.white,
          fontFamily: fontFamily ?? defaultFontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        massage,
        style: TextStyle(
          color: AppColors.white,
          fontFamily: fontFamily ?? defaultFontFamily,
        ),
      ),
    );
  }

  static showSnackBarWarningMassage({
    String? title,
    required String massage,
    Duration? duration,
    Duration? animationDuration,
    bool? isDismissible,
    SnackPosition? snackPosition,
    DismissDirection? dismissDirection,
    bool? showProgressIndicator,
    SnackStyle? snackStyle,
    String? fontFamily,
  }) {
    Get.snackbar(
      title ?? Strings.waring,
      massage,
      backgroundColor: AppColors.Warning,
      duration: duration ?? const Duration(seconds: 4),
      animationDuration: animationDuration ?? const Duration(seconds: 1),
      snackPosition: snackPosition ?? SnackPosition.TOP,
      dismissDirection: dismissDirection ?? DismissDirection.startToEnd,
      isDismissible: isDismissible ?? true,
      showProgressIndicator: showProgressIndicator ?? false,
      snackStyle: snackStyle ?? SnackStyle.FLOATING,
      icon: const Icon(Icons.warning, color: AppColors.black),
      titleText: Text(
        title ?? Strings.waring,
        style: TextStyle(
          color: AppColors.black,
          fontFamily: fontFamily ?? defaultFontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        massage,
        style: TextStyle(
          color: AppColors.black,
          fontFamily: fontFamily ?? defaultFontFamily,
        ),
      ),
    );
  }
}
