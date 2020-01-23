import 'package:eatsleeptravel/src/navigation/bottom_nav.dart';
import 'package:eatsleeptravel/src/navigation/login_nav.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PathSelector extends StatelessWidget {
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    if (appState.onLoginPath) return LoginNav();
    if (!appState.onLoginPath) return BottomNav();
    return Container();
  }
}
