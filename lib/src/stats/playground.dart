import 'dart:math';

import 'package:eatsleeptravel/src/components/chart_bar_horizontal.dart';
import 'package:eatsleeptravel/src/components/chart_bar_vertical.dart';
import 'package:eatsleeptravel/src/components/content_box.dart';
import 'package:eatsleeptravel/src/front/budget_bar_box.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/models/Expense.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class Playground extends StatefulWidget {
  @override
  _PlaygroundState createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  var budget = 100.0;
  List<ChartBarHorizontal> budgetBars = [];
  Records records;
  SessionData session;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    records = Provider.of<Records>(context);
    session = Provider.of<SessionData>(context);
    // createTestData();
  }

  // createTestData() {
  //   List<ChartBarHorizontal> bb = [];
  //   List<Expense> rs = List.from(records.full);
  //   rs.sort((curr, next) => curr.expenseDT.compareTo(next.expenseDT));
  //   double threshold1 = 100.0;
  //   double threshold2 = 120.0;
  //   for (var i = session.trip.travelDay - 1; i >= 0; i--) {
  //     var date = session.trip.startDT.add(Duration(days: i));
  //     var dateExpenses = records.expensesOnDate(date);
  //     double amount = dateExpenses.fold(
  //         0.0, (curr, next) => curr + next.amount.amountInHome);
  //     double budgetFactor = amount / session.trip.budgetAmount;
  //     var height = min(1.0, budgetFactor) * 100;
  //     var overRatio = min(1.2, budgetFactor);
  //     var label = Jiffy(date).format('d/M');
  //     bb.add(ChartBarHorizontal(
  //       complyColor: Colors.white,
  //       exceedColor: col_main2,
  //       label: Icon(Icons.flight, color: Colors.white),
  //       labelColor: Colors.white,
  //       valueColor: col_main1,
  //       threshold1: threshold1,
  //       threshold2: threshold2,
  //       showAmountAbove: amount < 0.15 * threshold1 ? true : false,
  //       value: amount,
  //     ));
  //   }

  //   setState(() => budgetBars = bb);
  // }

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      child: Container(
        height: 450,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Daily spend  ·  AUD \$100 budget',
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '',
                      // 'Budget: \$100',
                      style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: Column(
                children: budgetBars
                    .take(5)
                    .map((b) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: b,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
