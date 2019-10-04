import 'package:flutter/material.dart';

class IkonButtonExtended extends StatelessWidget {
  const IkonButtonExtended(
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
    return FloatingActionButton.extended(
      label: Text(label),
      elevation: elevation,
      icon: Icon(icon),
      backgroundColor: backColor,
      foregroundColor: color,
      onPressed: onTap,
    );
  }
}
