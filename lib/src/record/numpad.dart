import 'package:allscreens/src/models/Numpad_input.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:splitsi/src/services/appState.dart';

class Numpad extends StatelessWidget {
  const Numpad({Key key, this.onTap}) : super(key: key);
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: _Item(
                  onTap: onTap,
                  number: '1',
                  value: '1',
                ),
              ),
              Expanded(
                child: _Item(
                  onTap: onTap,
                  number: '2',
                  value: '2',
                ),
              ),
              Expanded(
                child: _Item(
                  onTap: onTap,
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
                  onTap: onTap,
                  number: '4',
                  value: '4',
                ),
              ),
              Expanded(
                child: _Item(
                  onTap: onTap,
                  number: '5',
                  value: '5',
                ),
              ),
              Expanded(
                child: _Item(
                  onTap: onTap,
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
                  onTap: onTap,
                  number: '7',
                  value: '7',
                ),
              ),
              Expanded(
                child: _Item(
                  onTap: onTap,
                  number: '8',
                  value: '8',
                ),
              ),
              Expanded(
                child: _Item(
                  onTap: onTap,
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
                  onTap: onTap,
                  number: '·',
                  value: '.',
                ),
              ),
              Expanded(
                child: _Item(
                  onTap: onTap,
                  number: '0',
                  value: '0',
                ),
              ),
              Expanded(
                child: _Item(
                  onTap: onTap,
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
  const _Item({Key key, this.number, this.icon, this.value, this.onTap})
      : super(key: key);

  final String number;
  final IconData icon;
  final String value;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    RecordState recordState = Provider.of<RecordState>(context);
    AppState appState = Provider.of<AppState>(context);
    Widget w = number == null
        ? Icon(icon, size: 30, color: appState.cols.content)
        : Text(
            number.toString(),
            style: TextStyle(
              fontSize: 30,
              color: appState.cols.content,
            ),
          );
    return Material(
      color: Colors.transparent,
      child: InkWell(
        // radius: 60,
        onTap: () => onTap(value),
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
