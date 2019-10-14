import 'dart:math';

import 'package:allscreens/src/day/day_item.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class DayList extends StatelessWidget {
  const DayList({Key key, this.itemHeight}) : super(key: key);
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    // final double screenWidth = MediaQuery.of(context).size.width;
    // final double screenHeight = MediaQuery.of(context).size.height;
    // print('w: $screenWidth');
    // print('h: $screenHeight');
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
            backgroundColor: col_aqua,
            expandedHeight: 70.0,
            // flexibleSpace: FlexibleSpaceBar(
            //   background: FlutterLogo(),
            // ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final Color color = index.isEven ? Colors.white : col_aqua;
                final Color nextColor = index.isEven ? col_aqua : Colors.white;
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
