import 'package:eatsleeptravel/src/background/background.dart';
import 'package:eatsleeptravel/src/components/chart_bar_vertical.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/login/login_user.dart';
import 'package:eatsleeptravel/src/login/register_user.dart';
import 'package:eatsleeptravel/src/navigation/bottom_nav.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
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
    AppState appState = Provider.of<AppState>(context);
    SessionData sessionData = Provider.of<SessionData>(context);
    appState.viewWidth = MediaQuery.of(context).size.width;
    appState.viewHeight = MediaQuery.of(context).size.height;
    print(
        'View width: ${appState.viewWidth}  |  View height: ${appState.viewHeight}');
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(30),
        height: double.infinity,
        width: double.infinity,
        child: appState.loginStage == 'sign in' ? LoginUser() : RegisterUser(),
      ),
    );
  }
}
