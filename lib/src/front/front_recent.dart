import 'package:allscreens/src/components/Ikon_button.dart';
import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:allscreens/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrontRecent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return Container(
      child: ContentBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Recent activity',
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.1,
                color: appState.cols.content,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _activityRow(
                    Icons.restaurant, 'Breakfast', '\$12.44', appState),
                _activityRow(Icons.fastfood, 'Snack', '\$3.50', appState),
                _activityRow(Icons.camera_alt, 'Tour', '\$50.00', appState),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _activityRow(
      IconData icon, String label, String price, AppState appState) {
    return Row(
      children: <Widget>[
        Icon(icon, color: appState.cols.content),
        SizedBox(width: 16),
        Text(
          label,
          style: TextStyle(
              fontSize: 16, color: appState.cols.content, letterSpacing: 1.1),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              price,
              style: TextStyle(fontSize: 16, color: appState.cols.content),
            ),
          ),
        ),
        // SizedBox(width: 20),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 6, 0, 6),
          child: IkonButton(
            backColor: appState.cols.action,
            color: appState.cols.actionContent,
            icon: Icons.add,
            onTap: () {},
            size: 30,
          ),
        ),
      ],
    );
  }
}
