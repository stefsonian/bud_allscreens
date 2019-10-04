import 'package:flutter/material.dart';

class IkonButton extends StatelessWidget {
  const IkonButton(
      {this.icon,
      this.color,
      this.backColor,
      this.label,
      this.size = 80.0,
      this.elevation = 6.0,
      this.onTap});
  final IconData icon;
  final Color color;
  final Color backColor;
  final double size;
  final String label;
  final Function onTap;
  final double elevation;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: size,
          width: size,
          child: FittedBox(
            fit: BoxFit.fill,
            child: FloatingActionButton(
              elevation: elevation,
              child: FractionallySizedBox(
                heightFactor: 0.6,
                widthFactor: 0.6,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(icon),
                ),
              ),
              backgroundColor: backColor,
              foregroundColor: color,
              onPressed: onTap,
            ),
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
