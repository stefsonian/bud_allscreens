import 'dart:math';

import 'package:allscreens/src/components/chart_bar_vertical.dart';
import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/front/budget_bar_box.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/models/Expense.dart';
import 'package:allscreens/src/services/records.dart';
import 'package:allscreens/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class Playground extends StatefulWidget {
  @override
  _PlaygroundState createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  var budget = 100.0;
  List<ChartBarVertical> budgetBars = [];
  Records records;
  SessionData session;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    records = Provider.of<Records>(context);
    session = Provider.of<SessionData>(context);
    createTestData();
  }

  createTestData() {
    List<ChartBarVertical> bb = [];
    List<Expense> rs = List.from(records.full);
    rs.sort((curr, next) => curr.expenseDT.compareTo(next.expenseDT));
    double threshold1 = 100.0;
    double threshold2 = 120.0;
    for (var i = session.trip.travelDay - 1; i >= 0; i--) {
      var date = session.trip.startDT.add(Duration(days: i));
      var dateExpenses = records.expensesOnDate(date);
      double amount = dateExpenses.fold(
          0.0, (curr, next) => curr + next.amount.amountInHome);
      double budgetFactor = amount / session.trip.budgetAmount;
      var height = min(1.0, budgetFactor) * 100;
      var overRatio = min(1.2, budgetFactor);
      var label = Jiffy(date).format('d/M');
      bb.add(ChartBarVertical(
        complyColor: Colors.white,
        exceedColor: col_orange,
        labelLine1: label,
        labelColor: Colors.white,
        valueColor: col_aqua,
        threshold1: threshold1,
        threshold2: threshold2,
        showAmountAbove: amount < 0.15 * threshold1 ? true : false,
        value: amount,
      ));
    }

    setState(() => budgetBars = bb);
  }

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      child: Container(
        height: 350,
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
            SizedBox(height: 2),
            Expanded(
              child: BudgetBarBox(
                budgetBars: budgetBars,
              ),
            ),
          ],
        ),
      ),
    );
  }
}