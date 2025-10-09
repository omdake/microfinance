import 'package:get/get.dart';
import 'package:microfinance/logic/controller/loanSummary/loanSummaryController.dart';

class LoanSummaryBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoanSummaryController());
  }
}
