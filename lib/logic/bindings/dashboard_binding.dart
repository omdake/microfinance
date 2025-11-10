import 'package:get/get.dart';
import 'package:microfinance/logic/controller/dashboard/dasboardController.dart';
import 'package:microfinance/logic/controller/dashboard/homeController.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
  }
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
  }
}
