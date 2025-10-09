import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/app.dart';

void main() async {
  App.instance.initAndRunApp(
    devMode: false,
    appLog: false,
    apiLog: false,
    setDefault: true,
    samplePayment: true,
    baseURLType: AtomURLType.PROD,
  );
}
