import 'package:flutter/material.dart';
import 'package:allscreens/src/helpers/colors.dart';

class GradientBoxSimple extends StatelessWidget {
  const GradientBoxSimple(
      {this.child, this.col1 = col_box1, this.col2 = col_box2});
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
          colors: [col1, col2],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(1, 1),
            blurRadius: 0,
          )
        ],
      ),
      padding: EdgeInsets.fromLTRB(18, 10, 18, 12),
      child: child,
    );
  }
}
