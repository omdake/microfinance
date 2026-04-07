import 'dart:io';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/app.dart';
import 'package:microfinance/utils/http_override.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides(); 

  App.instance.initAndRunApp(
    devMode: true,
    appLog: true,
    apiLog: false,
    setDefault: true,
    samplePayment: true,
    baseURLType: AtomURLType.PROD,
  );
}