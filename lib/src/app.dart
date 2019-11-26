import 'package:allscreens/src/login/login_screen.dart';
import 'package:allscreens/src/navigation/bottom_nav.dart';
import 'package:allscreens/src/services/records.dart';
import 'package:allscreens/src/services/home_state.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:allscreens/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:allscreens/src/background/background.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'helpers/colors.dart';

class App extends StatelessWidget {
  final appState = AppState();
  var appStateStream = Stream.fromIterable([AppState()]);
  final records = Records();
  final sessionData = SessionData();

  @override
  Widget build(BuildContext context) {
    records
        .createTestData(30); // TODO: Only for testing. Remove before release.
    FlutterStatusbarcolor.setStatusBarColor(col_aqua.withOpacity(1.0));
    FlutterStatusbarcolor.setNavigationBarColor(col_aqua);
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
