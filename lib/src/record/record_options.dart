import 'package:flutter/material.dart';

class RecordOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Column(
        children: <Widget>[
          Expanded(
            child: selectButton('Currency', Icons.monetization_on),
          ),
          Expanded(
            child: selectButton('Currency', Icons.monetization_on),
          ),
          Expanded(
            child: selectButton('Currency', Icons.monetization_on),
          ),
          Expanded(
            child: selectButton('Currency', Icons.monetization_on),
          ),
        ],
      ),
    );
  }

  Widget selectButton(String label, IconData icon) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white),
          SizedBox(width: 4),
          Text(label,
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.visible),
        ],
      ),
    );
  }
}
