import 'package:flutter/material.dart';
import '../helpers/colors.dart';

class Numpad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
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
          SizedBox(height: screenHeight > 850 ? 18 : 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _NumpadButton(label: '4'),
              _NumpadButton(label: '5'),
              _NumpadButton(label: '6'),
            ],
          ),
          SizedBox(height: screenHeight > 850 ? 18 : 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _NumpadButton(label: '1'),
              _NumpadButton(label: '2'),
              _NumpadButton(label: '3'),
            ],
          ),
          SizedBox(height: screenHeight > 850 ? 18 : 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _NumpadButton(label: '0'),
              _NumpadButton(label: '.'),
              _NumpadButton(label: 'C'),
            ],
          ),
          SizedBox(height: 2),
        ],
      ),
    );
  }
}

class _NumpadButton extends StatelessWidget {
  const _NumpadButton({this.label});
  final String label;

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight > 850 ? 66 : 60,
      width: screenHeight > 850 ? 66 : 60,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        child: Text(label, textScaleFactor: 3),
      ),
    );
  }
}
