import 'package:allscreens/src/components/gradient_box.dart';
import 'package:allscreens/src/components/numpad.dart';
import 'package:flutter/material.dart';

import 'display_amount.dart';

class RecordAmount extends StatefulWidget {
  @override
  _RecordAmountState createState() => _RecordAmountState();
}

class _RecordAmountState extends State<RecordAmount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GradientBox(
        name: 'Amount',
        action: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'AUD',
              textScaleFactor: 1.3,
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
        child: Column(
          children: <Widget>[
            DisplayAmount(),
            SizedBox(height: 26),
            Numpad(),
          ],
        ),
      ),
    );
  }
}
