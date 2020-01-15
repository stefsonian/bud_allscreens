import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final Color color = appState.cols.content;
    return Container(
      width: 120,
      child: Column(
        children: <Widget>[
          Expanded(
            child: selectButton('Currency', Icons.monetization_on, color),
          ),
          Expanded(
            child: selectButton('Split', Icons.call_split, color),
          ),
          Expanded(
            child: selectButton('Repeat', Icons.repeat, color),
          ),
          Expanded(
            child: selectButton('Clear all', Icons.cancel, color),
          ),
        ],
      ),
    );
  }

  Widget selectButton(String label, IconData icon, Color color) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(icon, color: color),
          SizedBox(width: 4),
          Text(label,
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.visible),
        ],
      ),
    );
  }
}
