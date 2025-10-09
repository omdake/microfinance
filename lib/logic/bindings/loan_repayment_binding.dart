import 'package:get/get.dart';
import 'package:microfinance/logic/controller/loanRepayment/loanRepaymentController.dart';

class LoanRepaymentBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoanRepaymentController());
  }
}
