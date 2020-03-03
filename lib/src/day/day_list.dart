import 'dart:math';

import 'package:eatsleeptravel/src/day/day_item.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/models/Currency.dart';
import 'package:eatsleeptravel/src/models/Expense.dart';
import 'package:eatsleeptravel/src/models/Trip.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class DayList extends StatefulWidget {
  @override
  _DayListState createState() => _DayListState();
}

class _DayListState extends State<DayList> {
  AppState appState;
  Records records;
  SessionData sessionData;
  Trip trip;
  Currency homeCurrency;
  Map<DateTime, List<Expense>> expensesByDay;
  DateTime lastRefreshed = DateTime(2020, 1, 1);

  @override
  void didChangeDependencies() {
    appState = Provider.of<AppState>(context);
    records = Provider.of<Records>(context);
    sessionData = Provider.of<SessionData>(context);
    if (lastRefreshed.isBefore(records.fullRefreshed)) _refreshData();
    if (lastRefreshed.isBefore(sessionData.userDataRefreshed)) _refreshData();
    super.didChangeDependencies();
  }

  _refreshData() {
    setState(() => trip = sessionData.trip);
    setState(() =>
        homeCurrency = records.getCurrency(sessionData.user.homeCurrency));
    setState(() => expensesByDay = Map.from(records.groupedByDay(
        start: trip.startDT, end: Jiffy(DateTime.now()).endOf('day'))));
    lastRefreshed = records.fullRefreshed.add(Duration(milliseconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> expenseDates = expensesByDay.keys.toList();
    expenseDates.sort();
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Days'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.vertical_align_top),
                tooltip: 'To top',
                onPressed: () {},
              ),
              // IconButton(
              //   icon: Icon(Icons.sort),
              //   tooltip: 'Sort',
              //   onPressed: () {},
              // ),
              IconButton(
                icon: Icon(Icons.calendar_today),
                tooltip: 'Filter',
                onPressed: () {},
              ),
              // IconButton(
              //   icon: Icon(Icons.more_horiz),
              //   tooltip: 'Sort',
              //   onPressed: () {},
              // ),
            ],
            floating: true,
            snap: true,
            backgroundColor: appState.cols.background1,
            expandedHeight: 70.0,
            // flexibleSpace: FlexibleSpaceBar(
            //   background: FlutterLogo(),
            // ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final col1 = appState.cols.background1;
                final col2 = appState.cols.content;
                final Color color = index.isEven ? col2 : col1;
                final Color nextColor = index.isEven ? col1 : col2;
                DateTime dayDate = expenseDates[index];
                List<Expense> dayExpenses = expensesByDay[dayDate];
                dayExpenses.forEach(
                    (e) => e.currency = records.getCurrency(e.currencyId));
                return DayItem(
                  color: color,
                  altColor: nextColor,
                  date: dayDate,
                  expenses: dayExpenses,
                  homeCurrency: homeCurrency,
                );
              },
              childCount: expenseDates.length,
            ),
          ),
        ],
      ),
    );
  }
}
