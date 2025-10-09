class LoanMemberListAsPerGroup {
  List<LoanMemberListAsPerGroupMessage>? message;

  LoanMemberListAsPerGroup({this.message});

  factory LoanMemberListAsPerGroup.fromJson(Map<String, dynamic> json) =>
      LoanMemberListAsPerGroup(
        message: json["message"] != null
            ? List<LoanMemberListAsPerGroupMessage>.from(
                json["message"]
                    .map((x) => LoanMemberListAsPerGroupMessage.fromJson(x)),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
        "message": message != null
            ? List<dynamic>.from(message!.map((x) => x.toJson()))
            : [],
      };
}

class LoanMemberListAsPerGroupMessage {
  String? name;
  String? firstName;
  String? lastName;
  String? middleName;
  String? gender;
  DateTime? dob;
  int? completedAge;
  int? entryAge;
  String? mobileNo;
  String? state;
  String? country;
  String? city;
  int? pincode;
  String? status;
  String? occupation;
  String? group;
  String? email;
  String? address;
  String? nominee;
  String? relation;
  String? aadhar;
  String? pancard;
  String? aadharImage;
  String? pancardImage;
  String? addressImage;
  int? aadharVerified;
  int? pancardVerified;
  int? addressVerified;
  int? cibilScore;
  DateTime? cibilDate;
  String? bankName;
  String? accountNumber;
  String? holderName;
  String? branch;
  String? ifscCode;
  String? accountType;
  String? bankAddress;
  String? memberId;
  String? memberImage;
  String? company;
  String? memberName;
  String? addressDocType;
  String? homeImage;
  String? voterId;
  String? voterIdImage;
  String? groupGroupName;

  LoanMemberListAsPerGroupMessage({
    this.name,
    this.firstName,
    this.lastName,
    this.middleName,
    this.gender,
    this.dob,
    this.completedAge,
    this.entryAge,
    this.mobileNo,
    this.state,
    this.country,
    this.city,
    this.pincode,
    this.status,
    this.occupation,
    this.group,
    this.email,
    this.address,
    this.nominee,
    this.relation,
    this.aadhar,
    this.pancard,
    this.aadharImage,
    this.pancardImage,
    this.addressImage,
    this.aadharVerified,
    this.pancardVerified,
    this.addressVerified,
    this.cibilScore,
    this.cibilDate,
    this.bankName,
    this.accountNumber,
    this.holderName,
    this.branch,
    this.ifscCode,
    this.accountType,
    this.bankAddress,
    this.memberId,
    this.memberImage,
    this.company,
    this.memberName,
    this.addressDocType,
    this.homeImage,
    this.voterId,
    this.voterIdImage,
    this.groupGroupName,
  });

  factory LoanMemberListAsPerGroupMessage.fromJson(Map<String, dynamic> json) =>
      LoanMemberListAsPerGroupMessage(
        name: json["name"]?.toString(),
        firstName: json["first_name"]?.toString(),
        lastName: json["last_name"]?.toString(),
        middleName: json["middle_name"]?.toString(),
        gender: json["gender"]?.toString(),
        dob: json["dob"] != null ? DateTime.tryParse(json["dob"]) : null,
        completedAge: json["completed_age"] as int?,
        entryAge: json["entry_age"] as int?,
        mobileNo: json["mobile_no"]?.toString(),
        state: json["state"]?.toString(),
        country: json["country"]?.toString(),
        city: json["city"]?.toString(),
        pincode: json["pincode"] as int?,
        status: json["status"]?.toString(),
        occupation: json["occupation"]?.toString(),
        group: json["group"]?.toString(),
        email: json["email"]?.toString(),
        address: json["address"]?.toString(),
        nominee: json["nominee"]?.toString(),
        relation: json["relation"]?.toString(),
        aadhar: json["aadhar"]?.toString(),
        pancard: json["pancard"]?.toString(),
        aadharImage: json["aadhar_image"]?.toString(),
        pancardImage: json["pancard_image"]?.toString(),
        addressImage: json["address_image"]?.toString(),
        aadharVerified: json["aadhar_verified"] as int?,
        pancardVerified: json["pancard_verified"] as int?,
        addressVerified: json["address_verified"] as int?,
        cibilScore: json["cibil_score"] as int?,
        cibilDate:
            json["cibil_date"] != null ? DateTime.tryParse(json["cibil_date"]) : null,
        bankName: json["bank_name"]?.toString(),
        accountNumber: json["account_number"]?.toString(),
        holderName: json["holder_name"]?.toString(),
        branch: json["branch"]?.toString(),
        ifscCode: json["ifsc_code"]?.toString(),
        accountType: json["account_type"]?.toString(),
        bankAddress: json["bank_address"]?.toString(),
        memberId: json["member_id"]?.toString(),
        memberImage: json["member_image"]?.toString(),
        company: json["company"]?.toString(),
        memberName: json["member_name"]?.toString(),
        addressDocType: json["address_doc_type"]?.toString(),
        homeImage: json["home_image"]?.toString(),
        voterId: json["voter_id"]?.toString(),
        voterIdImage: json["voter_id_image"]?.toString(),
        groupGroupName: json["group_group_name"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "gender": gender,
        "dob": dob?.toIso8601String(),
        "completed_age": completedAge,
        "entry_age": entryAge,
        "mobile_no": mobileNo,
        "state": state,
        "country": country,
        "city": city,
        "pincode": pincode,
        "status": status,
        "occupation": occupation,
        "group": group,
        "email": email,
        "address": address,
        "nominee": nominee,
        "relation": relation,
        "aadhar": aadhar,
        "pancard": pancard,
        "aadhar_image": aadharImage,
        "pancard_image": pancardImage,
        "address_image": addressImage,
        "aadhar_verified": aadharVerified,
        "pancard_verified": pancardVerified,
        "address_verified": addressVerified,
        "cibil_score": cibilScore,
        "cibil_date": cibilDate?.toIso8601String(),
        "bank_name": bankName,
        "account_number": accountNumber,
        "holder_name": holderName,
        "branch": branch,
        "ifsc_code": ifscCode,
        "account_type": accountType,
        "bank_address": bankAddress,
        "member_id": memberId,
        "member_image": memberImage,
        "company": company,
        "member_name": memberName,
        "address_doc_type": addressDocType,
        "home_image": homeImage,
        "voter_id": voterId,
        "voter_id_image": voterIdImage,
        "group_group_name": groupGroupName,
      };
}
