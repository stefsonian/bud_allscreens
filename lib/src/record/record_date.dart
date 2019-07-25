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
    double screenHeight = MediaQuery.of(context).size.height;
    print('Screen height: $screenHeight');
    return screenHeight > 850 ? _tallRecordDate() : _shortRecordDate();
  }
}

Widget _tallRecordDate() {
  return Container(
    child: GradientBox(
      name: 'Date and type',
      child: Column(
        children: <Widget>[
          Row(
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
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton.icon(
                onPressed: () {},
                label: Text('Cash'),
                icon: Icon(Icons.donut_small),
                color: Colors.yellowAccent,
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

Widget _shortRecordDate() {
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
