import 'package:flutter/material.dart';
import 'package:allscreens/src/components/gradient_box.dart';
import 'package:allscreens/src/start/trip_info.dart';

import 'budget_info.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GradientBox(
            action: Icon(Icons.settings),
            child: TripInfo(),
          ),
          GradientBox(
            child: BudgetInfo(),
          ),
          SizedBox(height: 330),
        ],
      ),
    );
  }
}
