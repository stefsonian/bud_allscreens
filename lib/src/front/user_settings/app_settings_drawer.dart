import 'package:eatsleeptravel/src/background/background.dart';
import 'package:eatsleeptravel/src/front/user_settings/set_home_currency.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/login/login_screen.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/firestore_service.dart';
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

  onSetHomeCurrencyTap() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            children: <Widget>[SetHomeCurrency()],
          );
        });
  }

  onEditExchangeRatesTap() {}

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

  onDevScriptTap() async {
    // Utils().fixFirestoreCurrencies();
    var firestore = FirestoreService();
    // firestore.setUserCurrencyValue(
    //   userId: sessionData.user.id,
    //   currencyId: 'NOK',
    // );

    await firestore.setUserHomeCurrency(
      userId: sessionData.user.id,
      currencyId: 'aud',
    );

    firestore.resetUserCurrencyValues(
      userId: sessionData.user.id,
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
            leading: Icon(Icons.flag),
            title: Text('Set home currency'),
            onTap: onSetHomeCurrencyTap,
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('Edit exchange rates'),
            onTap: onEditExchangeRatesTap,
          ),
          ListTile(
            leading: Icon(Icons.transit_enterexit),
            title: Text('Sign out'),
            onTap: onSignoutTap,
          ),
          ListTile(
            leading: Icon(Icons.developer_mode),
            title: Text('script: fix firestore cur'),
            onTap: onDevScriptTap,
          ),
        ],
      ),
    );
  }
}
