import 'package:allscreens/src/background/background.dart';
import 'package:allscreens/src/components/chart_bar_vertical.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/navigation/bottom_nav.dart';
import 'package:allscreens/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  _onPressedHandler(SessionData sd, BuildContext context) async {
    await sd.initialiseUser();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Background(child: BottomNav())));
  }

  @override
  Widget build(BuildContext context) {
    SessionData sessionData = Provider.of<SessionData>(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton.extended(
            label: Text(
              'Log in',
              style: TextStyle(color: col_aqua),
            ),
            icon: Icon(Icons.person, color: col_aqua),
            backgroundColor: Colors.white,
            heroTag: 'Log in',
            onPressed: () => _onPressedHandler(sessionData, context),
          ),
        ],
      ),
    );
  }
}
