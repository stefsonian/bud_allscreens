import 'package:flutter/material.dart';

class IkonButton extends StatelessWidget {
  const IkonButton(
      {this.icon, this.color, this.backColor, this.label, this.size = 80.0});
  final IconData icon;
  final Color color;
  final Color backColor;
  final double size;
  final String label;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: size,
          width: size,
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
        ),
        label == null
            ? Container()
            : Container(
                margin: EdgeInsets.only(top: 8),
                child: Text(
                  label,
                  style: TextStyle(
                    color: backColor,
                  ),
                ),
              ),
      ],
    );
  }
}
