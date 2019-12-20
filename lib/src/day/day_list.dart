import 'dart:math';

import 'package:allscreens/src/day/day_item.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayList extends StatelessWidget {
  const DayList({Key key, this.itemHeight}) : super(key: key);
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    // final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenHeight = MediaQuery.of(context).size.height;
    // print('w: $screenWidth');
    // print('h: $screenHeight');
    final appState = Provider.of<AppState>(context);
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Days'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_upward),
                tooltip: 'To top',
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.sort),
                tooltip: 'Sort',
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.calendar_today),
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
                return DayItem(
                  itemHeight: itemHeight,
                  color: color,
                  altColor: nextColor,
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
