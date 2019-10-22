import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/front/budget_bar_horiz.dart';
import 'package:flutter/material.dart';

class FrontByPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ContentBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Spend by traveller (total AUD)',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 14),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: BudgetBarHoriz(
                      widthPct: 100, amount: '860', icon: Icons.account_circle),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: BudgetBarHoriz(
                      widthPct: 60, amount: '520', icon: Icons.account_circle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
