import 'package:allscreens/src/components/Ikon_button.dart';
import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/helpers/colors.dart';
import 'package:flutter/material.dart';

class FrontRecent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _activityRow(Icons.restaurant, 'Breakfast', '\$12.44'),
                _activityRow(Icons.fastfood, 'Snack', '\$3.50'),
                _activityRow(Icons.camera_alt, 'Tour', '\$50.00'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _activityRow(IconData icon, String label, String price) {
    return Row(
      children: <Widget>[
        Icon(icon, color: Colors.white),
        SizedBox(width: 16),
        Text(
          label,
          style:
              TextStyle(fontSize: 16, color: Colors.white, letterSpacing: 1.1),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              price,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        // SizedBox(width: 20),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 6, 0, 6),
          child: IkonButton(
            backColor: col_orange,
            color: Colors.white,
            icon: Icons.add,
            onTap: () {},
            size: 30,
          ),
        ),
      ],
    );
  }
}
