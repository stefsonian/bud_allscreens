import 'package:flutter/material.dart';

class Splitter extends StatelessWidget {
  const Splitter(
      {Key key,
      this.padding,
      this.label,
      this.color = Colors.white,
      this.icon,
      this.showLine = true})
      : super(key: key);
  final EdgeInsets padding;
  final String label;
  final Color color;
  final IconData icon;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          showLine
              ? Container(
                  padding: EdgeInsets.only(bottom: 1),
                  color: color.withOpacity(0.6),
                  height: 2,
                )
              : Container(),
          Row(
            children: <Widget>[
              icon == null
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(right: 3),
                      child: Icon(
                        icon,
                        size: 12,
                        color: color.withOpacity(0.6),
                      ),
                    ),
              Text(
                label,
                style: TextStyle(
                    color: color.withOpacity(0.6),
                    fontSize: 12,
                    letterSpacing: 1.1),
              ),
            ],
          )
        ],
      ),
    );
  }
}
