import 'package:get/get.dart';
import 'package:microfinance/logic/controller/resetPassword/resetPasswordController.dart';

class ResetPassowordBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ResetPasswordController());
  }
}
