import 'package:get/get.dart';
import 'package:microfinance/logic/controller/loanEMI/loanEMIController.dart';

class LoanEMIBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoanEMIController());
  }
}
