import 'package:flutter/material.dart';

class Factoid extends StatelessWidget {
  const Factoid({this.fact, this.label, this.center = false});
  final String fact;
  final String label;
  final bool center;

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
            center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: <Widget>[
          Text(fact, textScaleFactor: 1.3),
          SizedBox(height: 2),
          Text(label, textScaleFactor: 0.85)
        ],
      ),
    );
  }
}
