import 'dart:math';
import 'package:allscreens/src/components/chart_bar_horizontal.dart';
import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:allscreens/src/services/records.dart';
import 'package:allscreens/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrontByCategory extends StatelessWidget {
  // TODO: Only show results from previous 7 days
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    var records = Provider.of<Records>(context);
    var sessionData = Provider.of<SessionData>(context);
    var cats = records.totalByMainCat();
    var maxAmount = cats.values.reduce(max).ceilToDouble();
    return Container(
      child: ContentBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Category spend (total AUD)',
              style: TextStyle(fontSize: 16, color: appState.cols.content),
            ),
            SizedBox(height: 14),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildChartBarHorizontal(
                  icon: sessionData.maincats['eat'].icon,
                  value: cats['eat'],
                  maxAmount: maxAmount,
                  appState: appState,
                ),
                buildChartBarHorizontal(
                  icon: sessionData.maincats['sleep'].icon,
                  value: cats['sleep'],
                  maxAmount: maxAmount,
                  appState: appState,
                ),
                buildChartBarHorizontal(
                  icon: sessionData.maincats['travel'].icon,
                  value: cats['travel'],
                  maxAmount: maxAmount,
                  appState: appState,
                ),
                buildChartBarHorizontal(
                  icon: sessionData.maincats['experience'].icon,
                  value: cats['experience'],
                  maxAmount: maxAmount,
                  appState: appState,
                ),
                buildChartBarHorizontal(
                  icon: sessionData.maincats['other'].icon,
                  value: cats['other'],
                  maxAmount: maxAmount,
                  appState: appState,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChartBarHorizontal(
      {IconData icon, double value, double maxAmount, AppState appState}) {
    if (maxAmount < 1) return Container();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ChartBarHorizontal(
        complyColor: appState.cols.chartbar1,
        exceedColor: appState.cols.chartbar1,
        valueColor: appState.cols.chartValue,
        labelColor: appState.cols.boxcontent,
        labelBackColor: appState.cols.box,
        showAmountAbove: value / maxAmount < 0.18,
        label: Icon(
          icon,
          color: appState.cols.boxcontent,
        ),
        threshold1: maxAmount,
        threshold2: maxAmount,
        value: value,
      ),
    );
  }
}
