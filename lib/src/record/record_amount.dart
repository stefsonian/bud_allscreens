import 'package:allscreens/src/components/divider_grid.dart';
import 'package:allscreens/src/components/splitter.dart';
import 'package:allscreens/src/record/numpad.dart';
import 'package:allscreens/src/record/record_options.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordAmount extends StatefulWidget {
  const RecordAmount({this.showNumpad});
  final bool showNumpad;

  _RecordAmountState createState() => _RecordAmountState();
}

class _RecordAmountState extends State<RecordAmount> {
  Widget build(BuildContext context) {
    RecordState recordState = Provider.of<RecordState>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AmountDisplay(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Colors.white.withOpacity(0.4),
            height: 1,
          ),
          SizedBox(height: 4),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 30),
            height: 220,
            child: Row(
              children: <Widget>[
                Flexible(flex: 1, child: RecordOptions()),
                Expanded(flex: 2, child: Center(child: Numpad())),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AmountDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RecordState recordState = Provider.of<RecordState>(context);
    final appState = Provider.of<AppState>(context);
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Row(
        children: <Widget>[
          Spacer(flex: 2),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 2, 0),
                  child: Text(
                    'AUD  \$',
                    style: TextStyle(
                      color: appState.cols.actionlight,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  recordState.numpadValue,
                  style: TextStyle(
                      color: appState.cols.actionlight,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
