class LoanMemberList {
  List<LoanMemberListMessage>? message;

  LoanMemberList({
    this.message,
  });

  factory LoanMemberList.fromJson(Map<String, dynamic> json) => LoanMemberList(
        message: List<LoanMemberListMessage>.from(
            json["message"].map((x) => LoanMemberListMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class LoanMemberListMessage {
  int? count;
  String? next;
  dynamic previous;
  List<LoanMemberListResult>? results;

  LoanMemberListMessage({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory LoanMemberListMessage.fromJson(Map<String, dynamic> json) =>
      LoanMemberListMessage(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<LoanMemberListResult>.from(
            json["results"].map((x) => LoanMemberListResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class LoanMemberListResult {
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
  dynamic nominee;
  String? relation;
  dynamic aadhar;
  dynamic pancard;
  dynamic aadharImage;
  dynamic pancardImage;
  dynamic addressImage;
  int? aadharVerified;
  int? pancardVerified;
  int? addressVerified;
  int? cibilScore;
  String? createdBy;
  dynamic cibilDate;
  dynamic bankName;
  dynamic accountNumber;
  dynamic holderName;
  dynamic branch;
  dynamic ifscCode;
  String? accountType;
  dynamic bankAddress;
  String? memberId;
  dynamic memberImage;
  String? company;
  String? memberName;
  String? addressDocType;
  dynamic homeImage;
  dynamic voterId;
  dynamic voterIdImage;
  dynamic aadharImageBack;
  dynamic pancardImageBack;
  dynamic voterIdImageBack;
  dynamic addressLine2;
  String? mobileNoLine2;
  String? groupGroupName;
  double? longitude;
  double? latitude;
  dynamic geoLocation;
  String? consumerNo;
  dynamic passbookImage1;
  dynamic passbookImage2;

  LoanMemberListResult({
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
    this.aadharImageBack,
    this.pancardImageBack,
    this.voterIdImageBack,
    this.addressLine2,
    this.mobileNoLine2,
    this.groupGroupName,
    this.longitude,
    this.latitude,
    this.geoLocation,
    this.createdBy,
    this.consumerNo,
    this.passbookImage1,
    this.passbookImage2,
  });

  factory LoanMemberListResult.fromJson(Map<String, dynamic> json) =>
      LoanMemberListResult(
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        gender: json["gender"],
        dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
        completedAge: json["completed_age"],
        entryAge: json["entry_age"],
        mobileNo: json["mobile_no"],
        state: json["state"],
        country: json["country"],
        city: json["city"],
        pincode: json["pincode"],
        status: json["status"],
        occupation: json["occupation"],
        group: json["group"],
        email: json["email"],
        createdBy: json["created_by"],
        address: json["address"],
        nominee: json["nominee"],
        relation: json["relation"],
        aadhar: json["aadhar"],
        pancard: json["pancard"],
        aadharImage: json["aadhar_image"],
        pancardImage: json["pancard_image"],
        addressImage: json["address_image"],
        aadharVerified: json["aadhar_verified"],
        pancardVerified: json["pancard_verified"],
        addressVerified: json["address_verified"],
        cibilScore: json["cibil_score"],
        cibilDate: json["cibil_date"],
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        holderName: json["holder_name"],
        branch: json["branch"],
        ifscCode: json["ifsc_code"],
        accountType: json["account_type"],
        bankAddress: json["bank_address"],
        memberId: json["member_id"],
        memberImage: json["member_image"],
        company: json["company"],
        memberName: json["member_name"],
        addressDocType: json["address_doc_type"],
        homeImage: json["home_image"],
        voterId: json["voter_id"],
        voterIdImage: json["voter_id_image"],
        aadharImageBack: json["aadhar_image_back"],
        pancardImageBack: json["pancard_image_back"],
        voterIdImageBack: json["voter_id_image_back"],
        addressLine2: json["address_line_2"],
        mobileNoLine2: json["mobile_no_2"],
        groupGroupName: json["group_group_name"],
        geoLocation: json["geo_location"],
        longitude: json["longitude"] != null
            ? (json["longitude"] is int
                ? (json["longitude"] as int).toDouble()
                : json["longitude"] as double)
            : null,
        latitude: json["latitude"] != null
            ? (json["latitude"] is int
                ? (json["latitude"] as int).toDouble()
                : json["latitude"] as double)
            : null,
        consumerNo: json["consumer_no"],
        passbookImage1: json["passbook_image"],
        passbookImage2: json["passbook_image_2"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "gender": gender,
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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
        "cibil_date": cibilDate,
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
        "aadhar_image_back": aadharImageBack,
        "pancard_image_back": pancardImageBack,
        "voter_id_image_back": voterIdImageBack,
        "address_line_2": addressLine2,
        "mobile_no_2": mobileNoLine2,
        "longitude": longitude,
        "latitude": latitude,
        "geo_location": geoLocation,
        "created_by": createdBy,
        "consumer_no": consumerNo,
        "passbook_image": passbookImage1,
        "passbook_image_2": passbookImage2,
      };
}

class LoanMemberDropdownList {
  List<LoanMemberDropdownListMessage>? message;

  LoanMemberDropdownList({
    this.message,
  });

  factory LoanMemberDropdownList.fromJson(Map<String, dynamic> json) =>
      LoanMemberDropdownList(
        message: List<LoanMemberDropdownListMessage>.from(json["message"]
            .map((x) => LoanMemberDropdownListMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class LoanMemberDropdownListMessage {
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
  dynamic nominee;
  String? relation;
  dynamic aadhar;
  dynamic pancard;
  dynamic aadharImage;
  dynamic pancardImage;
  dynamic addressImage;
  int? aadharVerified;
  int? pancardVerified;
  int? addressVerified;
  int? cibilScore;
  dynamic cibilDate;
  dynamic bankName;
  dynamic accountNumber;
  dynamic holderName;
  dynamic branch;
  dynamic ifscCode;
  String? accountType;
  dynamic bankAddress;
  String? memberId;
  dynamic memberImage;
  String? company;
  String? memberName;
  String? addressDocType;
  dynamic homeImage;
  dynamic voterId;
  dynamic voterIdImage;
  String? groupGroupName;

  LoanMemberDropdownListMessage({
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

  factory LoanMemberDropdownListMessage.fromJson(Map<String, dynamic> json) =>
      LoanMemberDropdownListMessage(
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        completedAge: json["completed_age"],
        entryAge: json["entry_age"],
        mobileNo: json["mobile_no"],
        state: json["state"],
        country: json["country"],
        city: json["city"],
        pincode: json["pincode"],
        status: json["status"],
        occupation: json["occupation"],
        group: json["group"],
        email: json["email"],
        address: json["address"],
        nominee: json["nominee"],
        relation: json["relation"],
        aadhar: json["aadhar"],
        pancard: json["pancard"],
        aadharImage: json["aadhar_image"],
        pancardImage: json["pancard_image"],
        addressImage: json["address_image"],
        aadharVerified: json["aadhar_verified"],
        pancardVerified: json["pancard_verified"],
        addressVerified: json["address_verified"],
        cibilScore: json["cibil_score"],
        cibilDate: json["cibil_date"],
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        holderName: json["holder_name"],
        branch: json["branch"],
        ifscCode: json["ifsc_code"],
        accountType: json["account_type"],
        bankAddress: json["bank_address"],
        memberId: json["member_id"],
        memberImage: json["member_image"],
        company: json["company"],
        memberName: json["member_name"],
        addressDocType: json["address_doc_type"],
        homeImage: json["home_image"],
        voterId: json["voter_id"],
        voterIdImage: json["voter_id_image"],
        groupGroupName: json["group_group_name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "gender": gender,
        "dob": dob,
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
        "cibil_date":
            "${cibilDate.year.toString().padLeft(4, '0')}-${cibilDate.month.toString().padLeft(2, '0')}-${cibilDate.day.toString().padLeft(2, '0')}",
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
