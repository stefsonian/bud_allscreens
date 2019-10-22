import 'package:allscreens/src/components/animated_spacer.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class BudgetBarHoriz extends StatefulWidget {
  const BudgetBarHoriz(
      {Key key,
      this.widthPct,
      this.ratioOver,
      this.icon,
      this.amount,
      this.label})
      : super(key: key);

  final int widthPct;
  final double ratioOver;
  final IconData icon;
  final String amount;
  final String label;

  @override
  _BudgetBarHorizState createState() => _BudgetBarHorizState();
}

class _BudgetBarHorizState extends State<BudgetBarHoriz> {
  @override
  Widget build(BuildContext context) {
    final Color color = col_aqua_light;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        widget.icon == null && widget.label != null
            ? Container(
                margin: EdgeInsets.only(right: 12),
                width: 80,
                child: Text(widget.label),
              )
            : Container(
                margin: EdgeInsets.only(right: 12), child: Icon(widget.icon)),
        Expanded(
          flex: widget.widthPct,
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 1],
                colors: [color.withOpacity(0.8), color],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.centerRight,
            child: widget.widthPct < 15
                ? Container()
                : Container(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      '\$${widget.amount}',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
          ),
        ),
        AnimatedSpacer(begin: 1000, end: 101 - widget.widthPct),
      ],
    );
  }
}
