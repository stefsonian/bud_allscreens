import 'package:allscreens/src/components/gradient_box.dart';
import 'package:flutter/material.dart';
import '../helpers/colors.dart';

class RecordDate extends StatefulWidget {
  @override
  _RecordDateState createState() => _RecordDateState();
}

class _RecordDateState extends State<RecordDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GradientBox(
        name: 'Expense details',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
              onPressed: () {},
              child: Text('Yesterday'),
              color: col_background1,
              textColor: col_box2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 4,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('Today'),
              textColor: col_box2,
              color: Colors.yellowAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 4,
            ),
            RaisedButton.icon(
              onPressed: () {},
              label: Text("Select"),
              icon: Icon(Icons.calendar_today),
              color: col_background1,
              textColor: col_box2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 4,
            ),
          ],
        ),
      ),
    );
  }
}
