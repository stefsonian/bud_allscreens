import 'dart:math';
import 'package:eatsleeptravel/src/components/chart_bar_vertical.dart';
import 'package:eatsleeptravel/src/components/content_box.dart';

import 'package:eatsleeptravel/src/front/budget_bar_box.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

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
    final startDT = session.trip.startDT;
    final endDT = DateTime.now();
    double budgetAmount = session.trip.budgetAmount;
    double maxAmount = 1.0;
    double chartMax = 1.2;
    List<ChartBarVertical> chartBars = [];
    final expenseDays = records.groupedByDay(
      // group expenses by day
      start: startDT,
      end: endDT,
      includeEmptyDays: true,
    );

    expenseDays.forEach((date, expenses) {
      // find highest total expense amount for one day
      double dayTotal = expenses.fold(
          0.0,
          (a, b) =>
              a + b.getAmount('aud')); // TODO: change this to not just be aud
      if (dayTotal > maxAmount) maxAmount = dayTotal;
    });

    maxAmount = min(maxAmount, budgetAmount);
    chartMax = maxAmount * 1.2;

    expenseDays.forEach((date, expenses) {
      // create bars for the chart
      double dayTotal = expenses.fold(
          0.0,
          (a, b) =>
              a + b.getAmount('aud')); // TODO: change this to not just be aud
      chartBars.add(ChartBarVertical(
        value: dayTotal,
        exceedsChartMax: dayTotal > chartMax,
        scaledBarHeight: (min(dayTotal, chartMax) / chartMax),
        barColor: dayTotal > maxAmount
            ? appState.cols.chartbar2
            : appState.cols.chartbar1,
        valueColor: appState.cols.chartvalue,
        labelColor: appState.cols.boxcontent,
        labelBackColor: appState.cols.box,
        showAmountAbove: dayTotal < maxAmount * 0.15,
        labelLine1: Utils().shortDate(date),
      ));
    });

    // final bars2 = records.full.map((r) {
    //   final amount = r.amount.amountInHome;
    //   return ChartBarVertical(
    //       value: amount,
    //       exceedsChartMax: amount > chartMax,
    //       scaledBarHeight: (amount / chartMax),
    //       barColor: amount > maxAmount
    //           ? appState.cols.chartbar2
    //           : appState.cols.chartbar1,
    //       valueColor: appState.cols.chartvalue,
    //       labelColor: appState.cols.boxcontent,
    //       labelBackColor: appState.cols.box,
    //       labelLine1: r.chartDate);
    // }).toList();

    setState(() => budgetBars = chartBars.reversed.toList());
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
