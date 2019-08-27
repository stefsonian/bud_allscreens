import 'package:allscreens/src/components/Ikon_button.dart';
import 'package:allscreens/src/components/gradient_box.dart';
import 'package:allscreens/src/components/numpad.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'display_amount.dart';

class RecordAmount extends StatefulWidget {
  const RecordAmount({this.showNumpad});
  final bool showNumpad;

  _RecordAmountState createState() => _RecordAmountState();
}

class _RecordAmountState extends State<RecordAmount> {
  Widget build(BuildContext context) {
    RecordState recordState = Provider.of<RecordState>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Numpad(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                width: 250,
                child: FloatingActionButton.extended(
                  label: Text(
                    'Next',
                    textScaleFactor: 1.4,
                  ),
                  icon: Icon(Icons.keyboard_arrow_right),
                  backgroundColor: Colors.yellow,
                  foregroundColor: col_purple,
                  onPressed: () => recordState.isAmountRecorded = true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
