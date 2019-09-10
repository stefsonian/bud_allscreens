import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

const List<IconData> icons = [
  Icons.restaurant,
  Icons.hotel,
  Icons.train,
  Icons.camera_alt,
  Icons.scatter_plot
];
const List<String> amounts = ['\$33', '\$76', '\$7', '\$25', '\$4'];

class BudgetToday extends StatefulWidget {
  @override
  _BudgetTodayState createState() => _BudgetTodayState();
}

class _BudgetTodayState extends State<BudgetToday> {
  int _counter = 72;

  @override
  Widget build(BuildContext context) {
    var data = [
      new ClicksPerYear('2016', 12, Colors.red),
      // new ClicksPerYear('2017', 42, Colors.yellow),
      // new ClicksPerYear('2018', _counter, Colors.green),
    ];

    var series = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
      vertical: false,
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
      domainAxis: charts.OrdinalAxisSpec(
          // don't show the domain axis line.
          showAxisLine: false,
          // And don't draw anything else.
          renderSpec: charts.NoneRenderSpec()),
    );

    var chartWidget = ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: 90.0,
        child: chart,
      ),
    );

    return chartWidget;
  }
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class BudgetIcon extends StatelessWidget {
  const BudgetIcon({Key key, this.icon, this.amount}) : super(key: key);
  final IconData icon;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Icon(icon),
          ),
        ),
        SizedBox(height: 5),
        Text(amount, textScaleFactor: 0.8),
      ],
    );
  }
}
