import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/expense_list_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'expenses_list.dart';

class ExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final records = Provider.of<Records>(context);
    final appState = Provider.of<AppState>(context);
    if (records.full.isEmpty) return buildExpensesRequired(appState);
    return ExpensesList();
  }

  Widget buildExpensesRequired(AppState appState) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Text(
          'Tap + to add a an expense',
          style: TextStyle(
            color: appState.cols.content,
            fontSize: 20,
            letterSpacing: 1.6,
          ),
        ),
      ),
    );
  }
}
