import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/front/budget_bar_horiz.dart';
import 'package:flutter/material.dart';

class FrontByCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ContentBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Category spend (total AUD)', style: TextStyle(fontSize: 16)),
            SizedBox(height: 14),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: BudgetBarHoriz(
                    widthPct: 80,
                    amount: '143',
                    icon: Icons.restaurant,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: BudgetBarHoriz(
                    widthPct: 100,
                    amount: '230',
                    icon: Icons.hotel,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: BudgetBarHoriz(
                    widthPct: 40,
                    amount: '76',
                    icon: Icons.train,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: BudgetBarHoriz(
                    widthPct: 70,
                    amount: '123',
                    icon: Icons.camera_alt,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: BudgetBarHoriz(
                    widthPct: 20,
                    amount: '40',
                    icon: Icons.scatter_plot,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
