import 'package:allscreens/src/expenses/expense_item.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/models/Expense.dart';
import 'package:allscreens/src/services/records.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class ExpensesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Records records = Provider.of<Records>(context);
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.sort),
                tooltip: 'Sort',
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.filter_list),
                tooltip: 'Filter',
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.more_horiz),
                tooltip: 'Sort',
                onPressed: () {},
              ),
            ],
            floating: true,
            snap: true,
            backgroundColor: col_main1,
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
                  background: dismissCopy(),
                  secondaryBackground: dismissEditDelete(),
                  onDismissed: (direction) {
                    // setState(() {
                    //   items.removeAt(index);
                    // });
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("item dismissed")));
                  },
                  child: expenseSliver(records.full[index]),
                );
              },
              childCount: records.full.length,
            ),
          ),
        ],
      ),
    );
  }
}

Widget expenseSliver(Expense expense) {
  final double rand = Random().nextDouble();
  expense.note = rand > 0.5 ? expense.note : null;
  return Padding(
    padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
    child: ExpenseItem(expense: expense),
  );
}

Widget dismissEditDelete() {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.only(right: 20),
          color: col_main2,
          height: double.infinity,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget dismissCopy() {
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
              'View day',
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
