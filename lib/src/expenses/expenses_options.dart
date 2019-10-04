import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class ExpensesOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton.icon(
            onPressed: () {},
            label: Text("Sort"),
            icon: Icon(Icons.calendar_today),
            color: col_aqua,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 4,
          ),
          RaisedButton.icon(
            onPressed: () {},
            label: Text('Filter'),
            icon: Icon(Icons.payment),
            color: col_aqua,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 4,
          ),
          RaisedButton.icon(
            onPressed: () {},
            label: Text('Options'),
            icon: Icon(Icons.menu),
            color: col_aqua,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 4,
          ),
        ],
      ),
    );
  }
}
