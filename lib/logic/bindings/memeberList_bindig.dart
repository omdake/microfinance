import 'package:get/get.dart';
import 'package:microfinance/logic/controller/MemberList/memberListController.dart';

class MemberListBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MemberListController());
  }
}
