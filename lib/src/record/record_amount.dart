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
    appState.updateNewExpense('amount', numpad.valueDouble);
    appState.updateNewExpense('currencyId', 'AUD');
  }

  @override
  void didChangeDependencies() {
    appState = Provider.of<AppState>(context);
    recordState = Provider.of<RecordState>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Sizing
    final h = appState.viewHeight;
    final w = appState.viewWidth;
    double amountBoxHeight = 80.0;
    double boxSpace = 10.0;
    double amountMargin = 20.0;
    bool isShort = false;
    bool isNarrow = false;

    if (h < 735) {
      amountBoxHeight = 58.0;
      isShort = true;
    }

    if (w < 373) {
      boxSpace = 7.0;
      isNarrow = true;
    }

    if (w < 400) amountMargin = 6.0;
    // ------

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
            margin: EdgeInsets.symmetric(horizontal: amountMargin),
            child: Row(
              children: <Widget>[
                Container(
                  height: amountBoxHeight,
                  width: amountBoxHeight,
                  decoration: optionDecor,
                  padding: EdgeInsets.all(2),
                  child: DisplayPart(
                    appState: appState,
                    onTap: () {},
                    icon: Icons.credit_card,
                    label: 'Credit',
                    isSmall: isShort,
                  ),
                ),
                SizedBox(width: boxSpace),
                Container(
                  height: amountBoxHeight,
                  width: amountBoxHeight,
                  decoration: optionDecor,
                  padding: EdgeInsets.all(2),
                  child: DisplayPart(
                    appState: appState,
                    onTap: () {},
                    icon: Icons.monetization_on,
                    label: 'AUD',
                    isSmall: isShort,
                  ),
                ),
                SizedBox(width: boxSpace),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 12),
                    height: amountBoxHeight,
                    decoration: optionDecor,
                    alignment: Alignment.centerRight,
                    child: Text(
                      amount,
                      style: TextStyle(
                        color: appState.cols.content,
                        fontSize: isNarrow ? 24 : 30,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: isShort
                ? EdgeInsets.fromLTRB(10, 14, 10, 10)
                : EdgeInsets.fromLTRB(20, 40, 20, 20),
            height: isShort ? 180 : 220,
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
    this.isSmall,
  }) : super(key: key);

  final AppState appState;
  final Function onTap;
  final IconData icon;
  final String label;
  final bool isSmall;

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
                fontSize: isSmall ? 12 : 17,
              ),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
