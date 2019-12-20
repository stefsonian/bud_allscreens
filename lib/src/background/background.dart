import 'package:allscreens/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:provider/provider.dart';

class Background extends StatelessWidget {
  const Background({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 1],
          colors: [appState.cols.background1, appState.cols.background2],
          // colors: [col_aqua_lighter, col_aqua],
        ),
        // color: col_primary,
      ),
      // color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: child,
    );
  }
}
