import 'package:allscreens/src/components/Ikon_button.dart';
import 'package:allscreens/src/components/content_box.dart';
import 'package:allscreens/src/components/gradient_box_simple.dart';
import 'package:flutter/material.dart';
import 'package:allscreens/src/helpers/colors.dart';

class DisplayCategories extends StatelessWidget {
  const DisplayCategories({Key key, this.mainIcon, this.subIcon, this.label})
      : super(key: key);
  final IconData mainIcon;
  final IconData subIcon;
  final String label;

  Widget build(BuildContext context) {
    return ContentBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IkonButton(
            icon: mainIcon,
            color: Colors.white,
            backColor: col_aqua,
            size: 44.0,
            elevation: 0.0,
          ),
          // SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: col_aqua,
            ),
          ),
          IkonButton(
            icon: subIcon,
            color: Colors.white,
            backColor: col_aqua,
            size: 44.0,
            elevation: 0.0,
          ),
        ],
      ),
    );
  }
}