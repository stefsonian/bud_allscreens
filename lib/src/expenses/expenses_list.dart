import 'package:eatsleeptravel/src/components/dialog_header.dart';
import 'package:eatsleeptravel/src/components/full_modal_ok.dart';
import 'package:eatsleeptravel/src/expenses/expense_filters.dart';
import 'package:eatsleeptravel/src/expenses/expense_item.dart';
import 'package:eatsleeptravel/src/expenses/expenses_order_by.dart';
import 'package:eatsleeptravel/src/models/Expense.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/expense_list_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:provider/provider.dart';

class ExpensesList extends StatefulWidget {
  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  Records records;
  AppState appState;
  SessionData sessionData;
  ExpenseListState listState;
  List<Expense> expenses;

  void didChangeDependencies() {
    records = Provider.of<Records>(context);
    appState = Provider.of<AppState>(context);
    sessionData = Provider.of<SessionData>(context);
    listState = Provider.of<ExpenseListState>(context);
    _refreshData();
    super.didChangeDependencies();
  }

  _refreshData() async {
    if (listState.hashtags.length != records.uniqueHashtags().length) {
      await listState.setHashtags(records.uniqueHashtags());
      await listState.setMainCategories(sessionData.maincats.values.toList());
      _updateExpenses();
    }
  }

  _updateExpenses() {
    String orderBy = listState.orderBy.keys.single;
    bool asc = listState.orderBy.values.single == 'ascending';

    List<Expense> result = records.full
        .where((r) => listState.passesMainCategoriesFilter(r.mainCategory))
        .where((r) => listState.passesHashtagFilter(r.hashtags))
        .toList();

    if (orderBy == 'expenseDT') {
      if (asc) result.sort((a, b) => a.expenseDT.compareTo(b.expenseDT));
      if (!asc) result.sort((a, b) => b.expenseDT.compareTo(a.expenseDT));
    }

    if (orderBy == 'amount') {
      if (asc)
        result.sort((a, b) => a.getAmount('usd').compareTo(b.getAmount('usd')));
      if (!asc)
        result.sort((a, b) => b.getAmount('usd').compareTo(a.getAmount('usd')));
    }

    if (orderBy == 'category') {
      result.sort((a, b) => a.subCategory.id.compareTo(b.subCategory.id));
      result.sort((a, b) => a.mainCategory.id.compareTo(b.mainCategory.id));
    }

    setState(() => expenses = result);
  }

  onFilterTap() {
    Map<String, bool> currentFilter = Map.from(listState.filterHashtags);
    _submitFunction() {
      _updateExpenses();
      Navigator.pop(context);
    }

    _cancelFunction() {
      listState.filterHashtags = currentFilter;
      Navigator.pop(context);
    }

    Navigator.of(context).push(
      FullModalOk(
        header: SetFiltersHeader(),
        body: ExpensesFilters(),
        buttonColor: appState.cols.content,
        onOkTap: _submitFunction,
        onCancelTap: _cancelFunction,
      ),
    );
  }

  onSortTap() {
    Map<String, String> currentOrderBy = Map.from(listState.orderBy);
    _submitFunction() {
      _updateExpenses();
      Navigator.pop(context);
    }

    _cancelFunction() {
      listState.orderBy = currentOrderBy;
      Navigator.pop(context);
    }

    Navigator.of(context).push(
      FullModalOk(
        header: SetOrderByHeader(),
        body: ExpensesOrderBy(),
        buttonColor: appState.cols.content,
        onOkTap: _submitFunction,
        onCancelTap: _cancelFunction,
      ),
    );
  }

  Future<void> onPullToRefresh() async {
    _refreshData();
    _updateExpenses();
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    if (listState.filterHashtags.isEmpty || expenses == null) {
      return Container();
    }
    return SafeArea(
      top: false,
      child: LiquidPullToRefresh(
        onRefresh: onPullToRefresh,
        color: appState.cols.background2,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Expenses'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.sort),
                  tooltip: 'Sort',
                  onPressed: onSortTap,
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  tooltip: 'Filter',
                  onPressed: onFilterTap,
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  tooltip: 'Sort',
                  onPressed: () {},
                ),
              ],
              floating: true,
              snap: true,
              backgroundColor: appState.cols.background2,
              expandedHeight: 70.0,
              // flexibleSpace: FlexibleSpaceBar(
              //   background: FlutterLogo(),
              // ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final keyString = Random().nextDouble().toString();
                  return Dismissible(
                    key: Key(keyString),
                    background: dismissEdit(),
                    secondaryBackground: dismissDelete(appState),
                    onDismissed: (direction) {
                      // setState(() {
                      //   items.removeAt(index);
                      // });
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("item dismissed")));
                    },
                    child:
                        expenseSliver(expenses[index], appState.cols.content),
                  );
                },
                childCount: expenses.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget expenseSliver(Expense expense, Color color) {
  final double rand = Random().nextDouble();
  return Container(
    decoration: BoxDecoration(
      border:
          Border(bottom: BorderSide(width: 1, color: color.withOpacity(0.3))),
    ),
    padding: EdgeInsets.fromLTRB(4, 6, 4, 6),
    child: ExpenseItem(expense: expense),
  );
}

Widget dismissDelete(AppState appState) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.only(right: 20),
          color: Colors.pink,
          height: double.infinity,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Delete',
              style: TextStyle(
                color: appState.cols.content,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget dismissEdit() {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.only(left: 20),
          color: Colors.yellowAccent,
          height: double.infinity,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Edit',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class SetFiltersHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: appState.cols.content.withOpacity(0.4),
          ),
        ),
      ),
      height: 80,
      child: DialogHeader(
        mainHeader: 'Filter expenses',
        color: appState.cols.content,
      ),
    );
  }
}

class SetOrderByHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: appState.cols.content.withOpacity(0.4),
          ),
        ),
      ),
      height: 80,
      child: DialogHeader(
        mainHeader: 'Sort expenses',
        color: appState.cols.content,
      ),
    );
  }
}
