import 'package:allscreens/src/components/info_bubble.dart';
import 'package:allscreens/src/front/budget_bar.dart';
import 'package:allscreens/src/front/budget_bar_box.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FrontStats extends StatefulWidget {
  @override
  _FrontStatsState createState() => _FrontStatsState();
}

class _FrontStatsState extends State<FrontStats> {
  var budget = 100.0;
  List<BudgetBar> budgetBars = [];

  @override
  void initState() {
    super.initState();
    createTestData();
  }

  createTestData() {
    List<BudgetBar> bb = [];
    List<double> spends = [];
    for (var i = 0; i < 100; i++) {
      double spend = budget * 1.3 * Random().nextDouble();
      spends.add(spend);
    }

    spends.forEach((spend) {
      double height = spend / spends.reduce(max) * 100;
      double overRatio = spend <= budget ? 0.0 : budget / spend;
      bb.add(BudgetBar(heightPct: height.toInt(), ratioOver: overRatio));
    });

    setState(() => budgetBars.addAll(bb));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      padding: EdgeInsets.all(14),
      // height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: kElevationToShadow[1],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('Daily'),
                  Icon(Icons.expand_more),
                ],
              ),
              InfoBubble(
                backcolor: col_aqua,
                textcolor: Colors.white,
                text1: 'Budget  ',
                text2: '\$100',
              ),
              Row(
                children: <Widget>[
                  Text('AUD'),
                  Icon(Icons.expand_more),
                ],
              ),
            ],
          ),
          SizedBox(height: 2),
          Expanded(
            child: BudgetBarBox(
              budgetBars: budgetBars,
            ),
          ),
        ],
      ),
    );
  }
}

const Color col1 = Color(0xFF56ab2f);
const Color col2 = Color(0xFFa8e063);

final BoxDecoration _boxDecor = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0, 1],
    colors: [col1.withOpacity(0.8), col2],
  ),
  borderRadius: BorderRadius.circular(16),
  // boxShadow: kElevationToShadow[1],
);
