import 'package:get/get.dart';
import 'package:microfinance/logic/controller/splashController.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
