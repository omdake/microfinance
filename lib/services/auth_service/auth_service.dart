import 'package:get/get.dart';
import 'package:microfinance/models/auth_user_data_model.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/routes/routes_string.dart';

final AuthService oauthService = AuthService();

class AuthService {
  AuthUserDataModel? authUserDataModel;

  AuthService() {
    authUserDataModel = AuthUserDataModel.empty();
  }

  Future<void> addAuthUserDetails(AuthUserDataModel data) async {
    authUserDataModel = data;
  }

  Future<void> handleExceptionLogout(String exception) async {
    if (exception == 'AuthenticationError') {
      authUserDataModel = AuthUserDataModel.empty();

      await AppPreferences.clearPreferences();

      Get.offAllNamed(Routes.loginScreen);
    }
  }
}
