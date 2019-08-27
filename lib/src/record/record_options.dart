import 'package:allscreens/src/components/gradient_box.dart';
import 'package:flutter/material.dart';
import '../helpers/colors.dart';

class RecordOptions extends StatefulWidget {
  @override
  _RecordOptionsState createState() => _RecordOptionsState();
}

class _RecordOptionsState extends State<RecordOptions> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // print('Screen height: $screenHeight');
    return screenHeight > 850 ? _tallRecordOptions() : _tallRecordOptions();
  }
}

Widget _tallRecordOptions() {
  return Container(
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton.icon(
              onPressed: () {},
              label: Text("Today"),
              icon: Icon(Icons.calendar_today),
              color: col_purple,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 4,
            ),
            RaisedButton.icon(
              onPressed: () {},
              label: Text('Card'),
              icon: Icon(Icons.payment),
              color: col_purple,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 4,
            ),
            RaisedButton.icon(
              onPressed: () {},
              label: Text('Options'),
              icon: Icon(Icons.menu),
              color: col_purple,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 4,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _shortRecordOptions() {
  return Container(
    child: GradientBox(
      name: 'Date and type',
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton.icon(
                onPressed: () {},
                label: Text("Today"),
                icon: Icon(Icons.calendar_today),
                color: col_background1,
                textColor: col_box2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 4,
              ),
              RaisedButton.icon(
                onPressed: () {},
                label: Text('Card'),
                icon: Icon(Icons.payment),
                color: col_background1,
                textColor: col_box2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 4,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
