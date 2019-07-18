import 'package:allscreens/src/components/factoid.dart';
import 'package:flutter/material.dart';

class BudgetInfo extends StatefulWidget {
  @override
  _BudgetInfoState createState() => _BudgetInfoState();
}

class _BudgetInfoState extends State<BudgetInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'AUD',
              textScaleFactor: 1.4,
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
        SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Factoid(fact: '\$44', label: 'Today'),
                  SizedBox(height: 20),
                  Factoid(fact: '\$444', label: 'Week'),
                  SizedBox(height: 20),
                  Factoid(fact: '\$55', label: 'Average'),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 150,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(Icons.donut_large),
                ),
                // decoration: BoxDecoration(
                //   border: Border.all(width: 1),
                // ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
