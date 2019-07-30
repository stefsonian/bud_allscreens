import 'package:allscreens/src/components/gradient_box.dart';
import 'package:allscreens/src/components/numpad.dart';
import 'package:flutter/material.dart';

import 'display_amount.dart';

class RecordAmount extends StatefulWidget {
  const RecordAmount({this.showNumpad});
  final bool showNumpad;

  _RecordAmountState createState() => _RecordAmountState();
}

class _RecordAmountState extends State<RecordAmount> {
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          DisplayAmount(),
          // widget.showNumpad ? SizedBox(height: 26) : Container(),
          AnimatedCrossFade(
            // use AnimatedSwitcher instead
            duration: Duration(milliseconds: 150),
            firstChild: SizedBox(
              height: 26,
            ),
            secondChild: Container(),
            crossFadeState: widget.showNumpad
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
          AnimatedCrossFade(
            duration: Duration(milliseconds: 100),
            firstChild: Numpad(),
            secondChild: Container(),
            crossFadeState: widget.showNumpad
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
          // widget.showNumpad ? Numpad() : Container(),
        ],
      ),
    );
  }
}
