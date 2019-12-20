import 'package:allscreens/src/components/animated_spacer.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class BudgetBar extends StatefulWidget {
  const BudgetBar(
      {Key key, this.heightPct, this.ratioOver, this.label, this.value})
      : super(key: key);

  final int heightPct;
  final double ratioOver;
  final String label;
  final String value;

  @override
  _BudgetBarState createState() => _BudgetBarState();
}

class _BudgetBarState extends State<BudgetBar> {
  @override
  Widget build(BuildContext context) {
    final Color color = widget.ratioOver > 0 ? col_main2 : col_main4;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        AnimatedSpacer(begin: 1000, end: 101 - widget.heightPct),
        Container(
          margin: EdgeInsets.only(bottom: 6),
          child: Text(
            '\$${widget.value}',
            style: TextStyle(
              fontSize: 11,
            ),
          ),
        ),
        Expanded(
          flex: widget.heightPct,
          child: Container(
            width: 45,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 1],
                colors: [color.withOpacity(0.8), color],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 6),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}
