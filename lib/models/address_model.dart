import 'package:microfinance/utils/extension/extension/map_extensions.dart';

class AdddressDetails {
  String? clientAddressID;
  String? clientID;
  String? address1;
  String? address2;
  String? address3;
  String? zipCodeID;
  String? cityID;
  String? deliveryInstructions;
  bool? isDefaultAddress;
  String? createdON;
  dynamic updatedON;
  String? cityName;
  String? isActive;
  String? clientName;
  String? stateID;
  String? zipCode;

  factory AdddressDetails.empty() => AdddressDetails(
        clientAddressID: defaultString,
        clientID: defaultString,
        address1: defaultString,
        address2: defaultString,
        address3: defaultString,
        zipCodeID: defaultString,
        cityID: defaultString,
        deliveryInstructions: defaultString,
        createdON: defaultString,
        cityName: defaultString,
        isActive: defaultString,
        clientName: defaultString,
        stateID: defaultString,
        zipCode: defaultString,
      );

  AdddressDetails(
      {this.clientAddressID,
      this.clientID,
      this.address1,
      this.address2,
      this.address3,
      this.zipCodeID,
      this.cityID,
      this.deliveryInstructions,
      this.isDefaultAddress,
      this.createdON,
      this.updatedON,
      this.cityName,
      this.isActive,
      this.clientName,
      this.stateID,
      this.zipCode});

  AdddressDetails.fromJson(Map<String, dynamic> json) {
    clientAddressID = json['ClientAddressID'];
    clientID = json['ClientID'];
    address1 = json['Address1'];
    address2 = json['Address2'];
    address3 = json['Address3'];
    zipCodeID = json['ZipCodeID'];
    cityID = json['CityID'];
    deliveryInstructions = json['DeliveryInstructions'];
    isDefaultAddress = json['IsDefaultAddress'];
    createdON = json['CreatedON'];
    updatedON = json['UpdatedON'];
    cityName = json['CityName'];
    isActive = json['IsActive'];
    clientName = json['ClientName'];
    stateID = json['StateID'];
    zipCode = json['ZipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClientAddressID'] = this.clientAddressID;
    data['ClientID'] = this.clientID;
    data['Address1'] = this.address1;
    data['Address2'] = this.address2;
    data['Address3'] = this.address3;
    data['ZipCodeID'] = this.zipCodeID;
    data['CityID'] = this.cityID;
    data['DeliveryInstructions'] = this.deliveryInstructions;
    data['IsDefaultAddress'] = this.isDefaultAddress;
    data['CreatedON'] = this.createdON;
    data['UpdatedON'] = this.updatedON;
    data['CityName'] = this.cityName;
    data['IsActive'] = this.isActive;
    data['ClientName'] = this.clientName;
    data['StateID'] = this.stateID;
    data['ZipCode'] = this.zipCode;
    return data;
  }
}
