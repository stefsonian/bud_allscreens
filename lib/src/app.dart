import 'package:eatsleeptravel/src/login/login_screen.dart';
import 'package:eatsleeptravel/src/navigation/bottom_nav.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/home_state.dart';
import 'package:eatsleeptravel/src/services/record_state.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eatsleeptravel/src/background/background.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'helpers/colors.dart';

class App extends StatelessWidget {
  final appState = AppState();
  var appStateStream = Stream.fromIterable([AppState()]);
  final records = Records();
  final sessionData = SessionData();

  @override
  Widget build(BuildContext context) {
    if (records.full.length == 0) {
      records.createTestData(
          90, 30, 60); // TODO: Only for testing. Remove before release.
    }
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setNavigationBarColor(appState.cols.background2);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>.value(
          value: appState,
        ),
        ChangeNotifierProvider<RecordState>.value(
          value: RecordState(),
        ),
        ChangeNotifierProvider<HomeState>.value(
          value: HomeState(),
        ),
        ChangeNotifierProvider<SessionData>.value(
          value: sessionData,
        ),
        ChangeNotifierProvider<Records>.value(
          value: records,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          extendBody: true,
          body: Container(
            // color: Colors.white70,
            // child: Background(child: BottomNav()),
            child: Background(child: LoginScreen()),
          ),
        ),
      ),
    );
  }
}
