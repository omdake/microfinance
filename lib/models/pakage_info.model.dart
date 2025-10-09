class PackageInfo {
  String? packageName;
  String? version;
  String? buildNumber;

  PackageInfo({this.packageName, this.version, this.buildNumber});

  PackageInfo.fromJson(Map<String, dynamic> json) {
    packageName = json['packageName'];
    version = json['version'];
    buildNumber = json['buildNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packageName'] = this.packageName;
    data['version'] = this.version;
    data['buildNumber'] = this.buildNumber;
    return data;
  }
}