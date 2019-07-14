import 'package:flutter/material.dart';
import 'package:allscreens/src/helpers/colors.dart';

class GradientBox extends StatelessWidget {
  const GradientBox({this.child, this.col1 = col_box1, this.col2 = col_box2});
  final Widget child;
  final Color col1;
  final Color col2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1],
          colors: [col_box1, col_box2],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.all(30),
      child: child,
    );
  }
}
