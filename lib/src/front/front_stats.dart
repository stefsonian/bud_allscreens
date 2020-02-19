import 'dart:math';
import 'package:eatsleeptravel/src/components/chart_bar_vertical.dart';
import 'package:eatsleeptravel/src/components/content_box.dart';

import 'package:eatsleeptravel/src/front/budget_bar_box.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/models/Currency.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/home_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';

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
  HomeState homeState;
  double budgetAmount;
  Currency budgetCurrency;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    records = Provider.of<Records>(context);
    session = Provider.of<SessionData>(context);
    homeState = Provider.of<HomeState>(context);
    createChartData();
  }

  createChartData() {
    final startDT = session.trip.startDT;
    final endDT = DateTime.now();
    double maxAmount = 1.0;
    double chartMax = 1.2;
    List<ChartBarVertical> chartBars = [];
    final expenseDays = records.groupedByDay(
      // group expenses by day
      start: startDT,
      end: endDT,
      includeEmptyDays: true,
    );

    var curId = session.user.displayCurrencies.containsKey('home')
        ? session.user.displayCurrencies['home']
        : session.user.homeCurrency;
    budgetCurrency = records.getCurrency(curId);

    budgetAmount = Utils().convertAmount(
      amount: session.trip.budgetAmount,
      xRates: records.latestXrates(),
      fromCurrency: session.trip.budgetCurrency,
      toCurrency: curId,
    );

    expenseDays.forEach((date, expenses) {
      // find highest total expense amount for one day
      double dayTotal = expenses.fold(
        0.0,
        (a, b) => a + b.getAmount(budgetCurrency.id),
      );
      if (dayTotal > maxAmount) maxAmount = dayTotal;
    });

    maxAmount = min(maxAmount, budgetAmount);
    chartMax = maxAmount * 1.2;

    expenseDays.forEach((date, expenses) {
      // create bars for the chart
      double dayTotal =
          expenses.fold(0.0, (a, b) => a + b.getAmount(budgetCurrency.id));
      chartBars.add(ChartBarVertical(
        value: Utils().formattedAmount(amount: dayTotal),
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
    setState(() => budgetBars = chartBars.reversed.toList());
  }

  @override
  Widget build(BuildContext context) {
    return ContentBox(
      child: Container(
        height: 350,
        child: Column(
          children: <Widget>[
            Text(
              'Daily spend · ${Utils().formattedCurrency(budgetAmount, budgetCurrency)} budget',
              style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.bold,
                  color: appState.cols.content),
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
