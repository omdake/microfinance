import 'package:get/get.dart';
import 'package:microfinance/logic/controller/memberCreation/memberCreationController.dart';

class MemberCreationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MemberCreationController());
  }
}
