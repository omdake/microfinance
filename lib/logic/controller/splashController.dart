// import 'package:microfinance/AppPreferences/app_areferences.dart';
// import 'package:microfinance/api/app_api.dart';
// import 'package:microfinance/models/auth_user_data_model.dart';
// import 'package:microfinance/routes/routes_string.dart';
// import 'package:microfinance/services/app_setting_services.dart';
// import 'package:microfinance/services/auth_service/auth_service.dart';
// import 'package:microfinance/utils/app_constants.dart';
// import 'package:microfinance/utils/extension/extension/map_extensions.dart';
// import 'package:microfinance/utils/keys/api_keys.dart';
// import 'package:get/get.dart';

// class SplashController extends GetxController {
//   @override
//   void onInit() {
//     Future.delayed(Duration(seconds: Constants.splashDelay), () {
//       getScreen();
//     });
//     super.onInit();
//   }

//   // getUserData(String emailId) async {
//   //   Map<String, dynamic> postData = Map();
//   //   postData.add(key: APIKeys.EmailId, value: emailId);
//   //   Map<String, dynamic> responseData =
//   //       await AppAPIs.post("api/signup/UserDetails", data: postData);
//   //   if (responseData.getBool('success')) {
//   //     oauthService.addAuthUserDetails(
//   //         AuthUserDataModel.fromJson(responseData.getList("response").first));
//   //   }
//   // }

//   Future<void> getScreen() async {
//     await AppSettingsManager().callAppSettingData();

//     String? ClientID = await AppPreferences.getClientID();
//     String? emailId = await AppPreferences.getEmailId();
//     String? userName = await AppPreferences.getName();

//     if (ClientID != null || userName != "") {
//       // orderService.getProductToCart(1);
//       //getUserData(emailId!);
//       Get.offAndToNamed(Routes.homeScreen);
//     } else {
//       Get.offAndToNamed(Routes.loginScreen);
//     }
//   }
// }
