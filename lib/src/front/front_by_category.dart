import 'dart:math';
import 'package:eatsleeptravel/src/components/chart_bar_horizontal.dart';
import 'package:eatsleeptravel/src/components/content_box.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/models/Currency.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class FrontByCategory extends StatelessWidget {
  const FrontByCategory({Key key, this.currency}) : super(key: key);
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    var records = Provider.of<Records>(context);
    var sessionData = Provider.of<SessionData>(context);
    var end = Jiffy(DateTime.now()).endOf('day');
    var start = Jiffy(end.subtract(Duration(days: 6))).startOf('day');
    var cats = records.totalByMainCat(
      currencyId: currency.id,
      start: start,
      end: end,
    );
    var maxAmount = cats.values.reduce(max).ceilToDouble();
    maxAmount = max(1.0, maxAmount); // prevent 0-division
    return Container(
      child: ContentBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Last 7 days by category',
                style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.bold,
                    color: appState.cols.content),
              ),
            ),
            SizedBox(height: 18),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildChartBarHorizontal(
                  icon: sessionData.maincats['eat'].icon,
                  amount: cats['eat'],
                  maxAmount: maxAmount,
                  appState: appState,
                ),
                buildChartBarHorizontal(
                  icon: sessionData.maincats['sleep'].icon,
                  amount: cats['sleep'],
                  maxAmount: maxAmount,
                  appState: appState,
                ),
                buildChartBarHorizontal(
                  icon: sessionData.maincats['travel'].icon,
                  amount: cats['travel'],
                  maxAmount: maxAmount,
                  appState: appState,
                ),
                buildChartBarHorizontal(
                  icon: sessionData.maincats['explore'].icon,
                  amount: cats['explore'],
                  maxAmount: maxAmount,
                  appState: appState,
                ),
                buildChartBarHorizontal(
                  icon: sessionData.maincats['other'].icon,
                  amount: cats['other'],
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
      {IconData icon, double amount, double maxAmount, AppState appState}) {
    if (maxAmount < 1) return Container();
    if (amount == null) amount = 0.0;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ChartBarHorizontal(
        formattedValue: Utils().formattedCurrency(amount, currency),
        exceedsChartMax: false,
        scaledBarWidth: amount / maxAmount,
        barColor: appState.cols.chartbar1,
        valueColor: appState.cols.chartvalue,
        labelColor: appState.cols.boxcontent,
        labelBackColor: appState.cols.box,
        showAmountAbove: amount / maxAmount < 0.25,
        barHeight: 46,
        label: Icon(icon, color: appState.cols.boxcontent),
      ),
    );
  }
}
