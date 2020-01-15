import 'dart:math';
import 'package:eatsleeptravel/src/components/chart_bar_horizontal.dart';
import 'package:eatsleeptravel/src/components/content_box.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrontByHashtag extends StatelessWidget {
  // TODO: Only show results from previous 7 days
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
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
        hashtag: hashTag,
        value: value,
        maxAmount: maxAmount,
        appState: appState,
      );
    }).toList();
    return Container(
      child: ContentBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Top 10 hashtag spend (total AUD)',
                style: TextStyle(fontSize: 16, color: appState.cols.content)),
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
      {String hashtag, double value, double maxAmount, AppState appState}) {
    if (maxAmount < 1) return Container();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ChartBarHorizontal(
        complyColor: appState.cols.chartbar1,
        exceedColor: appState.cols.chartbar1,
        valueColor: appState.cols.chartvalue,
        labelColor: appState.cols.boxcontent,
        labelBackColor: appState.cols.box,
        labelBoxWidth: 110.0,
        showAmountAbove: value / maxAmount < 0.2,
        label: Container(
          padding: EdgeInsets.only(left: 8, right: 6),
          alignment: Alignment.center,
          child: Text(
            hashtag,
            style: TextStyle(color: appState.cols.boxcontent),
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
