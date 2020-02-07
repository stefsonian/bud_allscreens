import 'package:eatsleeptravel/src/login/login_screen.dart';
import 'package:eatsleeptravel/src/navigation/bottom_nav.dart';
import 'package:eatsleeptravel/src/navigation/bottom_nav_providers.dart';
import 'package:eatsleeptravel/src/navigation/login_nav.dart';
import 'package:eatsleeptravel/src/navigation/path_selector.dart';
import 'package:eatsleeptravel/src/services/home_state.dart';
import 'package:eatsleeptravel/src/services/record_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eatsleeptravel/src/background/background.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class App extends StatelessWidget {
  final appState = AppState();
  final sessionData = SessionData();
  final records = Records();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setNavigationBarColor(appState.cols.background2);
    records.initialiseCurrencies();
    records.initialiseExchangeRates();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>.value(
          value: appState,
        ),
        ChangeNotifierProvider<SessionData>.value(
          value: sessionData,
        ),
        ChangeNotifierProvider<RecordState>.value(
          value: RecordState(),
        ),
        ChangeNotifierProvider<HomeState>.value(
          value: HomeState(),
        ),
        ChangeNotifierProvider<Records>.value(
          value: records,
        ),
// ChangeNotifierProxyProvider<SessionData, Records>(
//   create: (_) => records,
//   update: (_, sd, r) {
//     r.user = sd.user;
//     return r;
//     }
// );
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eatsleeptravel',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          drawerEdgeDragWidth: 0,
          extendBody: true,
          body: Container(
            // color: Colors.white70,
            child: Background(child: PathSelector()),
          ),
        ),
      ),
    );
  }
}
