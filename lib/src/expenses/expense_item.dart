import 'package:allscreens/src/components/Ikon_button.dart';
import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/models/Expense.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:allscreens/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({Key key, this.expense}) : super(key: key);
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return ContentBox(
      padding: EdgeInsets.fromLTRB(0, 6, 12, 6),
      child: Row(
        children: <Widget>[
          IkonButton(
            backColor: Colors.transparent,
            color: appState.cols.content,
            elevation: 0.0,
            icon: expense.subCategory.icon,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  expense.subCategory.name,
                  style: TextStyle(
                    fontSize: 16,
                    color: appState.cols.content,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                  overflow: TextOverflow.fade,
                ),
                Text(
                  expense.dayMonthYear,
                  style: TextStyle(
                    fontSize: 13,
                    color: appState.cols.content,
                    letterSpacing: 1.1,
                  ),
                ),
                // LayoutBuilder(builder: (context, constraints) {
                //   print('h2: ${constraints.maxHeight}');
                //   print('w2: ${constraints.maxWidth}');
                //   return Container();
                // }),
                expense.note == null
                    ? Container()
                    : Text(
                        "I'm just a little note but I'm very important. It's good I'm here",
                        style: TextStyle(
                          fontSize: 13,
                          color: appState.cols.content,
                          letterSpacing: 1.1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
              ],
            ),
          ),
          Container(
            width: 90,
            alignment: Alignment.centerRight,
            child: Text(
              '\$${expense.amount.value.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                color: appState.cols.content,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
