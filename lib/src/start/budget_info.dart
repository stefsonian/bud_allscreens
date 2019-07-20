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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
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
              ),
            ),
          ],
        ),
        SizedBox(height: 34),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            horizonPicker('Day'),
            horizonPicker('Week'),
            horizonPicker('Month'),
            horizonPicker('Trip'),
          ],
        ),
      ],
    );
  }

  Widget horizonPicker(String name) {
    return Column(
      children: <Widget>[
        Text(name),
        SizedBox(height: 2),
        Container(
          width: 50,
          height: 2,
          color: Colors.black,
        ),
      ],
    );
  }
}
