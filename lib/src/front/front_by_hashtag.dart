import 'dart:math';
import 'package:eatsleeptravel/src/components/chart_bar_horizontal.dart';
import 'package:eatsleeptravel/src/components/content_box.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/models/Currency.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class FrontByHashtag extends StatelessWidget {
  const FrontByHashtag({Key key, this.currency}) : super(key: key);
  final Currency currency;
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    var records = Provider.of<Records>(context);
    var sessionData = Provider.of<SessionData>(context);
    // var end = Jiffy(DateTime.now()).endOf('day');
    // var start = Jiffy(end.subtract(Duration(days: 29))).startOf('day');
    var start = sessionData.trip.startDT;
    var end = Jiffy(DateTime.now()).endOf('day');
    var mapTotals = records.totalByHashtag(
      currencyId: currency.id,
      start: start,
      end: end,
    );
    if (mapTotals.isEmpty) return Container();
    var listTotals =
        Utils().sortMapByDoubleValue(m: mapTotals).take(10).toList();
    var maxAmount = mapTotals.values.reduce(max).ceilToDouble();
    List<Widget> chartBars = listTotals.map((m) {
      var hashTag = m.keys.single;
      var value = m.values.single;
      return buildChartBarHorizontal(
        hashtag: hashTag,
        amount: value,
        maxAmount: maxAmount,
        appState: appState,
      );
    }).toList();
    return Container(
      child: ContentBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Top 10 hashtag totals (${end.difference(start).inDays + 1} days)',
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
              children: chartBars,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChartBarHorizontal(
      {String hashtag, double amount, double maxAmount, AppState appState}) {
    if (maxAmount < 1) return Container();
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
        labelBoxWidth: 110,
        barHeight: 46,
        showAmountAbove: amount / maxAmount < 0.35,
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
      ),
    );
  }
}
