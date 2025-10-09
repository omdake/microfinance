import 'package:microfinance/logic/controller/authentication/loginController.dart';
import 'package:get/get.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
   }
}