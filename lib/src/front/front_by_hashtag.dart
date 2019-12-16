import 'dart:math';
import 'package:allscreens/src/components/chart_bar_horizontal.dart';
import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/helpers/utils.dart';
import 'package:allscreens/src/services/records.dart';
import 'package:allscreens/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrontByHashtag extends StatelessWidget {
  // TODO: Only show results from previous 7 days
  @override
  Widget build(BuildContext context) {
    var records = Provider.of<Records>(context);
    var mapTotals = records.totalByHashtag();
    if (mapTotals.isEmpty) return Container();
    var listTotals =
        Utils().sortMapByDoubleValue(m: mapTotals).take(10).toList();
    var maxAmount = mapTotals.values.reduce(max).ceilToDouble();
    List<Widget> chartBars = listTotals.map((m) {
      var hashTag = m.keys.single;
      var value = m.values.single;
      return buildChartBarHorizontal(
          hashtag: hashTag, value: value, maxAmount: maxAmount);
    }).toList();
    return Container(
      child: ContentBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Top 10 hashtag spend (total AUD)',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 14),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: chartBars,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChartBarHorizontal(
      {String hashtag, double value, double maxAmount}) {
    if (maxAmount < 1) return Container();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ChartBarHorizontal(
        complyColor: Colors.white,
        exceedColor: col_orange,
        valueColor: col_aqua,
        labelBoxWidth: 110.0,
        showAmountAbove: value / maxAmount < 0.2,
        label: Container(
          padding: EdgeInsets.only(left: 8, right: 6),
          alignment: Alignment.center,
          child: Text(
            hashtag,
            style: TextStyle(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.clip,
          ),
        ),
        threshold1: maxAmount,
        threshold2: maxAmount,
        value: value,
      ),
    );
  }
}
