import 'package:allscreens/src/components/bar_indicator.dart';
import 'package:allscreens/src/components/info_bubble.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/home_state.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'dart:math';

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
  HomeState homeState;

  didChangeDependencies() {
    super.didChangeDependencies();
    homeState = Provider.of<HomeState>(context);
  }

  double get barWidth {
    if (homeState.dayBudget <= 0.0) return 1.0; // handle zero-division
    return min(homeState.daySpend / homeState.dayBudget, 1.0);
  }

  testSetDaySpend() {
    double r = max(Random().nextDouble() * homeState.dayBudget, 20);
    homeState.daySpend = r; // for testing only
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: testSetDaySpend,
          child: BarIndicator(
            fillRatio: barWidth,
            color: col_purple,
            height: 40,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InfoBubble(
              text1: 'Spend: \$77',
              backcolor: col_purple,
              textcolor: Colors.white,
              width: 150.0,
            ),
            InfoBubble(
              text1: 'Budget: \$100',
              backcolor: col_purple.withOpacity(0.4),
              textcolor: Colors.white,
              width: 150.0,
            ),
          ],
        )
      ],
    );
  }
}
