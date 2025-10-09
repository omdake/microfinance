import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/app.dart';

void main() async {
  App.instance.initAndRunApp(
    devMode: true,
    appLog: true,
    apiLog: false,
    setDefault: true,
    samplePayment: true,
    baseURLType: AtomURLType.PROD, 
  );
}
