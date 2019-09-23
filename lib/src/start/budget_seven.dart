import 'package:allscreens/src/components/bar_indicator.dart';
import 'package:allscreens/src/components/info_bubble.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/home_state.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'dart:math';

class BudgetSeven extends StatefulWidget {
  @override
  _BudgetSevenState createState() => _BudgetSevenState();
}

class _BudgetSevenState extends State<BudgetSeven> {
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
              text1: 'Spend: \$689',
              backcolor: col_purple,
              textcolor: Colors.white,
              width: 150.0,
            ),
            InfoBubble(
              text1: 'Budget: \$700',
              backcolor: col_purple.withOpacity(0.4),
              textcolor: Colors.white,
              width: 150.0,
            ),
          ],
        ),
      ],
    );
  }
}
