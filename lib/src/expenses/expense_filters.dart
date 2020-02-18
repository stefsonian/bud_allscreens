import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/expense_list_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableTheme(
      data: ExpandableThemeData(
        iconColor: Colors.red,
        animationDuration: const Duration(milliseconds: 500),
        iconSize: 30,
        tapHeaderToExpand: true,
      ),
      child: ExpandableNotifier(
        child: ScrollOnExpand(
          child: ListView(
            children: <Widget>[
              FilterHashtags(),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterHashtags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listState = Provider.of<ExpenseListState>(context);
    return ExpandablePanel(
      header: FilterHeader(label: 'Hashtags'),
      collapsed: Container(),
      expanded: Column(
        // shrinkWrap: true,
        children: listState.filterHashtags.entries
            .map((t) => FilterCheckBox(
                  label: t.key,
                  icon: Icons.label_outline,
                  id: t.key,
                  isChecked: t.value,
                ))
            .toList(),
      ),
    );
  }
}

class FilterHeader extends StatelessWidget {
  const FilterHeader({Key key, this.icon, this.label}) : super(key: key);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      // padding: EdgeInsets.only(left: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(
          color: appState.cols.content,
          fontSize: 22,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class FilterCheckBox extends StatelessWidget {
  const FilterCheckBox(
      {Key key,
      this.isChecked,
      this.label,
      this.icon,
      this.id,
      this.isGroupLeader = false})
      : super(key: key);
  final bool isChecked;
  final String label;
  final IconData icon;
  final String id;
  final bool isGroupLeader;

  onChanged(ExpenseListState listState, String id, bool newVal) {
    listState.filterHashtags[id] = newVal;
  }

  @override
  Widget build(BuildContext context) {
    final listState = Provider.of<ExpenseListState>(context);
    final appState = Provider.of<AppState>(context);
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: appState.cols.content,
      ),
      child: CheckboxListTile(
        title: Text(label, style: TextStyle(color: appState.cols.content)),
        value: isChecked,
        onChanged: (bool value) => listState.filterHashtags[id] = value,
        checkColor: appState.cols.background2,
        activeColor: appState.cols.content,
        secondary: Icon(icon, color: appState.cols.content),
      ),
    );
  }
}

// class CategoryHeader extends StatelessWidget {
//   const CategoryHeader({Key key, this.icon, this.label}) : super(key: key);
//   final IconData icon;
//   final String label;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // padding: EdgeInsets.only(left: 12),
//       alignment: Alignment.centerLeft,
//       child: Text(
//         label,
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 22,
//           letterSpacing: 1.2,
//         ),
//       ),
//     );
//   }
// }

// class FilterCategories extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//         final records = Provider.of<Records>(context);
// final listState = Provider.of<ExpenseListState>(context);
//   final sessionData = Provider.of<SessionData>(context);
//     return ExpandablePanel(
//       header: FilterHeader(label: 'Hashtags'),
//       collapsed: Container(),
//       expanded: Column(
//         // shrinkWrap: true,
//         children: cbState.hashtags.entries
//             .map((t) => FilterCheckBox(label: t.key, id: t.key))
//             .toList()
//               ..insert(0, FilterCheckBox(label: 'All', id: 'all')),
//       ),
//     );
//   }
// }
