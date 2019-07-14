import 'package:flutter/material.dart';
import 'package:allscreens/src/components/gradient_box.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GradientBox(
            child: Container(
              height: 200,
              width: 200,
              child: Text('Hej'),
            ),
          ),
        ],
      ),
    );
  }
}
