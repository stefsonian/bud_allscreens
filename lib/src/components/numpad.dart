import 'package:flutter/material.dart';
import '../helpers/colors.dart';

class Numpad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _NumpadButton(label: '7'),
              _NumpadButton(label: '8'),
              _NumpadButton(label: '9'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _NumpadButton(label: '4'),
              _NumpadButton(label: '5'),
              _NumpadButton(label: '6'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _NumpadButton(label: '1'),
              _NumpadButton(label: '2'),
              _NumpadButton(label: '3'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _NumpadButton(label: '0'),
              _NumpadButton(label: '.'),
              _NumpadButton(label: 'C'),
            ],
          ),
        ],
      ),
    );
  }
}

class _NumpadButton extends StatelessWidget {
  const _NumpadButton({this.label});
  final String label;

  Widget build(BuildContext context) {
    return SizedBox(
      height: 66,
      width: 66,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: col_background1,
        foregroundColor: col_box2,
        child: Text(label, textScaleFactor: 2),
      ),
    );
  }
}
