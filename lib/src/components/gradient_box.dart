import 'package:flutter/material.dart';
import 'package:allscreens/src/helpers/colors.dart';

class GradientBox extends StatelessWidget {
  const GradientBox(
      {this.child,
      this.name,
      this.action,
      this.col1 = col_box1,
      this.col2 = col_box2});
  final Widget child;
  final String name;
  final Widget action;
  final Color col1;
  final Color col2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1],
          colors: [col1, col2],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(1, 1),
            blurRadius: 0,
          )
        ],
      ),
      padding: EdgeInsets.fromLTRB(26, 12, 26, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: name == null ? Container() : Text(name),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: action == null ? Container() : action,
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}
