import 'package:eatsleeptravel/src/login/login_screen.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eatsleeptravel/src/background/background.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class App extends StatelessWidget {
  final appState = AppState();
  final sessionData = SessionData();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setNavigationBarColor(appState.cols.background2);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>.value(
          value: appState,
        ),
        ChangeNotifierProvider<SessionData>.value(
          value: sessionData,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eatsleeptravel',
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
