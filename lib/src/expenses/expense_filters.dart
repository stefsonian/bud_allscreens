import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/expense_list_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final hashtagController = ExpandableController(initialExpanded: false);
    final categoriesController = ExpandableController(initialExpanded: false);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ExpandableTheme(
        data: ExpandableThemeData(
          iconPadding: EdgeInsets.only(bottom: 3),
          iconColor: appState.cols.content,
          animationDuration: const Duration(milliseconds: 500),
          iconSize: 30,
          tapHeaderToExpand: true,
          tapBodyToCollapse: false,
          tapBodyToExpand: false,
        ),
        child: ExpandableNotifier(
          child: ScrollOnExpand(
            child: ListView(
              children: <Widget>[
                FilterHashtags(controller: hashtagController),
                SizedBox(height: 30),
                FilterMainCategories(controller: categoriesController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterHashtags extends StatelessWidget {
  const FilterHashtags({Key key, this.controller}) : super(key: key);
  final ExpandableController controller;

  @override
  Widget build(BuildContext context) {
    final listState = Provider.of<ExpenseListState>(context);
    return ExpandablePanel(
      controller: controller,
      header: FilterHeader(label: 'Hashtags', key: UniqueKey()),
      collapsed: Container(),
      expanded: Column(
        children: listState.filterHashtags.entries
            .map((t) => FilterCheckBox(
                  label: t.key,
                  icon: Icons.label_outline,
                  id: t.key,
                  isChecked: t.value,
                  onChanged: (newVal) =>
                      listState.updateFilterHashtag(t.key, newVal),
                ))
            .toList(),
      ),
    );
  }
}

class FilterMainCategories extends StatelessWidget {
  const FilterMainCategories({Key key, this.controller}) : super(key: key);
  final ExpandableController controller;

  @override
  Widget build(BuildContext context) {
    final listState = Provider.of<ExpenseListState>(context);
    return ExpandablePanel(
      controller: controller,
      header: FilterHeader(label: 'Categories', key: UniqueKey()),
      collapsed: Container(),
      expanded: Column(
        children: listState.filterMainCategories.entries
            .map((mc) => FilterCheckBox(
                  label: mc.key.name,
                  icon: mc.key.icon,
                  id: mc.key.id,
                  isChecked: mc.value,
                  onChanged: (newVal) =>
                      listState.updateFilterMainCategory(mc.key, newVal),
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
      this.onChanged,
      this.isGroupLeader = false})
      : super(key: key);
  final bool isChecked;
  final String label;
  final IconData icon;
  final String id;
  final Function onChanged;
  final bool isGroupLeader;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: appState.cols.content,
      ),
      child: CheckboxListTile(
        title: Text(label, style: TextStyle(color: appState.cols.content)),
        value: isChecked,
        onChanged: (bool value) => onChanged(value),
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
