import 'package:allscreens/src/front/front_averages.dart';
import 'package:allscreens/src/front/front_stats.dart';
import 'package:allscreens/src/front/front_trip.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class FrontScreen extends StatefulWidget {
  @override
  _FrontScreenState createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 14, 8, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FrontTrip(),
            SizedBox(height: 14),
            Expanded(child: FrontStats()),
            SizedBox(height: 14),
            FrontAverages(),
            // SizedBox(height: 50),
            // _addExpenseButton(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Widget _addExpenseButton() {
  //   return SizedBox(
  //     width: 200,
  //     child: FloatingActionButton.extended(
  //       label: Text('Expense'),
  //       icon: Icon(Icons.add),
  //       backgroundColor: col_orange,
  //       onPressed: () {},
  //     ),
  //   );
  // }
}
