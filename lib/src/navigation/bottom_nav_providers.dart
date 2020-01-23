import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/home_state.dart';
import 'package:eatsleeptravel/src/services/record_state.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:provider/provider.dart';

class BottomNavProviders extends StatefulWidget {
  const BottomNavProviders({Key key, this.child, this.user}) : super(key: key);
  final Widget child;
  final FirebaseUser user;

  @override
  _BottomNavProvidersState createState() => _BottomNavProvidersState();
}

class _BottomNavProvidersState extends State<BottomNavProviders> {
  final records = Records();
  AppState appState;
  SessionData sessionData;

  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    sessionData = Provider.of<SessionData>(context);
  }

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RecordState>.value(
          value: RecordState(),
        ),
        ChangeNotifierProvider<HomeState>.value(
          value: HomeState(),
        ),
        ChangeNotifierProvider<Records>.value(
          value: records,
        ),
      ],
      child: widget.child,
    );
  }
}
