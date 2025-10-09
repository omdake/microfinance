import 'package:microfinance/utils/extension/extension/app_extensions.dart';

class CustCardDetails {
  String? clientPaymentMethodID;
  String? clientID;
  String? stripeClientID;
  String? stripePaymentMethodID;
  String? issuer;
  String? cardEndingwith;
  String? pGReferenceID;
  String? pGReferenceID1;
  String? pGReferenceID2;
  String? clientName;
  String? cardImage;

  CustCardDetails(
      {this.clientPaymentMethodID,
      this.clientID,
      this.stripeClientID,
      this.stripePaymentMethodID,
      this.issuer,
      this.cardEndingwith,
      this.pGReferenceID,
      this.pGReferenceID1,
      this.pGReferenceID2,
      this.clientName,
      this.cardImage});

  factory CustCardDetails.empty() => CustCardDetails(
        clientPaymentMethodID: defaultString,
        clientID: defaultString,
        stripeClientID: defaultString,
        stripePaymentMethodID: defaultString,
        issuer: defaultString,
        cardEndingwith: defaultString,
        pGReferenceID: defaultString,
        pGReferenceID1: defaultString,
        pGReferenceID2: defaultString,
        clientName: defaultString,
        cardImage: defaultString,
      );

  CustCardDetails.fromJson(Map<String, dynamic> json) {
    clientPaymentMethodID = json['ClientPaymentMethodID'];
    clientID = json['ClientID'];
    stripeClientID = json['StripeClientID'];
    stripePaymentMethodID = json['StripePaymentMethodID'];
    issuer = json['Issuer'];
    cardEndingwith = json['CardEndingwith'];
    pGReferenceID = json['PGReferenceID'];
    pGReferenceID1 = json['PGReferenceID_1'];
    pGReferenceID2 = json['PGReferenceID_2'];
    clientName = json['ClientName'];
    cardImage = json['CardIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClientPaymentMethodID'] = this.clientPaymentMethodID;
    data['ClientID'] = this.clientID;
    data['StripeClientID'] = this.stripeClientID;
    data['StripePaymentMethodID'] = this.stripePaymentMethodID;
    data['Issuer'] = this.issuer;
    data['CardEndingwith'] = this.cardEndingwith;
    data['PGReferenceID'] = this.pGReferenceID;
    data['PGReferenceID_1'] = this.pGReferenceID1;
    data['PGReferenceID_2'] = this.pGReferenceID2;
    data['ClientName'] = this.clientName;
    data['CardIcon'] = this.cardImage;
    return data;
  }
}
