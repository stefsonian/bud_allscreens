import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class RecordStepper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(left: 110),
      decoration: BoxDecoration(
        color: col_aqua_dark2,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: kElevationToShadow[16],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RecordStep(icon: Icons.dialpad, isComplete: true),
          Icon(Icons.arrow_forward, color: Colors.grey),
          RecordStep(icon: Icons.bubble_chart, isComplete: false),
          Icon(Icons.arrow_forward, color: Colors.grey),
          RecordStep(icon: Icons.check, isComplete: false),
        ],
      ),
    );
  }
}

class RecordStep extends StatelessWidget {
  const RecordStep({Key key, this.icon, this.isComplete}) : super(key: key);
  final IconData icon;
  final bool isComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: 52,
      decoration: BoxDecoration(
        color: isComplete ? col_aqua_light : Colors.grey,
        borderRadius: BorderRadius.circular(25),
        // border: Border.all(color: Colors.white70, width: 2),
        // boxShadow: kElevationToShadow[1],
      ),
      child: Icon(
        icon,
        color: isComplete ? Colors.white : Colors.white70,
      ),
    );
  }
}
