import 'package:get/get.dart';
import 'package:microfinance/logic/controller/loanApplication/loanApplicationController.dart';

class LoanApplicationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoanApplicationController());
  }
}
