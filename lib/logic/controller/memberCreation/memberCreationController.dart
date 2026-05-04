import 'dart:convert';
import 'dart:io';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide State;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:microfinance/AppPreferences/app_areferences.dart';
import 'package:microfinance/api/api_status_code.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/app_urls.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/models/group_list.model.dart';
import 'package:microfinance/models/loan_memeber_list.model.dart';
import 'package:microfinance/models/occupation_list.model.dart';
import 'package:microfinance/models/state_list.model.dart';
import 'package:microfinance/services/auth_service/auth_service.dart';
import 'package:microfinance/utils/snackbar_widget.dart';

class MemberCreationController extends GetxController {
  Rx<TextEditingController> dob = TextEditingController().obs;
  Rx<TextEditingController> firstName = TextEditingController().obs;
  Rx<TextEditingController> middleName = TextEditingController().obs;
  Rx<TextEditingController> lastName = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> entryAge = TextEditingController().obs;
  Rx<TextEditingController> completedAge = TextEditingController().obs;
  Rx<TextEditingController> mobileNo = TextEditingController().obs;
  Rx<TextEditingController> alternateMobileNo = TextEditingController().obs;
  Rx<TextEditingController> addressLineTwo = TextEditingController().obs;
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
  Rx<TextEditingController> microFinanceCibilScore = TextEditingController().obs;
  Rx<TextEditingController> adminCibilRemark = TextEditingController().obs;
  Rx<TextEditingController> addressDocType = TextEditingController().obs;
  Rx<TextEditingController> country = TextEditingController(text: "INDIA").obs;
  Rx<TextEditingController> createdBy = TextEditingController().obs;
  Rx<TextEditingController> memberId = TextEditingController().obs;
  RxString addressImageUrl = ''.obs;
  Rx<TextEditingController> consumerNumberController = TextEditingController().obs;
  RxBool showConsumerNumber = false.obs;
  Rx<File?> aadharImage = Rx<File?>(null);
  Rx<File?> homeImage = Rx<File?>(null);
  Rx<File?> panImage = Rx<File?>(null);
  Rx<File?> voterImage = Rx<File?>(null);
  Rx<File?> memberImage = Rx<File?>(null);
  Rx<File?> passbookImage1 = Rx<File?>(null);
  Rx<File?> passbookImage2 = Rx<File?>(null);
  Rx<File?> addressImage = Rx<File?>(null);
  Rx<File?> addressProofImage = Rx<File?>(null);
  Rx<File?> aadharbackImage = Rx<File?>(null);
  Rx<File?> panbackImage = Rx<File?>(null);
  Rx<File?> voterbackImage = Rx<File?>(null);
  Rx<File?> cibilReportImage = Rx<File?>(null);
  final RxBool memberError = false.obs;
  RxBool isvoterImageFocused = false.obs;
  RxBool ishomeImageFocused = false.obs;
  RxBool isAadharImageFocused = false.obs;
  RxBool isPanImageFocused = false.obs;
  RxBool isLoading = false.obs;
  RxBool isAddressImageFocused = false.obs;
  RxBool isMemberImageFocused = false.obs;
  RxBool isPassbookImage1Focused = false.obs;
  RxBool isPassbookImage2Focused = false.obs;
  RxBool isAddressProofImageFocused = false.obs;
  RxBool isvoterbackImageFocused = false.obs;
  RxBool isPanImagebackFocused = false.obs;
  RxBool isAadharbackImageFocused = false.obs;
  RxBool isCibilReportImageFocused = false.obs;
  RxString selectedOccupation = ''.obs;
  RxString selectedCountry = "".obs;
  RxString selectedState = "".obs;
  RxString name = "".obs;
  RxBool isDobSelected = false.obs;
  RxBool isFormEdit = false.obs;
  Rx<StateResult?> selectedstateObj = Rx<StateResult?>(null);
  RxList<OccupationResult> occupationList = <OccupationResult>[].obs;
  RxList<LoanMemberListResult> loanMember = <LoanMemberListResult>[].obs;
  RxList<GroupListMessage> groupList = <GroupListMessage>[].obs;
  RxList<StateResult> stateList = <StateResult>[].obs;
  Rx<Position?> memberImagePosition = Rx<Position?>(null);
  RxString memberImageAddress = ''.obs;
  RxInt selectedIndex = 0.obs;
  RxString selectedGroup = "".obs;
  RxString selectedGroupId = "".obs;
  RxBool showOnlyGeoFields = false.obs;
  RxBool isCreatedBy = false.obs;
  RxBool isMemberId = false.obs;

