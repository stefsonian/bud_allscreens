import 'dart:math';
import 'package:eatsleeptravel/src/day/day_box.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/models/Currency.dart';
import 'package:eatsleeptravel/src/models/Expense.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseData {
  double amountInHome = 0.0;
  Currency homeCurrency;
  List<Expense> expenses;

  ExpenseData({this.expenses, this.homeCurrency}) {
    expenses.forEach((e) {
      amountInHome += e.getAmount(homeCurrency.id);
    });
  }
}

class DayItem extends StatelessWidget {
  const DayItem(
      {Key key,
      this.color,
      this.altColor,
      this.maxWidth,
      this.date,
      this.homeCurrency,
      this.expenses})
      : super(key: key);
  final Color color;
  final Color altColor;
  final double maxWidth;
  final DateTime date;
  final Currency homeCurrency;
  final List<Expense> expenses;

  // Map<String, ExpenseData> getData(Records records) {
  //   final hc = homeCurrency;
  //   Map<String, ExpenseData> result = {};
  //   var bf = expenses.where((e) => e.subCategory.id == 'breakfast').toList();
  //   result['breakfast'] = ExpenseData(expenses: bf, homeCurrency: hc);
  //   var lunch = expenses.where((e) => e.subCategory.id == 'lunch').toList();
  //   result['lunch'] = ExpenseData(expenses: lunch, homeCurrency: hc);
  //   var dinner = expenses.where((e) => e.subCategory.id == 'dinner').toList();
  //   result['dinner'] = ExpenseData(expenses: dinner, homeCurrency: hc);
  //   var explore = expenses.where((e) => e.subCategory.id == 'explore').toList();
  //   result['explore'] = ExpenseData(expenses: explore, homeCurrency: hc);
  //   var sleep = expenses.where((e) => e.subCategory.id == 'sleep').toList();
  //   result['sleep'] = ExpenseData(expenses: sleep, homeCurrency: hc);
  //   var other = expenses.where((e) => e.mainCategory.id == 'other').toList();
  //   result['other'] = ExpenseData(expenses: other, homeCurrency: hc);
  //   return result;
  // }

  @override
  Widget build(BuildContext context) {
    final records = Provider.of<Records>(context);
    final totalAmount =
        expenses.fold(0.0, (a, b) => a + b.getAmount(homeCurrency.id));
    // final data = getData(records);

    return Container(
      // padding: EdgeInsets.only(top: topPadding),
      // height: itemHeight,
      height: 650,
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
                _totalBox(color, altColor, totalAmount, homeCurrency),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _expenseEntry(
                    color: altColor,
                    btnColor: color,
                    label: 'Eat',
                    icon: Icons.restaurant,
                    exps: expenses
                        .where((e) => e.mainCategory.id == 'eat')
                        .toList(),
                  ),
                  _expenseEntry(
                    color: altColor,
                    btnColor: color,
                    label: 'Sleep',
                    icon: Icons.hotel,
                    exps: expenses
                        .where((e) => e.mainCategory.id == 'sleep')
                        .toList(),
                  ),
                  _expenseEntry(
                    color: altColor,
                    btnColor: color,
                    label: 'Travel',
                    icon: Icons.local_dining,
                    exps: expenses
                        .where((e) => e.mainCategory.id == 'travel')
                        .toList(),
                  ),
                  _expenseEntry(
                    color: altColor,
                    btnColor: color,
                    label: 'Explore',
                    icon: Icons.camera_alt,
                    exps: expenses
                        .where((e) => e.mainCategory.id == 'explore')
                        .toList(),
                  ),
                  _expenseEntry(
                    color: altColor,
                    btnColor: color,
                    label: 'Other',
                    icon: Icons.scatter_plot,
                    exps: expenses
                        .where((e) => e.mainCategory.id == 'other')
                        .toList(),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expenseEntry({
    Color color,
    Color btnColor,
    String label,
    IconData icon,
    List<Expense> exps,
  }) {
    double totalAmount =
        exps.fold(0.0, (a, b) => a + b.getAmount(homeCurrency.id));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(icon, color: color, size: 34),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 22,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                // width: 90,
                alignment: Alignment.centerRight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        '${homeCurrency.symbolNative} ',
                        style: TextStyle(
                          fontSize: 13,
                          color: color,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      Utils().formattedAmount(
                          amount: totalAmount, preferredDecimals: 2),
                      style: TextStyle(
                        fontSize: 22,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: <Widget>[
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 8,
                  spacing: 12,
                  children:
                      exps.map((e) => expensePill(color, btnColor, e)).toList(),
                ),
              ),
            ],
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
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _totalBox(
      Color textColor, Color backColor, double amount, Currency homeCurrency) {
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                '${homeCurrency.code} ${homeCurrency.symbolNative} ',
                style: TextStyle(
                  fontSize: 13,
                  color: color,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              Utils().formattedAmount(amount: amount, preferredDecimals: 2),
              style: TextStyle(
                fontSize: 22,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget expensePill(Color color1, Color color2, Expense exp) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 24,
            width: 28,
            padding: EdgeInsets.fromLTRB(7, 3, 4, 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(90),
                bottomLeft: Radius.circular(90),
              ),
              color: color1,
              border: Border.all(width: 1, color: color1),
            ),
            // child: Text(
            //   exp.subCategory.name,
            //   style: TextStyle(
            //     color: color2,
            //     fontSize: 10,
            //   ),
            // ),
            child: FittedBox(child: Icon(exp.subCategory.icon, color: color2)),
          ),
          Container(
            height: 24,
            width: 70,
            padding: EdgeInsets.fromLTRB(6, 5, 6, 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(90),
                bottomRight: Radius.circular(90),
              ),
              color: color2,
              border: Border.all(width: 1, color: color1),
            ),
            child: Center(
              child: Text(
                '${exp.currency.code} ${exp.getAmountString(exp.currencyId)}',
                style: TextStyle(
                  color: color1,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
