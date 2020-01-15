import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class TaperedDividerH extends StatelessWidget {
  const TaperedDividerH({
    Key key,
    this.color1 = Colors.white70,
    this.color2 = col_main4,
    this.thickness = 2.0,
  }) : super(key: key);

  final Color color1;
  final Color color2;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: thickness,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color2, color1, color1, color2],
          stops: [0.0, 0.2, 0.8, 1.0],
        ),
      ),
    );
  }
}
