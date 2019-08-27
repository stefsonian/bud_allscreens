import 'package:allscreens/src/components/Ikon_button.dart';
import 'package:allscreens/src/components/gradient_box_simple.dart';
import 'package:flutter/material.dart';
import 'package:allscreens/src/helpers/colors.dart';

class RecordOther extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80),
      child: GradientBoxSimple(
        col1: Colors.green[200],
        col2: Colors.green,
        child: Row(
          children: <Widget>[
            Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 1.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
