import 'package:flutter/material.dart';
import 'package:allscreens/src/components/gradient_box.dart';
import 'package:allscreens/src/start/trip_info.dart';

import 'budget_info.dart';
import 'budget_today.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GradientBox(
              name: 'Trip',
              action: Icon(Icons.settings),
              child: TripInfo(),
            ),
            GradientBox(
              name: 'Budget',
              action: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'AUD',
                    textScaleFactor: 1.4,
                  ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
              child: BudgetToday(),
            ),
            SizedBox(height: 250),
          ],
        ),
      ),
    );
  }
}
