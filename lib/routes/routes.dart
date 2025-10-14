import 'package:microfinance/logic/bindings/dashboard_binding.dart';
import 'package:microfinance/logic/bindings/loanApplication_binding.dart';
import 'package:microfinance/logic/bindings/loan_details_binding.dart';
import 'package:microfinance/logic/bindings/loan_emi_binding.dart';
import 'package:microfinance/logic/bindings/loan_repayment_binding.dart';
import 'package:microfinance/logic/bindings/loan_summary_binding.dart';
import 'package:microfinance/logic/bindings/login_binding.dart';
import 'package:microfinance/logic/bindings/memberCreation_binding.dart';
import 'package:microfinance/logic/bindings/memeberList_bindig.dart';
import 'package:get/get.dart';
import 'package:microfinance/routes/routes_string.dart';
import 'package:microfinance/views/screens/LoanEMI/loanEMIScreen.dart';
import 'package:microfinance/views/screens/LoanRepayment/loanRepayment.dart';
import 'package:microfinance/views/screens/authentication/forgotPassword.dart';
import 'package:microfinance/views/screens/authentication/login.dart';
import 'package:microfinance/views/screens/authentication/resetPasswordScreen.dart';
import 'package:microfinance/views/screens/collectionInhand/collectionInHandList.dart';
import 'package:microfinance/views/screens/collectionInhand/collectionInHandScreen.dart';
import 'package:microfinance/views/screens/dashboard/dashboardScreen.dart';
import 'package:microfinance/views/screens/loanApplication/loanApplicationList.dart';
import 'package:microfinance/views/screens/loanApplication/loanApplicationScreen.dart';
import 'package:microfinance/views/screens/loanSummary/loanDetails.dart';
import 'package:microfinance/views/screens/loanSummary/loanSummaryScreen.dart';
import 'package:microfinance/views/screens/memberCreation/addressDetailsScreen.dart';
import 'package:microfinance/views/screens/memberCreation/memberCreation.dart';
import 'package:microfinance/views/screens/memberCreation/personalDetails.dart';
import 'package:microfinance/views/screens/memberList/memberList.dart';
import 'package:microfinance/views/screens/profile/ProfileScreen.dart';
import 'package:microfinance/views/screens/splash_screen.dart';

class AppRoutes {
  static const splash = Routes.splashScreen;
  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      //binding: SplashBindings(),
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      binding: LoginBindings(),
      page: () => LoginWithPassword(),
    ),
    GetPage(
      name: Routes.dashboardScreen,
      binding: DashboardBindings(),
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: Routes.memberList,
      binding: MemberListBindings(),
      page: () => MemberListScreen(),
    ),
    GetPage(
      name: Routes.memberCreation,
      binding: MemberCreationBindings(),
      page: () => MemberCreationScreen(),
    ),
    GetPage(
      name: Routes.personalDetails,
      page: () => PersonalDetailsScreen(),
    ),
    GetPage(
      name: Routes.addressScreen,
      page: () => AddressDetailsScreen(),
    ),
    GetPage(
      name: Routes.loanApplication,
      binding: LoanApplicationBindings(),
      page: () => LoanApplicationScreen(),
    ),
    GetPage(
      name: Routes.loanEMIScreen,
      binding: LoanEMIBindings(),
      page: () => LoanEMIScreen(),
    ),
    GetPage(
      name: Routes.loanRepayment,
      binding: LoanRepaymentBindings(),
      page: () => LoanRepaymentScreen(),
    ),
    GetPage(
      name: Routes.loanSummaryScreen,
      binding: LoanSummaryBindings(),
      page: () => LoanSummaryScreen(),
    ),
    GetPage(
      name: Routes.loanDetailsScreen,
      binding: LoanDetailsBindings(),
      page: () => LoanDetails(),
    ),
    GetPage(
      name: Routes.profile,
      //binding: LoanDetailsBindings(),
      page: () => ProfileScreen(),
    ),
     GetPage(
      name: Routes.loanApplicationList,
      //binding: LoanDetailsBindings(),
      page: () => LoanApplicationList(),
    ),
    GetPage(
      name: Routes.collectionInHandList,
      //binding: LoanDetailsBindings(),
      page: () => CollectionInHandList(),
    ),
    GetPage(
      name: Routes.createCollectionInHand,
      //binding: LoanDetailsBindings(),
      page: () => CollectionInHandScreen(),
    ),
    GetPage(
name: Routes.forgotPasswordScreen,
//binding: LoanDetailsBindings(),
page: () => ForgotPassword(),
),
GetPage(
name: Routes.resetPasswordScreen,
//binding: LoanDetailsBindings(),
page: () => ResetPasswordScreen(),
),
  ];
}
