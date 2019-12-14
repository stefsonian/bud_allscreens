import 'package:allscreens/src/components/blur_dialog.dart';
import 'package:allscreens/src/stats/playground.dart';
import 'package:allscreens/src/stats/stats_list.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 100),
        Playground(),
      ],
    );
  }
}
