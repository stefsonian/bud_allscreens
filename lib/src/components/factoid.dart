import 'package:flutter/material.dart';

class Factoid extends StatelessWidget {
  const Factoid({this.fact, this.label});
  final String fact;
  final String label;

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(fact, textScaleFactor: 1.2),
          SizedBox(height: 2),
          Text(label, textScaleFactor: 0.8)
        ],
      ),
    );
  }
}
