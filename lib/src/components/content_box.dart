import 'package:flutter/material.dart';

class ContentBox extends StatelessWidget {
  const ContentBox(
      {Key key,
      this.child,
      this.color = Colors.transparent,
      this.padding = const EdgeInsets.all(14)})
      : super(key: key);
  final Widget child;
  final Color color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        // boxShadow: kElevationToShadow[1],
        border: Border.all(
          width: 1,
          color: Colors.white,
        ),
      ),
      child: child,
    );
  }
}
