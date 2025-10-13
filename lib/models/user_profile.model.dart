class UserProfile {
  UserProfileMessage? message;

  UserProfile({
    this.message,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        message: UserProfileMessage.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message!.toJson(),
      };
}

class UserProfileMessage {
  UserProfileUser? user;
  UserProfileEmployee? employee;

  UserProfileMessage({
    this.user,
    this.employee,
  });

  factory UserProfileMessage.fromJson(Map<String, dynamic> json) =>
      UserProfileMessage(
        user: UserProfileUser.fromJson(json["user"]),
        employee: UserProfileEmployee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "employee": employee!.toJson(),
      };
}

class UserProfileEmployee {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? employee;
  String? namingSeries;
  String? firstName;
  dynamic middleName;
  dynamic lastName;
  String? employeeName;
  String? gender;
  DateTime? dateOfBirth;
  dynamic salutation;
  DateTime? dateOfJoining;
  dynamic image;
  String? status;
  String? userId;
  int? createUserPermission;
  String? company;
  dynamic department;
  dynamic employeeNumber;
  dynamic designation;
  dynamic reportsTo;
  dynamic branch;
  dynamic scheduledConfirmationDate;
  dynamic finalConfirmationDate;
  dynamic contractEndDate;
  int? noticeNumberOfDays;
  dynamic dateOfRetirement;
  dynamic cellNumber;
  dynamic personalEmail;
  dynamic companyEmail;
  String? preferedContactEmail;
  dynamic preferedEmail;
  int? unsubscribed;
  dynamic currentAddress;
  String? currentAccommodationType;
  dynamic permanentAddress;
  String? permanentAccommodationType;
  dynamic personToBeContacted;
  dynamic emergencyPhoneNumber;
  dynamic relation;
  dynamic attendanceDeviceId;
  dynamic holidayList;
  int? ctc;
  String? salaryCurrency;
  String? salaryMode;
  dynamic bankName;
  dynamic bankAcNo;
  dynamic iban;
  String? maritalStatus;
  dynamic familyBackground;
  String? bloodGroup;
  dynamic healthDetails;
  dynamic passportNumber;
  dynamic validUpto;
  dynamic dateOfIssue;
  dynamic placeOfIssue;
  dynamic bio;
  dynamic resignationLetterDate;
  dynamic relievingDate;
  dynamic heldOn;
  dynamic newWorkplace;
  String? leaveEncashed;
  dynamic encashmentDate;
  dynamic reasonForLeaving;
  dynamic feedback;
  int? lft;
  int? rgt;
  String? oldParent;
  String? doctype;
  List<dynamic>? externalWorkHistory;
  List<dynamic>? internalWorkHistory;
  List<dynamic>? education;

  UserProfileEmployee({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.docstatus,
    this.idx,
    this.employee,
    this.namingSeries,
    this.firstName,
    this.middleName,
    this.lastName,
    this.employeeName,
    this.gender,
    this.dateOfBirth,
    this.salutation,
    this.dateOfJoining,
    this.image,
    this.status,
    this.userId,
    this.createUserPermission,
    this.company,
    this.department,
    this.employeeNumber,
    this.designation,
    this.reportsTo,
    this.branch,
    this.scheduledConfirmationDate,
    this.finalConfirmationDate,
    this.contractEndDate,
    this.noticeNumberOfDays,
    this.dateOfRetirement,
    this.cellNumber,
    this.personalEmail,
    this.companyEmail,
    this.preferedContactEmail,
    this.preferedEmail,
    this.unsubscribed,
    this.currentAddress,
    this.currentAccommodationType,
    this.permanentAddress,
    this.permanentAccommodationType,
    this.personToBeContacted,
    this.emergencyPhoneNumber,
    this.relation,
    this.attendanceDeviceId,
    this.holidayList,
    this.ctc,
    this.salaryCurrency,
    this.salaryMode,
    this.bankName,
    this.bankAcNo,
    this.iban,
    this.maritalStatus,
    this.familyBackground,
    this.bloodGroup,
    this.healthDetails,
    this.passportNumber,
    this.validUpto,
    this.dateOfIssue,
    this.placeOfIssue,
    this.bio,
    this.resignationLetterDate,
    this.relievingDate,
    this.heldOn,
    this.newWorkplace,
    this.leaveEncashed,
    this.encashmentDate,
    this.reasonForLeaving,
    this.feedback,
    this.lft,
    this.rgt,
    this.oldParent,
    this.doctype,
    this.externalWorkHistory,
    this.internalWorkHistory,
    this.education,
  });

  factory UserProfileEmployee.fromJson(Map<String, dynamic> json) =>
      UserProfileEmployee(
        name: json["name"],
        owner: json["owner"],
        creation: DateTime.parse(json["creation"]),
        modified: DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        docstatus: json["docstatus"],
        idx: json["idx"],
        employee: json["employee"],
        namingSeries: json["naming_series"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        employeeName: json["employee_name"],
        gender: json["gender"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        salutation: json["salutation"],
        dateOfJoining: DateTime.parse(json["date_of_joining"]),
        image: json["image"],
        status: json["status"],
        userId: json["user_id"],
        createUserPermission: json["create_user_permission"],
        company: json["company"],
        department: json["department"],
        employeeNumber: json["employee_number"],
        designation: json["designation"],
        reportsTo: json["reports_to"],
        branch: json["branch"],
        scheduledConfirmationDate: json["scheduled_confirmation_date"],
        finalConfirmationDate: json["final_confirmation_date"],
        contractEndDate: json["contract_end_date"],
        noticeNumberOfDays: json["notice_number_of_days"],
        dateOfRetirement: json["date_of_retirement"],
        cellNumber: json["cell_number"],
        personalEmail: json["personal_email"],
        companyEmail: json["company_email"],
        preferedContactEmail: json["prefered_contact_email"],
        preferedEmail: json["prefered_email"],
        unsubscribed: json["unsubscribed"],
        currentAddress: json["current_address"],
        currentAccommodationType: json["current_accommodation_type"],
        permanentAddress: json["permanent_address"],
        permanentAccommodationType: json["permanent_accommodation_type"],
        personToBeContacted: json["person_to_be_contacted"],
        emergencyPhoneNumber: json["emergency_phone_number"],
        relation: json["relation"],
        attendanceDeviceId: json["attendance_device_id"],
        holidayList: json["holiday_list"],
        ctc: json["ctc"],
        salaryCurrency: json["salary_currency"],
        salaryMode: json["salary_mode"],
        bankName: json["bank_name"],
        bankAcNo: json["bank_ac_no"],
        iban: json["iban"],
        maritalStatus: json["marital_status"],
        familyBackground: json["family_background"],
        bloodGroup: json["blood_group"],
        healthDetails: json["health_details"],
        passportNumber: json["passport_number"],
        validUpto: json["valid_upto"],
        dateOfIssue: json["date_of_issue"],
        placeOfIssue: json["place_of_issue"],
        bio: json["bio"],
        resignationLetterDate: json["resignation_letter_date"],
        relievingDate: json["relieving_date"],
        heldOn: json["held_on"],
        newWorkplace: json["new_workplace"],
        leaveEncashed: json["leave_encashed"],
        encashmentDate: json["encashment_date"],
        reasonForLeaving: json["reason_for_leaving"],
        feedback: json["feedback"],
        lft: json["lft"],
        rgt: json["rgt"],
        oldParent: json["old_parent"],
        doctype: json["doctype"],
        externalWorkHistory:
            List<dynamic>.from(json["external_work_history"].map((x) => x)),
        internalWorkHistory:
            List<dynamic>.from(json["internal_work_history"].map((x) => x)),
        education: List<dynamic>.from(json["education"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation!.toIso8601String(),
        "modified": modified!.toIso8601String(),
        "modified_by": modifiedBy,
        "docstatus": docstatus,
        "idx": idx,
        "employee": employee,
        "naming_series": namingSeries,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "employee_name": employeeName,
        "gender": gender,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "salutation": salutation,
        "date_of_joining":
            "${dateOfJoining!.year.toString().padLeft(4, '0')}-${dateOfJoining!.month.toString().padLeft(2, '0')}-${dateOfJoining!.day.toString().padLeft(2, '0')}",
        "image": image,
        "status": status,
        "user_id": userId,
        "create_user_permission": createUserPermission,
        "company": company,
        "department": department,
        "employee_number": employeeNumber,
        "designation": designation,
        "reports_to": reportsTo,
        "branch": branch,
        "scheduled_confirmation_date": scheduledConfirmationDate,
        "final_confirmation_date": finalConfirmationDate,
        "contract_end_date": contractEndDate,
        "notice_number_of_days": noticeNumberOfDays,
        "date_of_retirement": dateOfRetirement,
        "cell_number": cellNumber,
        "personal_email": personalEmail,
        "company_email": companyEmail,
        "prefered_contact_email": preferedContactEmail,
        "prefered_email": preferedEmail,
        "unsubscribed": unsubscribed,
        "current_address": currentAddress,
        "current_accommodation_type": currentAccommodationType,
        "permanent_address": permanentAddress,
        "permanent_accommodation_type": permanentAccommodationType,
        "person_to_be_contacted": personToBeContacted,
        "emergency_phone_number": emergencyPhoneNumber,
        "relation": relation,
        "attendance_device_id": attendanceDeviceId,
        "holiday_list": holidayList,
        "ctc": ctc,
        "salary_currency": salaryCurrency,
        "salary_mode": salaryMode,
        "bank_name": bankName,
        "bank_ac_no": bankAcNo,
        "iban": iban,
        "marital_status": maritalStatus,
        "family_background": familyBackground,
        "blood_group": bloodGroup,
        "health_details": healthDetails,
        "passport_number": passportNumber,
        "valid_upto": validUpto,
        "date_of_issue": dateOfIssue,
        "place_of_issue": placeOfIssue,
        "bio": bio,
        "resignation_letter_date": resignationLetterDate,
        "relieving_date": relievingDate,
        "held_on": heldOn,
        "new_workplace": newWorkplace,
        "leave_encashed": leaveEncashed,
        "encashment_date": encashmentDate,
        "reason_for_leaving": reasonForLeaving,
        "feedback": feedback,
        "lft": lft,
        "rgt": rgt,
        "old_parent": oldParent,
        "doctype": doctype,
        "external_work_history":
            List<dynamic>.from(externalWorkHistory!.map((x) => x)),
        "internal_work_history":
            List<dynamic>.from(internalWorkHistory!.map((x) => x)),
        "education": List<dynamic>.from(education!.map((x) => x)),
      };
}

class UserProfileUser {
  String? name;
  String? fullName;
  String? email;
  dynamic mobileNo;
  String? username;
  List<String>? roles;

  UserProfileUser({
    this.name,
    this.fullName,
    this.email,
    this.mobileNo,
    this.username,
    this.roles,
  });

  factory UserProfileUser.fromJson(Map<String, dynamic> json) =>
      UserProfileUser(
        name: json["name"],
        fullName: json["full_name"],
        email: json["email"],
        mobileNo: json["mobile_no"],
        username: json["username"],
        roles: List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "full_name": fullName,
        "email": email,
        "mobile_no": mobileNo,
        "username": username,
        "roles": List<dynamic>.from(roles!.map((x) => x)),
      };
}
