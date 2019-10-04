import 'package:allscreens/src/expenses/expense_item.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

const colList = [
  Colors.blueGrey,
  Colors.cyanAccent,
  Colors.deepPurpleAccent,
  Colors.greenAccent,
  Colors.lightBlueAccent,
  Colors.orangeAccent,
  Colors.black,
  Colors.pink,
  Colors.teal
];

// MAKE AS INDEXED STACK ALONG WITH DAY VIEW

class ExpensesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            backgroundColor: col_aqua,
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
                  child: expenseSliver(),
                );
              },
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}

Widget expenseSliver() {
  final double rand = Random().nextDouble();
  final note = rand > 0.5 ? 'note' : null;
  return Padding(
    padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
    child: ExpenseItem(note: note),
  );
}

Widget dismissEditDelete() {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.only(right: 20),
          color: col_orange,
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
