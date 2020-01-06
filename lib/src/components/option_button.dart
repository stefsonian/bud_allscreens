import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  const OptionButton(
      {Key key,
      this.background,
      this.labelColor,
      this.label,
      this.icon,
      this.onTap})
      : super(key: key);

  final Color background;
  final Color labelColor;
  final String label;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    if (icon != null) {
      widgets.add(
        FittedBox(
          fit: BoxFit.fitHeight,
          child: Icon(icon, color: labelColor),
        ),
      );
    }

    if (label != null) {
      final Text _label = Text(
        label,
        style: TextStyle(
          color: labelColor,
          fontSize: 16,
        ),
      );

      if (widgets.length > 0) widgets.add(SizedBox(width: 8));
      widgets.add(_label);
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: background,
            boxShadow: kElevationToShadow[4],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgets,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
