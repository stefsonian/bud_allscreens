import 'package:allscreens/src/record/record_amount.dart';
import 'package:allscreens/src/record/record_date.dart';
import 'package:flutter/material.dart';
import '../helpers/colors.dart';

class AddRecord extends StatefulWidget {
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RecordDate(),
          // SizedBox(height: 30),
          RecordAmount(),
          SizedBox(
            width: 170,
            child: FloatingActionButton.extended(
              onPressed: () {},
              label: Text('Next', textScaleFactor: 1.5),
              backgroundColor: Colors.yellowAccent,
              foregroundColor: col_box2,
            ),
          ),
        ],
      ),
    );
  }
}
