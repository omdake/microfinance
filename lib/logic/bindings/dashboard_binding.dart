import 'package:get/get.dart';
import 'package:microfinance/logic/controller/dashboard/dasboardController.dart';

class DashboardBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(DashboardController());
   }
}