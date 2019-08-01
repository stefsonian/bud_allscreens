import 'package:flutter/material.dart';

class IkonButton extends StatelessWidget {
  const IkonButton({this.icon, this.color, this.backColor});
  final IconData icon;
  final Color color;
  final Color backColor;

  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backColor,
        boxShadow: kElevationToShadow[6],
      ),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Icon(icon, color: color),
      ),
    );
  }
}
