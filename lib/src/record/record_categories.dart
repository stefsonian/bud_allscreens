import 'package:allscreens/src/components/gradient_box.dart';
import 'package:flutter/material.dart';

class RecordCategories extends StatefulWidget {
  @override
  _RecordCategoriesState createState() => _RecordCategoriesState();
}

class _RecordCategoriesState extends State<RecordCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16), //replace with safearea
      padding: EdgeInsets.all(14),
      child: Column(
        children: <Widget>[
          GradientBox(
            name: 'Expense summary',
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}
