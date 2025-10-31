import 'package:get/get.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/utils/app_constants.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(Duration(seconds: Constants.splashDelay), () {
      getScreen();
    });
    super.onInit();
  }

  Future<void> getScreen() async {
    final token = await AppPreferences.getToken() ?? "";
    if (token.isNotEmpty) {
      Get.offAllNamed(Routes.dashboardScreen);
    } else {
      Get.offAllNamed(Routes.loginScreen);
    }
  }
}