  final ScrollController scrollController = ScrollController();
  final List<GlobalKey> itemKeys = [];
  final List<String> genderList = [
    "MALE",
    "FEMALE",
    "OTHER"
  ]; 
  RxString selectedGender = ''.obs;
  final List<String> addressDocTypeList = [
    "ELECTRICITY BILL",
    "RENT AGREEMENT"
  ];
  RxString selectedAddressDocType = ''.obs;
  Rx<Position?> homeImagePosition = Rx<Position?>(null);
  RxString homeImageAddress = ''.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxString geoLocation = ''.obs;
  Rx<TextEditingController> homelatitude = TextEditingController().obs;
  Rx<TextEditingController> homelongitude = TextEditingController().obs;
  Rx<TextEditingController> homeGeoLocation = TextEditingController().obs;
  RxBool isReadOnly = false.obs;

  @override
  void onInit() async {
    super.onInit();
    selectedState.value = "MH";
    mobileNo.value.text = '+91';
    alternateMobileNo.value.text = '+91';
    await getOccupationList();
    getGroupList();
    await getStateList();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['name'] != null) {
      name.value = args['name'].toString();
      await getLoanMember(memberName: name.value);
    }

    if (args?['isReadOnly'] != null) {
      isReadOnly.value = args?['isReadOnly'] as bool? ?? false;
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

  void updateAgesFromDOB(String dobText) {
    if (dobText.isEmpty) {
      isDobSelected.value = false;
      entryAge.value.text = '';
      completedAge.value.text = '';
      return;
    }
    if (!dobText.contains('-') || dobText.split('-').length != 3) {
      entryAge.value.text = '';
      completedAge.value.text = '';
      isDobSelected.value = false;
      return;
    }

    if (dobText.length == 10) {
      try {
        DateTime dob = DateFormat('dd-MM-yyyy').parseStrict(dobText);
        DateTime today = DateTime.now();

        int completed = today.year - dob.year;
        if (today.month < dob.month ||
            (today.month == dob.month && today.day < dob.day)) {
          completed--;
        }

        int entry = completed + 1;

        entryAge.value.text = entry.toString();
        completedAge.value.text = completed.toString();
        isDobSelected.value = true;
      } catch (e) {
        entryAge.value.text = '';
        completedAge.value.text = '';
        isDobSelected.value = false;
      }
    } else {
      entryAge.value.text = '';
      completedAge.value.text = '';
      isDobSelected.value = false;
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
        dayTextStyle: const TextStyle(
          color: Colors.black,
        ),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      ),
      dialogSize: const Size(350, 400),
      borderRadius: BorderRadius.circular(15),
    );

    if (picked != null && picked.isNotEmpty && picked.first != null) {
      String formatted = DateFormat('dd-MM-yyyy').format(picked.first!);
      isDobSelected.value = true;
      controller.text = formatted;
      updateAgesFromDOB(formatted);
    }
  }

  Future<void> selectDate1(
      BuildContext context, TextEditingController controller) async {
    List<DateTime?>? picked = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        okButtonTextStyle: const TextStyle(color: Colors.black),
        cancelButtonTextStyle: const TextStyle(color: Colors.black),
        selectedDayHighlightColor: Colors.grey,
        dayTextStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
      dialogSize: const Size(350, 400),
      borderRadius: BorderRadius.circular(15),
    );

