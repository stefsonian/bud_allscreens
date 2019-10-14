import 'package:allscreens/src/day/day_item.dart';
import 'package:allscreens/src/day/day_list.dart';
import 'package:flutter/material.dart';

class DayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double itemHeight = screenHeight - padding.top - 200;
    return DayList(itemHeight: itemHeight);
  }
}
