import 'dart:math';

import 'package:allscreens/src/components/divider_grid.dart';
import 'package:allscreens/src/components/option_button.dart';
import 'package:allscreens/src/models/Numpad_input.dart';
import 'package:allscreens/src/record/numpad.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordAmount extends StatefulWidget {
  @override
  _RecordAmountState createState() => _RecordAmountState();
}

class _RecordAmountState extends State<RecordAmount> {
  AppState appState;
  RecordState recordState;
  NumpadInput numpad = NumpadInput();
  String amount = '0.00';

  onNumberTap(String value) {
    numpad.updateValue(value);
    setState(() => amount = numpad.displayValue());
  }

  @override
  void didChangeDependencies() {
    appState = Provider.of<AppState>(context);
    recordState = Provider.of<RecordState>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final BoxDecoration optionDecor = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      // color: appState.cols.action,
      // boxShadow: kElevationToShadow[4],
      border: Border.all(
        width: 2,
        color: appState.cols.content.withOpacity(0.3),
      ),
    );
    // final circleDiameter = max((screenHeight - 270))
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                Container(
                  height: 80,
                  width: 80,
                  decoration: optionDecor,
                  padding: EdgeInsets.all(2),
                  child: DisplayPart(
                    appState: appState,
                    onTap: () {},
                    icon: Icons.credit_card,
                    label: 'Credit',
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 80,
                  width: 80,
                  decoration: optionDecor,
                  padding: EdgeInsets.all(2),
                  child: DisplayPart(
                    appState: appState,
                    onTap: () {},
                    icon: Icons.monetization_on,
                    label: 'AUD',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 12),
                    height: 80,
                    decoration: optionDecor,
                    alignment: Alignment.centerRight,
                    child: Text(
                      amount,
                      style: TextStyle(
                        color: appState.cols.content,
                        fontSize: 30,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
            height: 220,
            child: Stack(
              children: <Widget>[
                Numpad(onTap: onNumberTap),
                DividerGrid(
                  horizontalDividers: 3,
                  verticalDividers: 2,
                  color1: appState.cols.content.withOpacity(0.3),
                  color2: appState.cols.content.withOpacity(0.25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayPart extends StatelessWidget {
  const DisplayPart({
    Key key,
    @required this.appState,
    this.onTap,
    this.icon,
    this.label,
  }) : super(key: key);

  final AppState appState;
  final Function onTap;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              icon,
              color: appState.cols.content,
            ),
            Text(
              label,
              style: TextStyle(
                color: appState.cols.content,
                fontSize: 17,
              ),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
