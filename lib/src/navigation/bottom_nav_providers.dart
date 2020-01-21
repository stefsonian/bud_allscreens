import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/home_state.dart';
import 'package:eatsleeptravel/src/services/record_state.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:provider/provider.dart';

class BottomNavProviders extends StatefulWidget {
  const BottomNavProviders(
      {Key key, this.child, this.appState, this.user, this.sessionData})
      : super(key: key);
  final Widget child;
  final AppState appState;
  final SessionData sessionData;
  final FirebaseUser user;

  @override
  _BottomNavProvidersState createState() => _BottomNavProvidersState();
}

class _BottomNavProvidersState extends State<BottomNavProviders> {
  final records = Records();
  // final appState =
  final sessionData = SessionData();

  Widget build(BuildContext context) {
    sessionData.initialiseUserFromFirebaseUser(widget.user);
    sessionData.initialiseTrips();
    sessionData.initialiseUserCurrentTrip();

    if (records.full.length == 0) {
      records.createTestData(
          90, 30, 60); // TODO: Only for testing. Remove before release.
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>.value(
          value: widget.appState,
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
      child: widget.child,
    );
  }
}
