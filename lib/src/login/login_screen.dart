import 'package:eatsleeptravel/src/navigation/login_nav.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    appState.viewHeight = MediaQuery.of(context).size.height;
    appState.viewWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(20),
      child: LoginNav(),
    );
  }
}
