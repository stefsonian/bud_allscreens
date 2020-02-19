import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/expense_list_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesOrderBy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final listState = Provider.of<ExpenseListState>(context);
    final orderBy = listState.orderBy.keys.single;
    final asc = listState.orderBy.values.single == 'ascending';
    final Color color = appState.cols.content.withOpacity(0.6);
    final Color selectedColor = appState.cols.content;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView(
        children: <Widget>[
          _buildOption(
            label: 'Date & time',
            asc: (orderBy == 'expenseDT' && asc),
            desc: (orderBy == 'expenseDT' && !asc),
            color: color,
            selectedColor: selectedColor,
            onAscTap: () => listState.orderBy = {'expenseDT': 'ascending'},
            onDescTap: () => listState.orderBy = {'expenseDT': 'descending'},
          ),
          _buildOption(
            label: 'Category',
            asc: (orderBy == 'category' && asc),
            desc: (orderBy == 'category' && !asc),
            color: color,
            selectedColor: selectedColor,
            onAscTap: () => listState.orderBy = {'category': 'ascending'},
            onDescTap: () => listState.orderBy = {'category': 'descending'},
          ),
          _buildOption(
            label: 'Amount',
            asc: (orderBy == 'amount' && asc),
            desc: (orderBy == 'amount' && !asc),
            color: color,
            selectedColor: selectedColor,
            onAscTap: () => listState.orderBy = {'amount': 'ascending'},
            onDescTap: () => listState.orderBy = {'amount': 'descending'},
          )
        ],
      ),
    );
  }

  Widget _buildOption({
    String label,
    bool asc,
    bool desc,
    Color color,
    Color selectedColor,
    Function onAscTap,
    Function onDescTap,
  }) {
    var labelColor = (asc || desc) ? selectedColor : color;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                child: Text(
                  label,
                  style: _textStyle(labelColor, (asc || desc)),
                  textAlign: TextAlign.start,
                ),
                onPressed: asc ? onDescTap : onAscTap,
              ),
            ),
          ),
          RotatedBox(
            quarterTurns: 2,
            child: IconButton(
              icon: Icon(
                Icons.sort,
                color: asc ? selectedColor : color,
              ),
              onPressed: onAscTap,
            ),
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(
              Icons.sort,
              color: desc ? selectedColor : color,
            ),
            onPressed: onDescTap,
          ),
        ],
      ),
    );
  }
}

TextStyle _textStyle(Color color, bool isBold) {
  return TextStyle(
    color: color,
    fontSize: 22,
    letterSpacing: 1.2,
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  );
}
