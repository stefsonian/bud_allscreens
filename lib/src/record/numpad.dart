import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:splitsi/src/services/appState.dart';

class Numpad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: _Item(
                  number: '1',
                  value: '1',
                ),
              ),
              Expanded(
                child: _Item(
                  number: '2',
                  value: '2',
                ),
              ),
              Expanded(
                child: _Item(
                  number: '3',
                  value: '3',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: _Item(
                  number: '4',
                  value: '4',
                ),
              ),
              Expanded(
                child: _Item(
                  number: '5',
                  value: '5',
                ),
              ),
              Expanded(
                child: _Item(
                  number: '6',
                  value: '6',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: _Item(
                  number: '7',
                  value: '7',
                ),
              ),
              Expanded(
                child: _Item(
                  number: '8',
                  value: '8',
                ),
              ),
              Expanded(
                child: _Item(
                  number: '9',
                  value: '9',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: _Item(
                  number: '·',
                  value: '.',
                ),
              ),
              Expanded(
                child: _Item(
                  number: '0',
                  value: '0',
                ),
              ),
              Expanded(
                child: _Item(
                  icon: Icons.arrow_back,
                  value: 'del',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key key, this.number, this.icon, this.value}) : super(key: key);

  final String number;
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    RecordState recordState = Provider.of<RecordState>(context);
    Widget w = number == null
        ? Icon(icon, size: 30, color: Colors.white)
        : Text(number.toString(), style: _textStyle);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        // radius: 60,
        onTap: () => recordState.updateNumpadValue(value),
        child: Container(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: w,
          ),
        ),
      ),
    );
  }
}

TextStyle _textStyle = TextStyle(
  fontSize: 30,
  color: Colors.white,
);
