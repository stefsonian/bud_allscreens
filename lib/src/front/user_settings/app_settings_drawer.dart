import 'package:eatsleeptravel/src/background/background.dart';
import 'package:eatsleeptravel/src/login/login_screen.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppSettingsDrawer extends StatefulWidget {
  @override
  _AppSettingsDrawerState createState() => _AppSettingsDrawerState();
}

class _AppSettingsDrawerState extends State<AppSettingsDrawer> {
  AppState appState;
  SessionData sessionData;

  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    sessionData = Provider.of<SessionData>(context);
  }

  onSignoutTap() async {
    await FirebaseAuth.instance.signOut();
    // Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Background(child: LoginScreen()),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: appState.cols.background1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Settings',
                  style: TextStyle(
                    color: appState.cols.content,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  sessionData.user.email ?? 'Not signed up',
                  style: TextStyle(
                    color: appState.cols.content,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.account_circle),
          //   title: Text('Profile'),
          // ),
          ListTile(
            leading: Icon(Icons.transit_enterexit),
            title: Text('Sign out'),
            onTap: onSignoutTap,
          ),
        ],
      ),
    );
  }
}
