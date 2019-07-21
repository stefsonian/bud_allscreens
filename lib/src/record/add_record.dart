import 'package:allscreens/src/record/record_amount.dart';
import 'package:allscreens/src/record/record_date.dart';
import 'package:flutter/material.dart';

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
        children: <Widget>[
          RecordDate(),
          SizedBox(height: 30),
          RecordAmount(),
        ],
      ),
    );
  }
}
