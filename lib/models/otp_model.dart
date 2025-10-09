class OtpModel {
  bool isVerify=false;
  bool isError=false;

  OtpModel({required this.isVerify, required this.isError});

  OtpModel.fromJson(Map<String, dynamic> json) {
    isVerify = json['isVerify'];
    isError = json['isError'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isVerify'] = this.isVerify;
    data['isError'] = this.isError;
    return data;
  }
}

