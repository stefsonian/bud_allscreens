import 'package:allscreens/src/components/Ikon_button.dart';
import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/day/day_box.dart';
import 'package:flutter/material.dart';

class DayItem extends StatelessWidget {
  const DayItem(
      {Key key, this.itemHeight, this.color, this.altColor, this.maxWidth})
      : super(key: key);
  final double itemHeight;
  final Color color;
  final Color altColor;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: topPadding),
      height: itemHeight,
      width: maxWidth,
      decoration: BoxDecoration(
        color: altColor,
      ),
      child: DayBox(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _dateBox(color, altColor),
                _totalBox(color, altColor),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _expenseEntry(altColor, color, Icons.camera, 'Breakfast',
                      '\$18.00', "I'm just a little note"),
                  _expenseEntry(altColor, color, Icons.camera, 'Lunch', '', ""),
                  _expenseEntry(altColor, color, Icons.camera, 'Dinner',
                      '\$50.00', "I'm just a little note"),
                  _expenseEntry(
                      altColor,
                      color,
                      Icons.camera,
                      'Sleep',
                      '\$48.00',
                      "I'm just a little note - and this is what happens when I'm a lot bigger than the other little notes"),
                  _expenseEntry(altColor, color, Icons.camera, 'Other',
                      '\$37.00', "Train 12 | Bus 4 | Tour 21"),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expenseEntry(Color color, Color btnColor, IconData icon, String label,
      String amount, String note) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: 44),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // LayoutBuilder(builder: (context, constraints) {
                //   print('h2: ${constraints.maxHeight}');
                //   print('w2: ${constraints.maxWidth}');
                //   return Container();
                // }),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 22,
                    color: color,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 2),
                  child: note == ""
                      ? Container()
                      : Text(
                          note,
                          style: TextStyle(
                              fontSize: 14, color: color.withOpacity(0.7)),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                ),
              ],
            ),
          ),
          amount == ""
              ? Container(
                  width: 90,
                  alignment: Alignment.center,
                  constraints: BoxConstraints.tightFor(width: 42, height: 42),
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: color,
                    foregroundColor: btnColor,
                    onPressed: () {},
                  ),
                )
              : Container(
                  width: 90,
                  alignment: Alignment.centerRight,
                  child: Text(
                    amount,
                    style: TextStyle(
                      fontSize: 22,
                      color: color,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _dateBox(Color textColor, Color backColor) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.fromLTRB(8, 10, 16, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(100),
              bottomRight: Radius.circular(100),
            ),
            color: backColor),
        child: Text(
          'Fri 27 Aug 19',
          style: TextStyle(
              fontSize: 22,
              letterSpacing: 1.1,
              wordSpacing: 1.5,
              color: textColor),
        ),
      ),
    );
  }

  Widget _totalBox(Color textColor, Color backColor) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.fromLTRB(16, 10, 8, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              bottomLeft: Radius.circular(100),
            ),
            color: backColor),
        child: Text(
          '\$175.50',
          style: TextStyle(
              fontSize: 22,
              letterSpacing: 1.1,
              wordSpacing: 1.5,
              color: textColor),
        ),
      ),
    );
  }
}
