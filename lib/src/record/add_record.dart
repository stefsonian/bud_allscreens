import 'package:allscreens/src/components/gradient_box.dart';
import 'package:allscreens/src/record/record_amount.dart';
import 'package:allscreens/src/record/record_options.dart';
import 'package:flutter/material.dart';
import '../helpers/colors.dart';

class AddRecord extends StatefulWidget {
  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  bool showNumpad = true;

  tapNext() => setState(() => showNumpad = false);

  tapAmount() => setState(() => showNumpad = true);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 26), // replace with safearea
      padding: EdgeInsets.all(14),
      child: GradientBox(
        name: 'Expense',
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RecordOptions(),
              SizedBox(height: 12),
              GestureDetector(
                onTap: tapAmount,
                child: RecordAmount(showNumpad: showNumpad),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 170,
                    child: FloatingActionButton.extended(
                      // onPressed: () => Navigator.pushNamed(context, '/categories'),
                      onPressed: tapNext,
                      label: Text('Next', textScaleFactor: 1.5),
                      backgroundColor: Colors.yellowAccent,
                      foregroundColor: col_box2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
