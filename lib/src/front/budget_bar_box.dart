import 'package:eatsleeptravel/src/components/chart_bar_vertical.dart';
import 'package:eatsleeptravel/src/front/budget_bar.dart';
import 'package:flutter/material.dart';

class BudgetBarBox extends StatelessWidget {
  const BudgetBarBox({Key key, this.budgetBars}) : super(key: key);
  final List<ChartBarVertical> budgetBars;

  @override
  Widget build(BuildContext context) {
    // print(budgetBars.length);
    return ListView.builder(
      reverse: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(8),
      itemCount: budgetBars.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: budgetBars[index],
        );
      },
    );
  }
}
