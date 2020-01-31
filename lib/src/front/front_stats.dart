import 'package:eatsleeptravel/src/components/chart_bar_vertical.dart';
import 'package:eatsleeptravel/src/components/content_box.dart';
import 'package:eatsleeptravel/src/components/info_bubble.dart';
import 'package:eatsleeptravel/src/front/budget_bar.dart';
import 'package:eatsleeptravel/src/front/budget_bar_box.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/models/Expense.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class FrontStats extends StatefulWidget {
  @override
  _FrontStatsState createState() => _FrontStatsState();
}

class _FrontStatsState extends State<FrontStats> {
  var budget = 100.0;
  List<ChartBarVertical> budgetBars = [];
  Records records;
  SessionData session;
  AppState appState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    records = Provider.of<Records>(context);
    session = Provider.of<SessionData>(context);
    createChartData();
  }

  createChartData() {
    final maxAmount = max(records.maxAmountInHomeCur, 1.0);
    final chartMax = maxAmount * 1.2;
    final bars = records.full.map((r) {
      final amount = r.amount.amountInHome;
      return ChartBarVertical(
        value: amount,
        exceedsChartMax: amount > chartMax,
        scaledBarHeight: (amount / chartMax),
        barColor: amount > maxAmount ? appState.cols.chartbar1 : appState.cols.chartbar2,
        valueColor: appState.cols.chartvalue,
        labelColor: appState.cols.boxcontent,
        labelBackColor: appState.cols.box,
        labelLine1: ,

      );
    }).toList();
    // for each expense, make a chart bar with:
      // this.labelLine1,
      // this.labelLine2,
      // this.valuePrefix,
      // this.showAmountAbove = false


    records.full.forEach((r) {

    });


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
        complyColor: appState.cols.chartbar1,
        exceedColor: appState.cols.chartbar2,
        labelLine1: label,
        labelColor: appState.cols.boxcontent,
        valueColor: appState.cols.chartvalue,
        labelBackColor: appState.cols.box,
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
                          color: appState.cols.content),
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

// const Color col1 = Color(0xFF56ab2f);
// const Color col2 = Color(0xFFa8e063);

// final BoxDecoration _boxDecor = BoxDecoration(
//   gradient: LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     stops: [0, 1],
//     colors: [col1.withOpacity(0.8), col2],
//   ),
//   borderRadius: BorderRadius.circular(16),
//   // boxShadow: kElevationToShadow[1],
// );