    if (picked != null && picked.isNotEmpty && picked.first != null) {
      String formatted = DateFormat('dd-MM-yyyy').format(picked.first!);
      isDobSelected.value = true;
      controller.text = formatted;
    }
  }

  getGroupList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;
      final url = Uri.parse(AppEnvironment.baseUrl + AppURLs.groupList);
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> messages = responseBody['message'];
        groupList.value =
            messages.map((e) => GroupListMessage.fromJson(e)).toList();
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
      }
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: url.toString(),
          dateTime: DateTime.now(),
          data: {},
          response: responseBody,
        ),
      );
    } catch (e) {
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: "${AppEnvironment.baseUrl}${AppURLs.groupList}",
          dateTime: DateTime.now(),
          data: {},
          response: {"error": e.toString()},
        ),
      );
      CustomSnackBar.show(isIssue: true, message: "$e");
    } finally {
      isLoading.value = false;
    }
  }

  getOccupationList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;

      final url = Uri.parse(AppEnvironment.baseUrl + AppURLs.getOccupation);
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final message = responseBody['message'];

        final List<dynamic> results = message['results'] ?? [];

        occupationList.value = results.map((e) {
          return OccupationResult(
            name: e['name'] ?? '',
            occupation: e['occupation'] ?? '',
          );
        }).toList();
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
      }
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: url.toString(),
          dateTime: DateTime.now(),
          data: {},
          response: responseBody,
        ),
      );
    } catch (e) {
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: "${AppEnvironment.baseUrl}${AppURLs.groupList}",
          dateTime: DateTime.now(),
          data: {},
          response: {"error": e.toString()},
        ),
      );
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

  String convertToApiDate(String ddMMyyyy) {
    try {
      DateTime dt = DateFormat('dd-MM-yyyy').parse(ddMMyyyy);
      return DateFormat('yyyy-MM-dd').format(dt);
    } catch (_) {
      return ddMMyyyy;
    }
  }

  String formatToDisplay(String? apiDate) {
    if (apiDate == null || apiDate.isEmpty) return '';

    try {
      DateTime dt = DateFormat('yyyy-MM-dd').parse(apiDate);
      return DateFormat('dd-MM-yyyy').format(dt);
    } catch (e) {
      return apiDate;
    }
  }

  saveLoanMember() async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    final uri = Uri.parse(AppEnvironment.baseUrl + AppURLs.saveLoanMember);

    final Map<String, String> fields = {
      'first_name': firstName.value.text,
      'middle_name': middleName.value.text,
      'last_name': lastName.value.text,
      'gender': selectedGender.value,
      'dob': convertToApiDate(dob.value.text),
      'completed_age': completedAge.value.text,
      'address_doc_type': selectedAddressDocType.value,
      "cibil_score": cibilScore.value.text,
      "micro_fin_cibil_score": microFinanceCibilScore.value.text,
      "cibil_date": convertToApiDate(cibilDate.value.text),
      'entry_age': entryAge.value.text,
      'mobile_no': mobileNo.value.text,
      'email': email.value.text,
      'occupation': selectedOccupation.value,
      'group': selectedGroup.value,
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
      "address_line_2": addressLineTwo.value.text,
      "mobile_no_2": alternateMobileNo.value.text,
      "longitude": longitude.value.toString(),
      "latitude": latitude.value.toString(),
      "geo_location": geoLocation.value,
      "consumer_no": consumerNumberController.value.text
    };

    final Map<String, Rx<File?>> imageFields = {
      'member_image': memberImage,
      'aadhar_image': aadharImage,
      'pancard_image': panImage,
      'voter_id_image': voterImage,
      'address_image': addressImage,
      'home_image': homeImage,
      "aadhar_image_back": aadharbackImage,
      "pancard_image_back": panbackImage,
      "voter_id_image_back": voterbackImage,
      "passbook_image": passbookImage1,
      "passbook_image_2": passbookImage2,
      "cibil_report": cibilReportImage,
    };

    final List<String> fileNames = [];
    imageFields.forEach((key, value) {
      if (value.value != null) fileNames.add(value.value!.path.split('/').last);
    });

    try {
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = token!;
      request.fields.addAll(fields);
      for (var entry in imageFields.entries) {
        if (entry.value.value != null) {
          final file = await http.MultipartFile.fromPath(
            entry.key,
            entry.value.value!.path,
          );
          request.files.add(file);
        }
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == APIStatusCode.SUCCESS) {
        final savedMemberData =
            responseBody['message']?['data']?['name']?.toString() ?? '';
        CustomSnackBar.show(
            isIssue: false, message: responseBody["message"]["msg"]);
        await getLoanMember(memberName: savedMemberData);
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else {
        final msg = responseBody['message']['msg'] ?? 'Something went wrong';
        CustomSnackBar.show(isIssue: true, message: msg);
      }
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "POST",
          path: uri.toString(),
          dateTime: DateTime.now(),
          data: {
            ...fields,
            "files": fileNames,
          },
          response: responseBody,
        ),
      );
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "POST",
          path: uri.toString(),
          dateTime: DateTime.now(),
          data: {
            ...fields,
            "files": fileNames,
          },
          response: {"error": e.toString()},
        ),
      );
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
    final uri = Uri.parse(AppEnvironment.baseUrl + "${AppURLs.updateLoanMember}?name=${name.value}");
    final Map<String, String> fields = {
      'name': name.value,
      'first_name': firstName.value.text,
      'member_id': memberId.value.text,
      'middle_name': middleName.value.text,
      'last_name': lastName.value.text,
      'gender': selectedGender.value,
      'dob': convertToApiDate(dob.value.text),
      'completed_age': completedAge.value.text,
      'entry_age': entryAge.value.text,
      'mobile_no': mobileNo.value.text,
      'email': email.value.text,
      'address_doc_type': selectedAddressDocType.value,
      'occupation': selectedOccupation.value,
      'group': selectedGroup.value,
      'state': selectedState.value,
      'Country': selectedCountry.value,
      'city': city.value.text,
      'pincode': pincode.value.text,
      'aadhar': aadharNumber.value.text,
      'pancard': panNumber.value.text,
      'address': address.value.text,
      "cibil_score": cibilScore.value.text,
      "micro_fin_cibil_score": microFinanceCibilScore.value.text,
      "cibil_date": convertToApiDate(cibilDate.value.text),
      'bank_name': bankName.value.text,
      'account_number': accountNumber.value.text,
      'holder_name': holderName.value.text,
      'branch': branch.value.text,
      'ifsc_code': ifscCode.value.text,
      'bank_address': bankAddress.value.text,
      'voter_id': voterId.value.text,
      "address_line_2": addressLineTwo.value.text,
      "mobile_no_2": alternateMobileNo.value.text,
      "longitude": longitude.value.toString(),
      "latitude": latitude.value.toString(),
      "geo_location": geoLocation.value,
      "consumer_no": consumerNumberController.value.text
    };
    fields.removeWhere((key, value) => value.isEmpty);

    final Map<String, Rx<File?>> imageFields = {
      'member_image': memberImage,
      'aadhar_image': aadharImage,
      'pancard_image': panImage,
      'voter_id_image': voterImage,
      'address_image': addressImage,
      'home_image': homeImage,
      "aadhar_image_back": aadharbackImage,
      "pancard_image_back": panbackImage,
      "voter_id_image_back": voterbackImage,
      "passbook_image": passbookImage1,
      "passbook_image_2": passbookImage2,
      "cibil_report": cibilReportImage,
    };
    final List<String> fileNames = [];
    imageFields.forEach((key, value) {
      if (value.value != null) fileNames.add(value.value!.path.split('/').last);
    });

    try {
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = token!;
      request.fields.addAll(fields);
      for (var entry in imageFields.entries) {
        if (entry.value.value != null) {
          final file = await http.MultipartFile.fromPath(
            entry.key,
            entry.value.value!.path,
          );
          request.files.add(file);
        }
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      Map<String, dynamic> responseBody = {};
      try {
        responseBody = jsonDecode(response.body);
      } catch (_) {}
      
      if (response.statusCode == APIStatusCode.SUCCESS) {
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else {
        final errorMsg =
            responseBody['message']?['msg'] ?? 'Something went wrong';
        CustomSnackBar.show(isIssue: true, message: errorMsg);
      }
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "POST",
          path: uri.toString(),
          dateTime: DateTime.now(),
          data: {
            ...fields,
            "files": fileNames,
          },
          response: responseBody,
        ),
      );
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "POST",
          path: uri.toString(),
          dateTime: DateTime.now(),
          data: {
            ...fields,
            "files": fileNames,
          },
          response: {"error": e.toString()},
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  getStateList() async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;

      final url = Uri.parse(AppEnvironment.baseUrl + AppURLs.getState);
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        State state = State.fromJson(responseBody);
        stateList.value = state.message?.results ?? [];
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
      }
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: url.toString(),
          dateTime: DateTime.now(),
          data: {},
          response: responseBody,
        ),
      );
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: "${AppEnvironment.baseUrl}${AppURLs.groupList}",
          dateTime: DateTime.now(),
          data: {},
          response: {"error": e.toString()},
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  String formatMobileWithPrefix(String? mobile) {
    if (mobile == null) return '';
    String cleaned = mobile.trim();
    if (cleaned == '0' || cleaned == '00') return '+91';
    cleaned = cleaned.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleaned.isEmpty) return '';
    if (cleaned.length > 10) {
      cleaned = cleaned.substring(cleaned.length - 10);
    }
    if (!cleaned.startsWith('91')) {
      cleaned = '91$cleaned';
    }
    return '+$cleaned';
  }

  getLoanMember({required String memberName}) async {
    final token = await AppPreferences.getToken();
    try {
      isLoading.value = true;

      final url = Uri.parse(
          "${AppEnvironment.baseUrl}${AppURLs.loanMember(name: memberName)}");
      ;
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final memberData =
            LoanMemberListResult.fromJson(responseBody['message']);
        loanMember.value = [memberData];
        name.value = memberData.name ?? '';
        firstName.value.text = memberData.firstName ?? '';
        middleName.value.text = memberData.middleName ?? '';
        cibilScore.value.text =
            (memberData.cibilScore == 0 || memberData.cibilScore == null)
                ? ''
                : memberData.cibilScore.toString();
        cibilDate.value.text = formatToDisplay(memberData.cibilDate);
        microFinanceCibilScore.value.text =
            (memberData.microFinanceCibilScore == 0 || memberData.microFinanceCibilScore == null)
                ? ''
                : memberData.microFinanceCibilScore.toString();
        adminCibilRemark.value.text = memberData.adminCibilRemark ?? '';
        lastName.value.text = memberData.lastName ?? '';
        email.value.text = memberData.email ?? '';
        selectedGender.value = memberData.gender ?? '';
        mobileNo.value.text = formatMobileWithPrefix(memberData.mobileNo);
        selectedOccupation.value = memberData.occupation ?? '';
        address.value.text = memberData.address ?? '';
        city.value.text = memberData.city ?? '';
        showConsumerNumber.value =
            memberData.addressDocType == "ELECTRICITY BILL";
        consumerNumberController.value.text = showConsumerNumber.value
            ? (memberData.consumerNo?.toString() ?? '')
            : '';
        pincode.value.text =
            (memberData.pincode == 0 || memberData.pincode == null)
                ? ''
                : memberData.pincode.toString();
        bankName.value.text = memberData.bankName ?? '';
        accountNumber.value.text = memberData.accountNumber ?? '';
        holderName.value.text = memberData.holderName ?? '';
        branch.value.text = memberData.branch ?? '';
        ifscCode.value.text = memberData.ifscCode ?? '';
        bankAddress.value.text = memberData.bankAddress ?? '';
        aadharNumber.value.text = memberData.aadhar ?? '';
        panNumber.value.text = memberData.pancard ?? '';
        voterId.value.text = memberData.voterId ?? '';
        alternateMobileNo.value.text =
            formatMobileWithPrefix(memberData.mobileNoLine2);
        addressLineTwo.value.text = memberData.addressLine2 ?? '';
        createdBy.value.text = memberData.createdBy ?? '';
        dob.value.text = memberData.dob != null
            ? DateFormat('dd-MM-yyyy').format(memberData.dob!)
            : '';

        if (memberData.longitude != null && memberData.latitude != null) {
          homelongitude.value.text = memberData.longitude.toString();
          homelatitude.value.text = memberData.latitude.toString();
          homeGeoLocation.value.text = memberData.geoLocation ?? '';
          showOnlyGeoFields.value = true;
        }
        if (memberData.memberId != null) {
          memberId.value.text = memberData.memberId ?? '';
          isMemberId.value = true;
        }
        if (memberData.createdBy != null) {
          createdBy.value.text = memberData.createdBy ?? '';
          isCreatedBy.value = true;
        }
        if (memberData.dob != null) {
          isDobSelected.value = true;
          entryAge.value.text = memberData.entryAge?.toString() ?? '';
          completedAge.value.text = memberData.completedAge?.toString() ?? '';
        }
        selectedOccupation.value = memberData.occupation ?? '';
        selectedGroup.value = memberData.group ?? '';
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

        aadharbackImage.value = (memberData.aadharImageBack != null &&
                memberData.aadharImageBack!.isNotEmpty &&
                !memberData.aadharImageBack!.startsWith('http'))
            ? File(memberData.aadharImageBack!)
            : null;

        panImage.value = (memberData.pancardImage != null &&
                memberData.pancardImage!.isNotEmpty &&
                !memberData.pancardImage!.startsWith('http'))
            ? File(memberData.pancardImage!)
            : null;
        panbackImage.value = (memberData.pancardImageBack != null &&
                memberData.pancardImageBack!.isNotEmpty &&
                !memberData.pancardImageBack!.startsWith('http'))
            ? File(memberData.pancardImageBack!)
            : null;

        homeImage.value = (memberData.homeImage != null &&
                memberData.homeImage!.isNotEmpty &&
                !memberData.homeImage!.startsWith('http'))
            ? File(memberData.homeImage!)
            : null;
        
        passbookImage1.value = (memberData.passbookImage1 != null &&
                memberData.passbookImage1!.isNotEmpty &&
                !memberData.passbookImage1!.startsWith('http'))
            ? File(memberData.passbookImage1!)
            : null;

        passbookImage2.value = (memberData.passbookImage2 != null &&
                memberData.passbookImage2!.isNotEmpty &&
                !memberData.passbookImage2!.startsWith('http'))
            ? File(memberData.passbookImage2!)
            : null;

        cibilReportImage.value = (memberData.cibilReportImage != null &&
                memberData.cibilReportImage!.isNotEmpty &&
                !memberData.cibilReportImage!.startsWith('http'))
            ? File(memberData.cibilReportImage!)
            : null;        

        selectedAddressDocType.value = memberData.addressDocType ?? '';
        final image = memberData.addressImage ?? '';
        addressImage.value =
            image.isNotEmpty && !image.startsWith('http') ? File(image) : null;
        addressImageUrl.value = image.startsWith('http') ? image : '';

        voterImage.value = (memberData.voterIdImage != null &&
                memberData.voterIdImage!.isNotEmpty &&
                !memberData.voterIdImage!.startsWith('http'))
            ? File(memberData.voterIdImage!)
            : null;

        voterbackImage.value = (memberData.voterIdImageBack != null &&
                memberData.voterIdImageBack!.isNotEmpty &&
                !memberData.voterIdImageBack!.startsWith('http'))
            ? File(memberData.voterIdImageBack!)
            : null;
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else {
        final Map<String, dynamic> errormsg = jsonDecode(response.body);
        String msg = errormsg['message']?['msg'];
        CustomSnackBar.show(isIssue: true, message: msg);
      }
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: url.toString(),
          dateTime: DateTime.now(),
          data: {},
          response: responseBody,
        ),
      );
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "GET",
          path: "${AppEnvironment.baseUrl}${AppURLs.groupList}",
          dateTime: DateTime.now(),
          data: {},
          response: {"error": e.toString()},
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  submitLoanMember({required String memberName}) async {
    final token = await AppPreferences.getToken();
    isLoading.value = true;
    final uri = Uri.parse(
        AppEnvironment.baseUrl + AppURLs.submitLoanMember(name: memberName));
    final Map<String, dynamic> requestData = {"name": memberName};

    try {
      final response = await http.put(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
      );
      Map<String, dynamic> responseBody = {};
      try {
        responseBody = jsonDecode(response.body);
      } catch (_) {}

      if (response.statusCode == 200) {
      } else if (response.statusCode == 401) {
        await oauthService.handleExceptionLogout('AuthenticationError');
        CustomSnackBar.show(isIssue: true, message: "Authentication Error");
      } else if (response.statusCode == 500) {
        CustomSnackBar.show(
          isIssue: true,
          message: "Internal Server Error. Please try again later.",
        );
      } else {
        final msg = responseBody['message']?['msg'] ?? 'Something went wrong';
        CustomSnackBar.show(isIssue: true, message: msg);
      }
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "PUT",
          path: uri.toString(),
          dateTime: DateTime.now(),
          data: requestData,
          response: responseBody,
        ),
      );
    } catch (e) {
      CustomSnackBar.show(isIssue: true, message: "$e");
      DevService.instance.insertAPICall(
        AppAPIsCall(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          type: "PUT",
          path: uri.toString(),
          dateTime: DateTime.now(),
          data: requestData,
          response: {"error": e.toString()},
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearAllFields() {
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
    passbookImage1.value = null;
    passbookImage2.value = null;
    cibilReportImage.value = null;

    loanMember.clear();
    name.value = '';
  }
}
