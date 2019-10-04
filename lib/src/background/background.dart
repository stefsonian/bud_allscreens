import 'package:flutter/material.dart';
import 'package:allscreens/src/helpers/colors.dart';

class Background extends StatelessWidget {
  const Background({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1],
          colors: [col_aqua, col_aqua_lighter],
          // colors: [col_aqua_lighter, col_aqua],
        ),
      ),
      // color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: child,
    );
  }
}
