import 'dart:convert';
import 'dart:io';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide State;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/api_status_code.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/models/loan_memeber_list.model.dart';
import 'package:microfinance/models/occupation_list.model.dart';
import 'package:microfinance/models/state_list.model.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class MemberCreationController extends GetxController {
  Rx<TextEditingController> dob = TextEditingController().obs;
  Rx<TextEditingController> memeberId = TextEditingController().obs;
  Rx<TextEditingController> firstName = TextEditingController().obs;
  Rx<TextEditingController> middleName = TextEditingController().obs;
  Rx<TextEditingController> lastName = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> entryAge = TextEditingController().obs;
  Rx<TextEditingController> completedAge = TextEditingController().obs;
  Rx<TextEditingController> mobileNo = TextEditingController().obs;
  Rx<TextEditingController> occupation = TextEditingController().obs;
  Rx<TextEditingController> membergender = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> city = TextEditingController().obs;
  Rx<TextEditingController> pincode = TextEditingController().obs;
  Rx<TextEditingController> bankName = TextEditingController().obs;
  Rx<TextEditingController> accountNumber = TextEditingController().obs;
  Rx<TextEditingController> holderName = TextEditingController().obs;
  Rx<TextEditingController> branch = TextEditingController().obs;
  Rx<TextEditingController> ifscCode = TextEditingController().obs;
  Rx<TextEditingController> bankAddress = TextEditingController().obs;
  Rx<TextEditingController> aadharNumber = TextEditingController().obs;
  Rx<TextEditingController> panNumber = TextEditingController().obs;
  Rx<TextEditingController> voterId = TextEditingController().obs;
  Rx<TextEditingController> cibilScore = TextEditingController().obs;
  Rx<TextEditingController> cibilDate = TextEditingController().obs;
  Rx<TextEditingController> addressDocType = TextEditingController().obs;
  Rx<TextEditingController> country = TextEditingController(text: "India").obs;
  Rx<File?> aadharImage = Rx<File?>(null);
  Rx<File?> homeImage = Rx<File?>(null);
  Rx<File?> panImage = Rx<File?>(null);
  Rx<File?> voterImage = Rx<File?>(null);
  Rx<File?> memberImage = Rx<File?>(null);
  Rx<File?> addressImage = Rx<File?>(null);
  Rx<File?> addressProofImage = Rx<File?>(null);
  RxBool isvoterImageFocused = false.obs;
  RxBool ishomeImageFocused = false.obs;
  RxBool isAadharImageFocused = false.obs;
  RxBool isPanImageFocused = false.obs;
  RxBool isLoading = false.obs;
  RxBool isAddressImageFocused = false.obs;
  RxBool isMemberImageFocused = false.obs;
   RxBool isAddressProofImageFocused = false.obs;
  RxString selectedOccupation = ''.obs;
  RxString selectedCountry = "".obs;
  RxString selectedState = "".obs;
  RxString name = "".obs;
  Rx<StateResult?> selectedstateObj = Rx<StateResult?>(null);
  RxList<OccupationResult> occupationList = <OccupationResult>[].obs;
  RxList<LoanMemberListMessage> loanMember = <LoanMemberListMessage>[].obs;
  RxList<StateResult> stateList = <StateResult>[].obs;
  RxInt selectedIndex = 0.obs;
  final ScrollController scrollController = ScrollController();
  final List<GlobalKey> itemKeys = [];
  final List<String> genderList = ["Male", "Female", "Other"];
  RxString selectedGender = ''.obs;
  final List<String> addressDocTypeList = [
    "Electricity Bill",
    "Rent Agreement"
  ];
  RxString selectedAddressDocType = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await getOccupationList();
    await getStateList();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['name'] != null) {
      name.value = args['name'].toString();
      await getLoanMember(memberName: name.value);
    }
  }

  void selectButton(
    int index,
  ) {
    selectedIndex.value = index;
    _scrollToIndex(index);
  }

  void _scrollToIndex(int index) {
    if (itemKeys.length > index) {
      final keyContext = itemKeys[index].currentContext;
      if (keyContext != null) {}
    }
  }

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    List<DateTime?>? picked = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        okButtonTextStyle: const TextStyle(color: Colors.black),
        cancelButtonTextStyle: const TextStyle(color: Colors.black),
        selectedDayHighlightColor: Colors.grey,
        dayTextStyle: const TextStyle(color: Colors.black),
      ),
      dialogSize: const Size(350, 400),
      borderRadius: BorderRadius.circular(15),
    );

    if (picked != null && picked.isNotEmpty && picked.first != null) {
      String formatted = DateFormat('yyyy-MM-dd').format(picked.first!);
      controller.text = formatted;
    }
  }

  getOccupationList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.getOccupation),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final message = data['message'];

        final List<dynamic> results = message['results'] ?? [];

        occupationList.value = results.map((e) {
          return OccupationResult(
            name: e['name'] ?? '',
            occupation: e['occupation'] ?? '',
          );
        }).toList();
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage(Rx<File?> imageHolder) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      imageHolder.value = File(result.files.single.path!);
    }
  }

  saveLoanMember() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    try {
      var uri = Uri.parse(AppEnvironment.baseUrl + AppURLs.saveLoanMember);
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = token!;
      request.fields.addAll({
        'first_name': firstName.value.text,
        'member_id': memeberId.value.text,
        'middle_name': middleName.value.text,
        'last_name': lastName.value.text,
        'gender': selectedGender.value,
        'dob': dob.value.text,
        'completed_age': completedAge.value.text,
        'address_doc_type': selectedAddressDocType.value,
        "cibil_score": cibilScore.value.text,
        "cibil_date": cibilDate.value.text,
        'entry_age': entryAge.value.text,
        'mobile_no': mobileNo.value.text,
        'email': email.value.text,
        'occupation': selectedOccupation.value,
        'state': selectedState.value,
        'Country': selectedCountry.value,
        'city': city.value.text,
        'pincode': pincode.value.text,
        'aadhar': aadharNumber.value.text,
        'pancard': panNumber.value.text,
        'address': address.value.text,
        'bank_name': bankName.value.text,
        'account_number': accountNumber.value.text,
        'holder_name': holderName.value.text,
        'branch': branch.value.text,
        'ifsc_code': ifscCode.value.text,
        'bank_address': bankAddress.value.text,
        'voter_id': voterId.value.text,
      });

      Map<String, Rx<File?>> imageFields = {
        'member_image': memberImage,
        'aadhar_image': aadharImage,
        'pancard_image': panImage,
        'voter_id_image': voterImage,
        'address_image': addressImage,
        'home_image': homeImage,
      };

      for (var entry in imageFields.entries) {
        if (entry.value.value != null) {
          var file = await http.MultipartFile.fromPath(
            entry.key,
            entry.value.value!.path,
          );
          request.files.add(file);
        }
      }
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == APIStatusCode.SUCCESS) {
        var json = jsonDecode(response.body);
        final savedMemberData =
            json['message']?['data']?['name']?.toString() ?? '';
        CustomSnackBar.show(isIssue: false, message: json["message"]["msg"]);
        await getLoanMember(memberName: savedMemberData);
      } else {
        Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  updateLoanMember() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    if (name.value.isEmpty) {
      CustomSnackBar.show(isIssue: true, message: "Member name is required");
      return;
    }
    try {
      var uri = Uri.parse(AppEnvironment.baseUrl + AppURLs.updateLoanMember);
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = token!;
      Map<String, String> fields = {
        'name': name.value,
        'first_name': firstName.value.text,
        'member_id': memeberId.value.text,
        'middle_name': middleName.value.text,
        'last_name': lastName.value.text,
        'gender': selectedGender.value,
        'dob': dob.value.text,
        'completed_age': completedAge.value.text,
        'entry_age': entryAge.value.text,
        'mobile_no': mobileNo.value.text,
        'email': email.value.text,
        'address_doc_type': selectedAddressDocType.value,
        'occupation': selectedOccupation.value,
        'state': selectedState.value,
        'Country': selectedCountry.value,
        'city': city.value.text,
        'pincode': pincode.value.text,
        'aadhar': aadharNumber.value.text,
        'pancard': panNumber.value.text,
        'address': address.value.text,
        "cibil_score": cibilScore.value.text,
        "cibil_date": cibilDate.value.text,
        'bank_name': bankName.value.text,
        'account_number': accountNumber.value.text,
        'holder_name': holderName.value.text,
        'branch': branch.value.text,
        'ifsc_code': ifscCode.value.text,
        'bank_address': bankAddress.value.text,
        'voter_id': voterId.value.text,
      };

      fields.removeWhere((key, value) => value.isEmpty);
      request.fields.addAll(fields);
      print(voterImage);
      Map<String, Rx<File?>> imageFields = {
        'member_image': memberImage,
        'aadhar_image': aadharImage,
        'pancard_image': panImage,
        'voter_id_image': voterImage,
        'address_image': addressImage,
        'home_image': homeImage,
      };

      for (var entry in imageFields.entries) {
        if (entry.value.value != null) {
          var file = await http.MultipartFile.fromPath(
              entry.key, entry.value.value!.path);
          request.files.add(file);
        }
      }
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      Map<String, dynamic> json = {};
      try {
        json = jsonDecode(response.body);
      } catch (_) {}

      if (response.statusCode == APIStatusCode.SUCCESS) {
        String msg = json['message']?['msg'];
        CustomSnackBar.show(isIssue: false, message: msg);
      } else {
        String errorMsg = json['message']?['msg'];
        CustomSnackBar.show(isIssue: true, message: errorMsg);
      }
    } catch (e) {
      print("Exception: $e");
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  getStateList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(AppEnvironment.baseUrl + AppURLs.getState),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        State state = State.fromJson(data);
        stateList.value = state.message?.results ?? [];
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  getLoanMember({required String memberName}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final url =
          "${AppEnvironment.baseUrl}${AppURLs.loanMember(name: memberName)}";
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      if (response.statusCode != 200) {
        final Map<String, dynamic> err = jsonDecode(response.body);
        final msg = err['message']?['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
        return;
      }
      final Map<String, dynamic> data = jsonDecode(response.body);
      final memberData = LoanMemberListMessage.fromJson(data['message']);
      loanMember.value = [memberData];
      name.value = memberData.name ?? '';
      memeberId.value.text = memberData.memberId ?? '';
      firstName.value.text = memberData.firstName ?? '';
      middleName.value.text = memberData.middleName ?? '';
      cibilScore.value.text = memberData.cibilScore.toString();
      cibilDate.value.text = memberData.cibilDate ?? '';
      lastName.value.text = memberData.lastName ?? '';
      email.value.text = memberData.email ?? '';
      selectedGender.value = memberData.gender ?? '';
      entryAge.value.text = memberData.entryAge?.toString() ?? '';
      completedAge.value.text = memberData.completedAge?.toString() ?? '';
      mobileNo.value.text = memberData.mobileNo ?? '';
      selectedOccupation.value = memberData.occupation ?? '';
      address.value.text = memberData.address ?? '';
      selectedAddressDocType.value = memberData.addressDocType ?? '';
      city.value.text = memberData.city ?? '';
      pincode.value.text = memberData.pincode?.toString() ?? '';
      bankName.value.text = memberData.bankName ?? '';
      accountNumber.value.text = memberData.accountNumber ?? '';
      holderName.value.text = memberData.holderName ?? '';
      branch.value.text = memberData.branch ?? '';
      ifscCode.value.text = memberData.ifscCode ?? '';
      bankAddress.value.text = memberData.bankAddress ?? '';
      aadharNumber.value.text = memberData.aadhar ?? '';
      panNumber.value.text = memberData.pancard ?? '';
      voterId.value.text = memberData.voterId ?? '';
      dob.value.text = memberData.dob != null
          ? DateFormat('yyyy/MM/dd').format(memberData.dob!)
          : '';
      selectedOccupation.value = memberData.occupation ?? '';
      selectedState.value = memberData.state ?? '';
      memberImage.value = (memberData.memberImage != null &&
              memberData.memberImage!.isNotEmpty &&
              !memberData.memberImage!.startsWith('http'))
          ? File(memberData.memberImage!)
          : null;

      aadharImage.value = (memberData.aadharImage != null &&
              memberData.aadharImage!.isNotEmpty &&
              !memberData.aadharImage!.startsWith('http'))
          ? File(memberData.aadharImage!)
          : null;

      panImage.value = (memberData.pancardImage != null &&
              memberData.pancardImage!.isNotEmpty &&
              !memberData.pancardImage!.startsWith('http'))
          ? File(memberData.pancardImage!)
          : null;

      homeImage.value = (memberData.homeImage != null &&
              memberData.homeImage!.isNotEmpty &&
              !memberData.homeImage!.startsWith('http'))
          ? File(memberData.homeImage!)
          : null;

      addressImage.value = (memberData.addressImage != null &&
              memberData.addressImage!.isNotEmpty &&
              !memberData.addressImage!.startsWith('http'))
          ? File(memberData.addressImage!)
          : null;

      voterImage.value = (memberData.voterIdImage != null &&
              memberData.voterIdImage!.isNotEmpty &&
              !memberData.voterIdImage!.startsWith('http'))
          ? File(memberData.voterIdImage!)
          : null;
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  submitLoanMember({required String memberName}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;

      final response = await http.put(
        Uri.parse(AppEnvironment.baseUrl +
            AppURLs.submitLoanMember(name: memberName)),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        CustomSnackBar.show(isIssue: false, message: json["message"]["msg"]);
        clearAllFields();
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
      }
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  void clearAllFields() {
    memeberId.value.clear();
    firstName.value.clear();
    middleName.value.clear();
    lastName.value.clear();
    email.value.clear();
    entryAge.value.clear();
    completedAge.value.clear();
    mobileNo.value.clear();
    occupation.value.clear();
    membergender.value.clear();
    address.value.clear();
    city.value.clear();
    pincode.value.clear();
    bankName.value.clear();
    accountNumber.value.clear();
    holderName.value.clear();
    branch.value.clear();
    ifscCode.value.clear();
    bankAddress.value.clear();
    aadharNumber.value.clear();
    panNumber.value.clear();
    voterId.value.clear();
    cibilScore.value.clear();
    cibilDate.value.clear();
    addressDocType.value.clear();
    dob.value.clear();

    selectedGender.value = '';
    selectedOccupation.value = '';
    selectedState.value = '';
    selectedAddressDocType.value = '';

    memberImage.value = null;
    aadharImage.value = null;
    panImage.value = null;
    voterImage.value = null;
    homeImage.value = null;
    addressImage.value = null;

    loanMember.clear();
    name.value = '';
  }
}
