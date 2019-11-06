import 'package:allscreens/src/components/gradient_box.dart';
import 'package:allscreens/src/components/splitter.dart';
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _person(),
          RecordItemSplitter(),
          _date(),
          RecordItemSplitter(),
          _payment(),
          RecordItemSplitter(),
          _currency(),
          RecordItemSplitter(),
        ],
      ),
    );
  }

  Widget _person() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _optionBox('Plato', true),
        _optionBox('Aristotle', false),
        _optionBox('Pick', false),
      ],
    );
  }

  Widget _date() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _optionBox('Today', true),
        _optionBox('Yesterday', false),
        _optionBox('Pick', false),
      ],
    );
  }

  Widget _payment() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _optionBox('Cash', true),
        _optionBox('Card', false),
        _optionBox('Pick', false),
      ],
    );
  }

  Widget _currency() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _optionBox('AUD', true),
        _optionBox('EUR', false),
        _optionBox('Pick', false),
      ],
    );
  }

  Widget _optionBox(String label, bool selected) {
    var textStyle = _optionTextStyle;
    var backColor = Colors.transparent;

    if (selected) {
      textStyle = _optionTextStyleSelected;
      backColor = Colors.white;
    }

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(1, 7, 1, 7),
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: BorderRadius.circular(360),
          border: Border.all(width: 1, color: Colors.white),
        ),
        child: Text(label, style: textStyle),
      ),
    );
  }

  final _optionTextStyleSelected = TextStyle(
    color: col_aqua,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.1,
  );

  final _optionTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    letterSpacing: 1.1,
  );
}

class RecordItemSplitter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 23, 20, 23),
      color: Colors.white.withOpacity(0.5),
      height: 1,
    );
  }
}
