import 'package:eatsleeptravel/src/components/Ikon_button.dart';
import 'package:eatsleeptravel/src/components/content_box.dart';
import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/models/Currency.dart';
import 'package:eatsleeptravel/src/models/Expense.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({Key key, this.expense}) : super(key: key);
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final records = Provider.of<Records>(context);
    final sessionData = Provider.of<SessionData>(context);
    return Container(
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
                (expense.note == null || expense.note.isEmpty)
                    ? Container()
                    : Text(
                        expense.note,
                        style: TextStyle(
                          fontSize: 13,
                          color: appState.cols.content.withOpacity(0.7),
                          letterSpacing: 1.1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _buildAmountLocalCur(records, appState),
              _buildAmountHomeCur(records, appState, sessionData),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountLocalCur(Records records, AppState appState) {
    Currency currency = records.getCurrency(expense.currencyId);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Text(
              '${currency.code} ${currency.symbolNative}',
              style: TextStyle(
                fontSize: 10,
                color: appState.cols.content,
              ),
            ),
          ),
          Text(
            Utils().formattedAmount(
              amount: expense.amount,
              // preferredDecimals: 2,
            ),
            style: TextStyle(
              fontSize: 18,
              color: appState.cols.content,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountHomeCur(
      Records records, AppState appState, SessionData sessionData) {
    Currency currency = records.getCurrency(sessionData.user.homeCurrency);
    return Container(
      padding: EdgeInsets.only(right: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 1),
            child: Text(
              '${currency.code} ${currency.symbolNative} ',
              style: TextStyle(
                fontSize: 8,
                color: appState.cols.content.withOpacity(0.65),
              ),
            ),
          ),
          Text(
            Utils().formattedAmount(
              amount: expense.getAmount(currency.id),
            ),
            style: TextStyle(
              fontSize: 12,
              color: appState.cols.content.withOpacity(0.65),
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
