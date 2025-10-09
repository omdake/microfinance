import 'package:microfinance/utils/ints.dart';

class AppURLs {
  static String get getCategories => "/categories/getCategories";

  static String get createDoctor => "/doctor/createDoctor";

  static String get getOtp => "/business/login/getOtp"; 

  static String get getCountry => "api/method/ex_loan_management.api.country.country_list?is_pagination=True"; 

   static String get getOccupation => "api/method/ex_loan_management.excel_loan_management.doctype.occupation.occupation.occupation_list?is_pagination=True"; 

  static String get getState => "api/method/ex_loan_management.excel_loan_management.doctype.state.state.state_list?is_pagination=True"; 

  static String get login => "api/method/ex_loan_management.api.login.login_and_get_token";

   static String get saveRepayments => "api/method/lending.loan_management.doctype.loan_repayment.loan_repayment.create_loan_repayment";

  static String get getmodeOfPayment => "api/method/ex_loan_management.api.country.mode_of_payment_list";

  static String  getLoanRepayments({required String loanGroup}) => "api/method/lending.loan_management.doctype.loan_repayment.loan_repayment.loan_repayment_list/?loan_group=$loanGroup";

  static String  LoanEmiList({String? selectedDate,String? searchText,String? sortBy,String?sortOrder,String? employee,String ?loanGroup,String? upToDate}) => "api/method/lending.loan_management.doctype.repayment_schedule.repayment_schedule.get_todays_emis?selected_date=$selectedDate&search_text=$searchText&sort_by=$sortBy&sort_order=$sortOrder&employee=$employee&loan_group=$loanGroup&upto_date=$upToDate";

  static String  submitLoanMember({required String name}) => "api/method/ex_loan_management.excel_loan_management.doctype.loan_member.loan_member.update_loan_member/?name=$name";

   static String get saveLoanCreationMember => "api/method/lending.loan_management.doctype.loan_application.loan_application.create_loan_application";

  static String get saveLoanMember => "api/method/ex_loan_management.excel_loan_management.doctype.loan_member.loan_member.create_loan_member";

  static String get loanMemberCount => "api/method/ex_loan_management.api.dashboard_api.get_loan_members";

  static String get totalLoanCount => "api/method/ex_loan_management.api.dashboard_api.get_loan_summary";

  static String get getLoanDisbursementList => "api/method/lending.loan_management.doctype.loan_disbursement.loan_disbursement.loan_disbursement_list/";

  static String get groupList => "api/method/ex_loan_management.excel_loan_management.doctype.loan_group.loan_group.loan_group_list/";

  static String   getLoanPaymentSchedule({required String loanId})=> "api/method/lending.loan_management.doctype.loan_repayment_schedule.loan_repayment_schedule.loan_payment_schedule_list/?loan=$loanId";

  static String  loanMemberList({ String? search, required String country, required String group,String? Status,bool? isGroup}) => "api/method/ex_loan_management.excel_loan_management.doctype.loan_member.loan_member.loan_member_list/?search=$search&group=$group&country=$country&status=$Status&is_group=$isGroup";

 static String  loanMember({required String name}) => "api/method/ex_loan_management.excel_loan_management.doctype.loan_member.loan_member.loan_member_get/?name=$name";

 static String get  updateLoanMember => "api/method/ex_loan_management.excel_loan_management.doctype.loan_member.loan_member.update_loan_member_api/";

static String get relation => "api/method/ex_loan_management.api.relation.get_relation_select_options";

static String get productList => "api/method/lending.loan_management.doctype.loan_product.loan_product.loan_product_list";

  static String get saveLogin => "/business/login/saveUsingOtp";

  static String get saveLoginWithPassword => "/business/login/save";

  static String get createDoctorInfo => "/doctor/createDoctorInfo";

  static String getDoctorInfoById({required int id}) =>
      "/doctor/getDoctorInfo/$id";

  static String get getDegrees => "/degrees/getDegrees";

  static String get getServices => "/services/getServices/";

  static String getAllPatientsByDoctorId(
          {required int id, required int page}) =>
      "/patient/patientsByDoctorId/$id?page=$page&limit=${IntValues.pageLimit}";
  static String getAllPatientsByDoctorIdTemp(
          {required int id, required int page}) =>
      "/patient/patientsByDoctorId/$id?page=$page&limit=50";

  static String get patientCreate => "/patient/create";

  static String patientById({required int id}) => "/patient/patientById/$id";

  static String searchPatientsByID({required int id, String? search}) =>
      "/patient/searchPatients/$id/$search";

  static String get appointmentCreate => "/appointment/create";

  static String appointmentByDoctor({required int id, required int page}) =>
      "/appointment/appointmentByDoctor/$id?page=$page&limit=${IntValues.pageLimit}";

  static String appointmentByDoctorAndPatient(
          {required int doctorId, required int patientId}) =>
      "/appointment/appointmentByDoctorAndPatient/$doctorId/$patientId";

  // ignore: non_constant_identifier_names
  static String SearchAppointmentPatientNameMobileNumber(
          {required int doctorId, String? name}) =>
      "/appointment/searchAppointments/$doctorId/$name";

  static String filterAppointments({required int doctorId}) =>
      "/appointment/filterAppointments/$doctorId/declined?";

  static String scheduleById({required int id}) => "/slots/schedule/$id";

  static String bookedSlots({required int id, required DateTime date}) =>
      "/slots/bookedSlots/$id/$date";

  static String getPayments({required int id}) => "/payment/getPayments/$id";

  static String appointmentUpdateStatus({required int id}) =>
      "/appointment/updateStatus";
}
