import 'package:allscreens/src/components/Ikon_button.dart';
import 'package:allscreens/src/components/gradient_box_simple.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/record_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordSubmit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RecordState recordState = Provider.of<RecordState>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IkonButton(
              color: col_orange_dark,
              backColor: Colors.white,
              icon: Icons.delete,
              onTap: () => recordState.reset(),
            ),
            IkonButton(
              color: col_aqua,
              backColor: Colors.white,
              icon: Icons.check,
              size: 120.0,
              onTap: () => recordState.reset(),
            ),
          ],
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
