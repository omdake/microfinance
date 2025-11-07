// // import 'package:after_layout/after_layout.dart';
// import 'package:microfinance/api/app_envirments.dart';
// import 'package:microfinance/api/dev/dev_service.dart';
// import 'package:microfinance/app.dart';
// import 'package:microfinance/common_widgets/custom_app_bar.dart';
// import 'package:microfinance/themes/app_colors.dart';
// import 'package:microfinance/themes/app_textstyles.dart';
// import 'package:microfinance/utils/date_time.dart';
// import 'package:microfinance/utils/extension/extension/map_extensions.dart';
// import 'package:microfinance/utils/sizes.dart';
// import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
// import 'package:microfinance/utils/ui_helper.dart/label_value_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../common_widgets/screen_wrapper.dart';

// class DevScreen extends StatefulWidget {
//   @override
//   _DevScreenState createState() => _DevScreenState();
// }

// class _DevScreenState extends State<DevScreen>
//     with ScreenWrapperMixin<DevScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: appBarWithTitle(title: "Dev Options", actions: [
//         IconButton(
//             icon: Icon(
//               Icons.refresh,
//             ),
//             onPressed: () {
//               setState(() {});
//             })
//       ]),
//       body: LoaderWrapper(
//         child: ListView(
//           children: <Widget>[
//             LabelValueEndWidget(
//               label: 'BASE URL TYPE',
//               value: App.instance.baseURLType,
//             ),
//             InkWell(
//               onTap: () {
//                 copyToClipBoard(value: DevService.instance.appSignature);
//               },
//               child: LabelValueEndWidget(
//                 label: 'APP SIGNATURE',
//                 value: DevService.instance.appSignature,
//               ),
//             ),
//             LabelValueEndWidget(
//               label: 'BASE URL',
//               value: AppEnvironment.baseUrl,
//             ),
//             // HeaderPostfixWidget(title: "Last 25 API Calls"),
//             ExpansionPanelList.radio(
//               children: <ExpansionPanel>[
//                 ...DevService.instance.apiCalls
//                     .map(
//                       (apiCall) => ExpansionPanelRadio(
//                         value: apiCall.id,
//                         headerBuilder: (_, isExpanded) {
//                           return ListTile(
//                             title: Text(
//                               apiCall.path,
//                               style: TextStyles.defaultMedium,
//                             ),
//                             subtitle: Text(
//                                 '${apiCall.type} @ ${AppDateTime.formatDateFromDateTime(
//                               format: DateFormats.inTimeDate,
//                               dateTime: apiCall.dateTime,
//                             )}'),
//                             trailing: InkWell(
//                                 onTap: () {
//                                   copyToClipBoard(
//                                       value:
//                                           '${AppEnvironment.baseUrl}${apiCall.path}\n Request Body \n${apiCall.data.toPretty()}\n Responses body \n${apiCall.response.toPretty()}');
//                                 },
//                                 child: Icon(Icons.copy)),
//                           );
//                         },
//                         body: GestureDetector(
//                           onLongPress: () {
//                             copyToClipBoard(
//                                 value:
//                                     '\n${AppEnvironment.baseUrl}${apiCall.path}\n${apiCall.data.toPretty()}\n\n\n${apiCall.response.toPretty()}');
//                           },
//                           child: Container(
//                             padding: EdgeInsets.all(Sizes.s10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 SelectableText(
//                                   'Request data : ${apiCall.data.toPretty()}}',
//                                   showCursor: true,
//                                   selectionControls:
//                                       MaterialTextSelectionControls(),
//                                   cursorColor: Colors.pink,
//                                   strutStyle: StrutStyle.fromTextStyle(
//                                       TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: AppColors.pinkishGrey)),
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: AppColors.primary,
//                                       fontSize: 10),
//                                 ),
//                                 Text(
//                                   'Response Data ${apiCall.response.toPretty()}',
//                                   style: TextStyles.smallLabel.copyWith(
//                                     color: Colors.deepOrange,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                     .toList()
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Future<Null> copyToClipBoard({
//     required String value,
//   }) async {
//     await Clipboard.setData(
//       ClipboardData(text: value),
//     );

//     AppTostMassage.showTostMassage(massage: 'Value copied to Clipboard');
//   }
// }
// import 'package:after_layout/after_layout.dart';
import 'package:microfinance/api/app_envirments.dart';
import 'package:microfinance/api/dev/dev_service.dart';
import 'package:microfinance/app.dart';
import 'package:microfinance/common_widgets/custom_app_bar.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:microfinance/themes/app_textstyles.dart';
import 'package:microfinance/utils/date_time.dart';
import 'package:microfinance/utils/sizes.dart';
import 'package:microfinance/utils/ui_helper.dart/app_tost.dart';
import 'package:microfinance/utils/ui_helper.dart/label_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../common_widgets/screen_wrapper.dart';
import 'dart:convert';

class DevScreen extends StatefulWidget {
  @override
  _DevScreenState createState() => _DevScreenState();
}

class _DevScreenState extends State<DevScreen>
    with ScreenWrapperMixin<DevScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBarWithTitle(title: "Dev Options", actions: [
        IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            })
      ]),
      body: LoaderWrapper(
        child: ListView(
          children: <Widget>[
            LabelValueEndWidget(
              label: 'BASE URL TYPE',
              value: App.instance.baseURLType,
            ),
            InkWell(
              onTap: () {
                copyToClipBoard(value: DevService.instance.appSignature);
              },
              child: LabelValueEndWidget(
                label: 'APP SIGNATURE',
                value: DevService.instance.appSignature,
              ),
            ),
            LabelValueEndWidget(
              label: 'BASE URL',
              value: AppEnvironment.baseUrl,
            ),
            ExpansionPanelList.radio(
              children: DevService.instance.apiCalls.map(
                (apiCall) {
                  return ExpansionPanelRadio(
                    value: apiCall.id,
                    headerBuilder: (_, isExpanded) {
                      return ListTile(
                        title: Text(apiCall.path, style: TextStyles.defaultMedium),
                        subtitle: Text(
                          '${apiCall.type} @ ${AppDateTime.formatDateFromDateTime(
                            format: DateFormats.inTimeDate,
                            dateTime: apiCall.dateTime,
                          )}',
                        ),
                        trailing: InkWell(
                          onTap: () {
                            copyToClipBoard(
                              value:
                                  '${AppEnvironment.baseUrl}${apiCall.path}\nRequest Body:\n${prettyPrint(apiCall.data)}\nResponse Body:\n${prettyPrint(apiCall.response)}',
                            );
                          },
                          child: Icon(Icons.copy),
                        ),
                      );
                    },
                    body: GestureDetector(
                      onLongPress: () {
                        copyToClipBoard(
                          value:
                              '${AppEnvironment.baseUrl}${apiCall.path}\nRequest Body:\n${prettyPrint(apiCall.data)}\nResponse Body:\n${prettyPrint(apiCall.response)}',
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(Sizes.s10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SelectableText(
                              'Request Data: ${prettyPrint(apiCall.data)}',
                              showCursor: true,
                              selectionControls: MaterialTextSelectionControls(),
                              cursorColor: Colors.pink,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              'Response Data: ${prettyPrint(apiCall.response)}',
                              style: TextStyles.smallLabel.copyWith(
                                color: Colors.deepOrange,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            )
          ],
        ),
      ),
    );
  }

  String prettyPrint(dynamic data) {
    if (data == null) return 'null';
    if (data is Map || data is List) {
      return const JsonEncoder.withIndent('  ').convert(data);
    }
    return data.toString();
  }

  Future<void> copyToClipBoard({required String value}) async {
    await Clipboard.setData(ClipboardData(text: value));
    AppTostMassage.showTostMassage(massage: 'Value copied to Clipboard');
  }
}
