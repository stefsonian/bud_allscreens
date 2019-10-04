import 'package:flutter/material.dart';

import 'expenses_list.dart';

class ExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpensesList(),
    );
  }
}
