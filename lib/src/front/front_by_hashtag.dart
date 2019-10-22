import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/front/budget_bar_horiz.dart';
import 'package:flutter/material.dart';

class FrontByHashtag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ContentBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Hashtag spend (total AUD)', style: TextStyle(fontSize: 16)),
            SizedBox(height: 14),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: BudgetBarHoriz(
                      widthPct: 100, amount: '344', label: '#yolo'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: BudgetBarHoriz(
                      widthPct: 80, amount: '236', label: '#coffee'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: BudgetBarHoriz(
                      widthPct: 40, amount: '117', label: '#beachday'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
